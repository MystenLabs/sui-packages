module 0xb5376ae7fde346083f8fbb6e39a9b5850ff5a76287dbb8e536d32d1e29d103fc::y {
    public entry fun y_call_x(arg0: u64) {
        0x677bdf5f7a141fa036047fe72c7e601631ea39796b0c7d6e16dd9f9751231668::x::call_x_twice(arg0);
    }

    // decompiled from Move bytecode v6
}

