module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_solana {
    fun assert_associated_token_program(arg0: &vector<u8>) {
        let v0 = x"8c97258f4e2489f1bb3d1029148e0d830b5a1399daff1084048e7bd8dbe9f859";
        assert!(arg0 == &v0, 11);
    }

    fun assert_spl_token_program(arg0: &vector<u8>) {
        let v0 = x"06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9";
        assert!(arg0 == &v0, 10);
    }

    fun assert_system_program(arg0: &vector<u8>) {
        let v0 = 0;
        while (v0 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, v0) == 0, 3);
            v0 = v0 + 1;
        };
    }

    public(friend) fun verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u128) {
        let v0 = b"";
        verify_with_asset(arg0, arg1, &v0, arg2, arg3);
    }

    fun verify_ata_create_idempotent(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_associated_token_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 6, 9);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v4 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v5 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v6 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v7 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v8 = if (v2 < v0) {
            if (v3 < v0) {
                if (v4 < v0) {
                    if (v5 < v0) {
                        if (v6 < v0) {
                            v7 < v0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 1);
        assert!(v2 == 0, 9);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v4) == arg3, 5);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v5) == arg2, 9);
        assert_system_program(0x1::vector::borrow<vector<u8>>(arg1, v6));
        assert_spl_token_program(0x1::vector::borrow<vector<u8>>(arg1, v7));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 1, 9);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) == 1, 9);
        *0x1::vector::borrow<vector<u8>>(arg1, v3)
    }

    fun verify_create_account_with_seed(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: u128) : vector<u8> {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_system_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 2, 12);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v2 < v0 && v3 < v0, 1);
        assert!(v2 == 0, 4);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v2) == arg2, 4);
        let v4 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0);
        assert!(v4 >= 92 && v4 <= 124, 12);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(arg0) == 3, 12);
        let v5 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, 32);
        assert!(&v5 == arg2, 4);
        let v6 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(arg0);
        assert!(v6 <= 32, 12);
        assert!(v4 == 92 + v6, 12);
        assert!((0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(arg0) as u128) == arg3, 6);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(arg0) == 80, 12);
        let v7 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, 32);
        assert_system_program(&v7);
        0x1::vector::append<u8>(&mut v5, 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, v6));
        0x1::vector::append<u8>(&mut v5, v7);
        let v8 = *0x1::vector::borrow<vector<u8>>(arg1, v3);
        assert!(v8 == 0x1::hash::sha2_256(v5), 12);
        v8
    }

    fun verify_initialize_nonce(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: &vector<u8>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_system_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 3, 12);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v4 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v5 = if (v2 < v0) {
            if (v3 < v0) {
                v4 < v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 1);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v2) == arg3, 12);
        let v6 = x"06a7d517192c568ee08a845f73d29788cf035c3145b21ab344d8062ea9400000";
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v3) == &v6, 12);
        let v7 = x"06a7d517192c5c51218cc94c3d4af17f58daee089ba1fd44e3dbd98a00000000";
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v4) == &v7, 12);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 36, 12);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u32_le(arg0) == 6, 12);
        let v8 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, 32);
        assert!(&v8 == arg2, 12);
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

    public(friend) fun verify_nonce_setup(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u128) {
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
        assert!(v5 == 2 || v5 == 3, 12);
        if (v5 == 3) {
            let v6 = &mut v0;
            verify_nonce_advance(v6, &v3, arg1);
        };
        let v7 = &mut v0;
        let v8 = verify_create_account_with_seed(v7, &v3, arg1, arg3);
        let v9 = &mut v0;
        verify_initialize_nonce(v9, &v3, arg1, &v8);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v0), 1);
        assert!(0x1::vector::borrow<vector<u8>>(&v3, 0) == arg1, 4);
        assert!(&v8 == arg2, 5);
    }

    fun verify_spl_transfer_checked(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: &vector<vector<u8>>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u128) {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        assert!(v1 < v0, 1);
        assert_spl_token_program(0x1::vector::borrow<vector<u8>>(arg1, v1));
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 4, 9);
        let v2 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v3 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v4 = (0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64);
        let v5 = if ((0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) as u64) < v0) {
            if (v2 < v0) {
                if (v3 < v0) {
                    v4 < v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 1);
        assert!(v4 == 0, 4);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v4) == arg2, 4);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v2) == arg3, 9);
        assert!(0x1::vector::borrow<vector<u8>>(arg1, v3) == arg4, 5);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(arg0) == 10, 9);
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0) == 12, 9);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0);
        assert!((0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u64_le(arg0) as u128) == arg5, 6);
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

    public(friend) fun verify_with_asset(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u128) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 1);
        assert!(0x1::vector::length<u8>(arg3) == 32, 5);
        let v0 = !0x1::vector::is_empty<u8>(arg2);
        if (v0) {
            assert!(0x1::vector::length<u8>(arg2) == 32, 9);
        };
        let v1 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::new(*arg0);
        let v2 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v1);
        assert!(v2 & 128 == 0, 0);
        assert!(v2 == 1, 7);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v1);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(&mut v1);
        let v3 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(&mut v1);
        assert!(v3 >= 2 && v3 <= 16, 1);
        let v4 = 0x1::vector::empty<vector<u8>>();
        let v5 = 0;
        while (v5 < v3) {
            0x1::vector::push_back<vector<u8>>(&mut v4, 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v1, 32));
            v5 = v5 + 1;
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(&mut v1, 32);
        let v6 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_shortvec_len(&mut v1);
        if (v0) {
            assert!(v6 == 3, 9);
        } else {
            assert!(v6 == 1 || v6 == 2, 2);
        };
        if (v6 == 2 || v0) {
            let v7 = &mut v1;
            verify_nonce_advance(v7, &v4, arg1);
        };
        if (v0) {
            let v8 = &mut v1;
            let v9 = verify_ata_create_idempotent(v8, &v4, arg2, arg3);
            let v10 = &mut v1;
            verify_spl_transfer_checked(v10, &v4, arg1, arg2, &v9, arg4);
        } else {
            let v11 = &mut v1;
            verify_transfer(v11, &v4, arg1, arg3, arg4);
        };
        assert!(0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::is_empty(&v1), 1);
        assert!(0x1::vector::borrow<vector<u8>>(&v4, 0) == arg1, 4);
    }

    // decompiled from Move bytecode v7
}

