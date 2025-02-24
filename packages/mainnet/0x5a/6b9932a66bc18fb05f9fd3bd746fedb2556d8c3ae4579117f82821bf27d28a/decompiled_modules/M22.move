module 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 0
    }

    // decompiled from Move bytecode v6
}

