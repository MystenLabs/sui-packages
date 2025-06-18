module 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::utils_test {
    fun create_vector(arg0: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

