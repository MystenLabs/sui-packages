module 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::examples3 {
    fun example(arg0: &0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::Rectangle) : u64 {
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::rectangle_base(arg0) * 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::Rectangle) : u64 {
        0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::rectangle_base(arg0) * 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

