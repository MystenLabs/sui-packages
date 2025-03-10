module 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::utils_test {
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

