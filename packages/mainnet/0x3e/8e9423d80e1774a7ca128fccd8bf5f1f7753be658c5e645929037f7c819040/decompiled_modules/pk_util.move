module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util {
    public(friend) fun is_valid_key(arg0: &vector<u8>) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = &v1;
        *v2 == 33 && v0 == 0 || *v2 == 34 && (v0 == 1 || v0 == 2)
    }

    public fun validate_pks(arg0: &vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(arg0) > 0, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            assert!(is_valid_key(0x1::vector::borrow<vector<u8>>(arg0, v0)), 1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

