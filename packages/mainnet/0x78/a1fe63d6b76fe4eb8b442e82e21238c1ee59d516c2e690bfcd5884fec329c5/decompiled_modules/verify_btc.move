module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_btc {
    fun dsha256(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(0x1::hash::sha2_256(arg0))
    }

    public(friend) fun verify(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u128, arg6: u128) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0, 12);
        let v1 = if (0x1::vector::length<u8>(arg3) == 22) {
            if (*0x1::vector::borrow<u8>(arg3, 0) == 0) {
                *0x1::vector::borrow<u8>(arg3, 1) == 20
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        let v2 = x"1976a914";
        let v3 = 0;
        while (v3 < 20) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg3, 2 + v3));
            v3 = v3 + 1;
        };
        0x1::vector::push_back<u8>(&mut v2, 136);
        0x1::vector::push_back<u8>(&mut v2, 172);
        assert!(0x1::vector::length<u8>(arg2) == v0 * 36, 3);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::new(*0x1::vector::borrow<vector<u8>>(arg0, v6));
            v4 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 32);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_btc_varint(&mut v7) == 25, 11);
            let v8 = x"19";
            0x1::vector::append<u8>(&mut v8, 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 25));
            let v9 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(&mut v7);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(&mut v7);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v7), 1);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(&mut v7) == 1, 0);
            assert!(v8 == v2, 11);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 32) == dsha256(*arg2), 3);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 32) == dsha256(*arg1), 4);
            assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 36) == 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::slice(arg2, v6 * 36, 36), 3);
            if (v6 == 0) {
                v4 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 32);
            } else {
                assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v7, 32) == v4, 2);
                assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(&mut v7) == 0, 2);
                assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(&mut v7) == 0, 2);
            };
            assert!(v9 <= 2100000000000000, 13);
            let v10 = v5 + v9;
            v5 = v10;
            assert!(v10 <= 2100000000000000, 13);
            v6 = v6 + 1;
        };
        let v11 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::new(*arg1);
        let v12 = 0;
        let v13 = 0;
        while (!0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v11)) {
            let v14 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(&mut v11);
            let v15 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v11, 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_btc_varint(&mut v11));
            if (v13 == 0) {
                assert!(&v15 == arg4, 6);
                assert!((v14 as u128) == arg5, 7);
            } else {
                assert!(&v15 == arg3, 8);
            };
            assert!(v14 <= 2100000000000000, 13);
            let v16 = v12 + v14;
            v12 = v16;
            assert!(v16 <= 2100000000000000, 13);
            v13 = v13 + 1;
        };
        assert!(v13 >= 1 && v13 <= 2, 5);
        assert!(v5 >= v12, 9);
        assert!(((v5 - v12) as u128) <= arg6, 9);
    }

    // decompiled from Move bytecode v6
}

