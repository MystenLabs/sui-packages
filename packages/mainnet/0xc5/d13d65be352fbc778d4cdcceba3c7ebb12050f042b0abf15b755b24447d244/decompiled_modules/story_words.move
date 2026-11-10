module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words {
    fun boundary(arg0: u8) : bool {
        if (whitespace(arg0)) {
            true
        } else if (arg0 == 33) {
            true
        } else if (arg0 == 44) {
            true
        } else if (arg0 == 46) {
            true
        } else if (arg0 == 58) {
            true
        } else if (arg0 == 59) {
            true
        } else {
            arg0 == 63
        }
    }

    public fun continue_word(arg0: &mut vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1) && !boundary(*0x1::vector::borrow<u8>(&arg1, v0))) {
            v0 = v0 + 1;
        };
        let v1 = v0 < 0x1::vector::length<u8>(&arg1);
        let v2 = if (v1 && !whitespace(*0x1::vector::borrow<u8>(&arg1, v0))) {
            1
        } else {
            0
        };
        let v3 = b"";
        let v4 = 0;
        while (v4 < v0 + v2) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg1, v4));
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(arg0, v3);
        v1
    }

    public fun ends_at_boundary(arg0: &vector<u8>) : bool {
        !0x1::vector::is_empty<u8>(arg0) && boundary(*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(arg0) - 1))
    }

    public fun trim_partial_word(arg0: &mut vector<u8>) {
        while (!0x1::vector::is_empty<u8>(arg0) && !boundary(*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(arg0) - 1))) {
            0x1::vector::pop_back<u8>(arg0);
        };
        trim_spaces(arg0);
    }

    public fun trim_spaces(arg0: &mut vector<u8>) {
        while (!0x1::vector::is_empty<u8>(arg0) && whitespace(*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(arg0) - 1))) {
            0x1::vector::pop_back<u8>(arg0);
        };
    }

    fun whitespace(arg0: u8) : bool {
        arg0 <= 32
    }

    // decompiled from Move bytecode v7
}

