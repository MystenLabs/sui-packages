module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_solana {
    fun assert_system_program(arg0: &vector<u8>) {
        let v0 = 0;
        while (v0 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, v0) == 0, 3);
            v0 = v0 + 1;
        };
    }

    public(friend) fun verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u128) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 1);
        assert!(0x1::vector::length<u8>(arg2) == 32, 5);
        let v0 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::new(*arg0);
        let v1 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v0);
        assert!(v1 & 128 == 0, 0);
        assert!(v1 == 1, 7);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v0);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v0);
        let v2 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(&mut v0);
        assert!(v2 >= 2 && v2 <= 16, 1);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0;
        while (v4 < v2) {
            0x1::vector::push_back<vector<u8>>(&mut v3, 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v0, 32));
            v4 = v4 + 1;
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v0, 32);
        let v5 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(&mut v0);
        assert!(v5 == 1 || v5 == 2, 2);
        if (v5 == 2) {
            let v6 = &mut v0;
            verify_nonce_advance(v6, &v3, arg1);
        };
        let v7 = &mut v0;
        verify_transfer(v7, &v3, arg1, arg2, arg3);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v0), 1);
        assert!(0x1::vector::borrow<vector<u8>>(&v3, 0) == arg1, 4);
    }

    fun verify_nonce_advance(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_system_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 3, 8);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v4 = if ((0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64) < v0) {
            if (v2 < v0) {
                v3 < v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 1);
        assert!(v3 == 0, 8);
        let v5 = x"06a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000";
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v2) == &v5, 8);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v3) == arg2, 8);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 4, 8);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(arg0) == 4, 8);
    }

    fun verify_transfer(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u128) {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_system_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 2, 3);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v2 < v0 && v3 < v0, 1);
        assert!(v2 == 0, 4);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 12, 3);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(arg0) == 2, 3);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v2) == arg2, 4);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v3) == arg3, 5);
        assert!((0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(arg0) as u128) == arg4, 6);
    }

    // decompiled from Move bytecode v6
}

