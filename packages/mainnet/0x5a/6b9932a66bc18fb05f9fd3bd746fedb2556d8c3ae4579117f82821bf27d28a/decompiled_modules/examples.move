module 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::examples {
    fun examples<T0>(arg0: 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::Cup<T0>) : T0 {
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::borrow<T0>(&arg0);
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::borrow_mut<T0>(&mut arg0);
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::Cup<T0>) : T0 {
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::borrow<T0>(&arg0);
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::borrow_mut<T0>(&mut arg0);
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

