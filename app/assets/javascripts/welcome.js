$( document ).ready(function() {
    console.log('2');
    //var canvas  = $('#webglcanvas');
         var canvas = document.getElementById("webglcanvas");
        console.log('a');
        //var gl = initWebGL(canvas);
        var gl = canvas.getContext("experimental-webgl");
      
        console.log('gl: ', gl );
        console.log('canvas: ', canvas );
        console.log('b');
        initViewport(gl, canvas);
        console.log('c');
        initMatrices();
        console.log('d');
        var square = createSquare(gl);
        console.log('e');
        initShader(gl);
        console.log('f');
        draw(gl, square);
        console.log('g');
    console.log('100');

    function initWebGL(canvas) {
        console.log('initWebGL a');

        var gl;
        try 
        {
            gl = canvas.getContext("experimental-webgl");
            //gl = canvas.getContext("2d");
        } 
        catch (e)
        {
            var msg = "Error creating WebGL Context!: " + e.toString();
            alert(msg);
            throw Error(msg);
        }

        return gl;        
     }

    function initViewport(gl, canvas)
    {
        gl.viewport(0, 0, canvas.width, canvas.height);
    }

    var projectionMatrix, modelViewMatrix;

    function initMatrices()
    {
	   // The transform matrix for the square - translate back in Z for the camera
	   modelViewMatrix = new Float32Array(
	           [1, 0, 0, 0,
	            0, 1, 0, 0, 
	            0, 0, 1, 0, 
	            0, 0, -3.333, 1]);
       
	   // The projection matrix (for a 45 degree field of view)
	   projectionMatrix = new Float32Array(
	           [2.41421, 0, 0, 0,
	            0, 2.41421, 0, 0,
	            0, 0, -1.002002, -1, 
	            0, 0, -0.2002002, 0]);
	
    }

    // Create the vertex data for a square to be drawn
    function createSquare(gl) {
        var vertexBuffer;
    	vertexBuffer = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
        var verts = [
             .5,  .5,  0.0,
            -.5,  .5,  0.0,
             .5, -.5,  0.0,
            -.5, -.5,  0.0
        ];
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(verts), gl.STATIC_DRAW);
        var square = {buffer:vertexBuffer, vertSize:3, nVerts:4, primtype:gl.TRIANGLE_STRIP};
        return square;
    }

    function createShader(gl, str, type) {
        console.log('createShader 1');
        var shader;
        console.log('createShader 2');
        if (type == "fragment") {
            shader = gl.createShader(gl.FRAGMENT_SHADER);
        } else if (type == "vertex") {
            shader = gl.createShader(gl.VERTEX_SHADER);
        } else {
            return null;
        }
        console.log('createShader 3');

        gl.shaderSource(shader, str);
        gl.compileShader(shader);

        console.log('createShader 4 -- Error After here');
        if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
            console.log('createShader 4.1');
            alert(gl.getShaderInfoLog(shader));
            console.log('createShader 4.2');
            return null;
        }
        console.log('createShader 5');

        return shader;
    }
    
	var vertexShaderSource =
		
		"    attribute vec3 vertexPos;\n" +
		"    uniform mat4 modelViewMatrix;\n" +
		"    uniform mat4 projectionMatrix;\n" +
		"    void main(void) {\n" +
		"		// Return the transformed and projected vertex value\n" +
		"        gl_Position = projectionMatrix * modelViewMatrix * \n" +
		"            vec4(vertexPos, 1.0);\n" +
		"    }\n";

	var fragmentShaderSource = 
		"    void main(void) {\n" +
		"    // Return the pixel color: always output white\n" +
        "    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);\n" +
    	"}\n";


    var shaderProgram, shaderVertexPositionAttribute, shaderProjectionMatrixUniform, shaderModelViewMatrixUniform;

    function initShader(gl) {
        console.log('shader 1: ', gl);

    	// load and compile the fragment and vertex shader
        //var fragmentShader = getShader(gl, "fragmentShader");
        //var vertexShader = getShader(gl, "vertexShader");
        var fragmentShader = createShader(gl, fragmentShaderSource, "fragment");
        console.log('shader 2');
        var vertexShader = createShader(gl, vertexShaderSource, "vertex");
        console.log('shader 3');

        // link them together into a new program
        shaderProgram = gl.createProgram();
        gl.attachShader(shaderProgram, vertexShader);
        gl.attachShader(shaderProgram, fragmentShader);
        gl.linkProgram(shaderProgram);

        // get pointers to the shader params
        shaderVertexPositionAttribute = gl.getAttribLocation(shaderProgram, "vertexPos");
        gl.enableVertexAttribArray(shaderVertexPositionAttribute);
        
        shaderProjectionMatrixUniform = gl.getUniformLocation(shaderProgram, "projectionMatrix");
        shaderModelViewMatrixUniform = gl.getUniformLocation(shaderProgram, "modelViewMatrix");

        
        if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
            alert("Could not initialise shaders");
        }
    }

     function draw(gl, obj) {

         // clear the background (with black)
         gl.clearColor(0.0, 0.0, 0.0, 1.0);
         gl.clear(gl.COLOR_BUFFER_BIT);

    	 // set the vertex buffer to be drawn
         gl.bindBuffer(gl.ARRAY_BUFFER, obj.buffer);

         // set the shader to use
         gl.useProgram(shaderProgram);

 		// connect up the shader parameters: vertex position and projection/model matrices
         gl.vertexAttribPointer(shaderVertexPositionAttribute, obj.vertSize, gl.FLOAT, false, 0, 0);
         gl.uniformMatrix4fv(shaderProjectionMatrixUniform, false, projectionMatrix);
         gl.uniformMatrix4fv(shaderModelViewMatrixUniform, false, modelViewMatrix);

         // draw the object
         gl.drawArrays(obj.primtype, 0, obj.nVerts);
      }
          
});
