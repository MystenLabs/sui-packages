module 0xb39fe0c60c140063923a723f4e0e5bc008d1593ae3c6a71aa89fed5dc3546c15::solana {
    fun assert_pubkey_length(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
    }

    public(friend) fun build_spl_transfer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64) : vector<u8> {
        assert_pubkey_length(&arg0);
        assert_pubkey_length(&arg1);
        assert_pubkey_length(&arg2);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 1);
        assert_pubkey_length(&arg5);
        assert_pubkey_length(&arg6);
        assert_pubkey_length(&arg7);
        assert_pubkey_length(&arg8);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 10);
        0x1::vector::push_back<u8>(v1, 4);
        0x1::vector::push_back<u8>(v1, 4);
        0x1::vector::push_back<u8>(v1, 9);
        0x1::vector::push_back<u8>(v1, 3);
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 10);
        0x1::vector::push_back<u8>(v1, 12);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, arg3);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, x"0201060b");
        0x1::vector::push_back<vector<u8>>(v4, arg6);
        0x1::vector::push_back<vector<u8>>(v4, arg0);
        0x1::vector::push_back<vector<u8>>(v4, arg5);
        0x1::vector::push_back<vector<u8>>(v4, arg8);
        0x1::vector::push_back<vector<u8>>(v4, arg1);
        0x1::vector::push_back<vector<u8>>(v4, x"0000000000000000000000000000000000000000000000000000000000000000");
        0x1::vector::push_back<vector<u8>>(v4, x"06a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000");
        0x1::vector::push_back<vector<u8>>(v4, x"8c97258f4e2489f1bb3d1029148e0d830b5a1399daff1084048e7bd8dbe9f859");
        0x1::vector::push_back<vector<u8>>(v4, arg7);
        0x1::vector::push_back<vector<u8>>(v4, arg2);
        0x1::vector::push_back<vector<u8>>(v4, x"06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9");
        0x1::vector::push_back<vector<u8>>(v4, arg4);
        0x1::vector::push_back<vector<u8>>(v4, x"03");
        0x1::vector::push_back<vector<u8>>(v4, x"050302060004");
        0x1::vector::push_back<vector<u8>>(v4, x"04000000");
        0x1::vector::push_back<vector<u8>>(v4, x"070600030809050a0101");
        0x1::vector::push_back<vector<u8>>(v4, v0);
        0x1::vector::push_back<vector<u8>>(v4, u64_to_le_bytes(arg9));
        0x1::vector::push_back<vector<u8>>(v4, v2);
        0x1::vector::flatten<u8>(v3)
    }

    fun u64_to_le_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v6
}

