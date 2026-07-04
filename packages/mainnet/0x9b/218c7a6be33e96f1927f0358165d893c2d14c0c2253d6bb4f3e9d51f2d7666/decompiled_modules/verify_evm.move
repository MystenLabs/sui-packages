module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_evm {
    fun value_to_u128(arg0: &vector<u8>) : u128 {
        assert!(0x1::vector::length<u8>(arg0) <= 16, 10);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::be_bytes_to_u128(arg0)
    }

    public(friend) fun verify(arg0: &vector<u8>, arg1: u128, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u128, arg5: u128) {
        assert!(0x1::vector::length<u8>(arg3) == 20, 4);
        let v0 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::new(*arg0);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v0) == 2, 0);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_u128(&mut v0) == arg1, 2);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_u128(&mut v0);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_u128(&mut v0);
        let v1 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_string(&mut v0);
        assert!(0x1::vector::length<u8>(&v1) == 20, 3);
        let v2 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_bytes(&mut v0);
        let v3 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_string(&mut v0);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_list_header(&mut v0) == 0, 8);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::cursor(&v0) == 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::cursor(&v0) + 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_list_header(&mut v0), 1);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v0), 1);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_u128(&mut v0) * 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp::read_scalar_u128(&mut v0) <= arg5, 9);
        if (0x1::vector::length<u8>(arg2) == 0) {
            assert!(0x1::vector::length<u8>(&v3) == 0, 7);
            assert!(&v1 == arg3, 4);
            assert!(value_to_u128(&v2) == arg4, 5);
        } else {
            assert!(0x1::vector::length<u8>(arg2) == 20, 11);
            assert!(&v1 == arg2, 4);
            assert!(0x1::vector::length<u8>(&v2) == 0, 6);
            assert!(0x1::vector::length<u8>(&v3) == 68, 7);
            let v4 = if (*0x1::vector::borrow<u8>(&v3, 0) == 169) {
                if (*0x1::vector::borrow<u8>(&v3, 1) == 5) {
                    if (*0x1::vector::borrow<u8>(&v3, 2) == 156) {
                        *0x1::vector::borrow<u8>(&v3, 3) == 187
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 7);
            let v5 = 0;
            while (v5 < 12) {
                assert!(*0x1::vector::borrow<u8>(&v3, 4 + v5) == 0, 7);
                v5 = v5 + 1;
            };
            let v6 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::slice(&v3, 16, 20);
            assert!(&v6 == arg3, 4);
            let v7 = 0;
            while (v7 < 16) {
                assert!(*0x1::vector::borrow<u8>(&v3, 36 + v7) == 0, 10);
                v7 = v7 + 1;
            };
            let v8 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::slice(&v3, 52, 16);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::be_bytes_to_u128(&v8) == arg4, 5);
        };
    }

    // decompiled from Move bytecode v7
}

