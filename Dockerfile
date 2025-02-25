# Gunakan TensorFlow Serving sebagai base image
FROM tensorflow/serving:latest

# Salin model ke dalam container
COPY ./serving_model /models/serving_model

# Set environment variables untuk TensorFlow Serving
ENV MODEL_NAME=hearts-model
ENV MODEL_BASE_PATH=/models/serving_model
ENV PORT=8080

# Buat entrypoint script untuk menjalankan TensorFlow Serving
RUN echo '#!/bin/bash \n\n\
    env \n\
    tensorflow_model_server --port=8080 --rest_api_port=${PORT} \
    --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH} \
    "$@"' > /usr/bin/tf_serving_entrypoint.sh \
    && chmod +x /usr/bin/tf_serving_entrypoint.sh  

# Expose port untuk REST API
EXPOSE 8080
