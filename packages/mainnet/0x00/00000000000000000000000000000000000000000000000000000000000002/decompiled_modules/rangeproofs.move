module 0x2::rangeproofs {
    public fun verify_bulletproofs_ristretto255(arg0: &vector<u8>, arg1: u8, arg2: &vector<0x2::group_ops::Element<0x2::ristretto255::G>>, arg3: u8) : bool {
        abort 0
    }

    public fun verify_bulletproofs_with_dst_ristretto255(arg0: &vector<u8>, arg1: u8, arg2: &vector<0x2::group_ops::Element<0x2::ristretto255::G>>, arg3: &vector<u8>, arg4: u8) : bool {
        assert!(0x1::vector::length<u8>(arg3) <= 64, 5);
        assert!(arg4 == 0, 4);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::group_ops::Element<0x2::ristretto255::G>>(arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, *0x2::group_ops::bytes<0x2::ristretto255::G>(0x1::vector::borrow<0x2::group_ops::Element<0x2::ristretto255::G>>(arg2, v1)));
            v1 = v1 + 1;
        };
        verify_bulletproofs_with_dst_ristretto255_internal(arg0, arg1, &v0, arg3)
    }

    native fun verify_bulletproofs_with_dst_ristretto255_internal(arg0: &vector<u8>, arg1: u8, arg2: &vector<vector<u8>>, arg3: &vector<u8>) : bool;
    // decompiled from Move bytecode v7
}

