module 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::intake_receipt {
    public(friend) fun accept_message(arg0: address, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906834324667367427);
        let v0 = b"dopamint-arena::inplay::intake-accept::v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg10));
        v0
    }

    public fun domain() : vector<u8> {
        b"dopamint-arena::inplay::intake-accept::v1"
    }

    public(friend) fun u64_identity(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 24) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        v0
    }

    // decompiled from Move bytecode v7
}

