module 0xaf95e111a00feae35e8e207f58a76677c27305a46620c5b22b32cb2eca9e1143::deck {
    public fun burn_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) {
        draw_card(arg0, arg1, arg2, arg3);
    }

    public fun deal_tension_runout(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64, arg4: u32) : (vector<u8>, vector<u8>) {
        let v0 = sample_bucket_for_stage(scheduler_stage(arg4), arg1, arg2, arg3);
        sample_bucket_runout(v0, arg0, arg1, arg2, arg3)
    }

    public fun derive_entropy(arg0: &vector<u8>, arg1: address, arg2: u64) : u64 {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun draw_card(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : u8 {
        *arg3 = *arg3 + 1;
        0x1::vector::swap_remove<u8>(arg0, derive_entropy(arg1, arg2, *arg3) % (0x1::vector::length<u8>(arg0) as u64))
    }

    fun map_suit(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8) : u8 {
        if (arg0 == 0) {
            arg1
        } else if (arg0 == 1) {
            arg2
        } else if (arg0 == 2) {
            arg3
        } else {
            arg4
        }
    }

    fun pick(arg0: &vector<u8>, arg1: address, arg2: &mut u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 1);
        *arg2 = *arg2 + 1;
        derive_entropy(arg0, arg1, *arg2) % arg3
    }

    fun push_broadway_collision(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
        };
    }

    fun push_card(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8) {
        0x1::vector::push_back<u8>(arg0, 0xaf95e111a00feae35e8e207f58a76677c27305a46620c5b22b32cb2eca9e1143::types::card_encode(arg1, map_suit(arg2, arg3, arg4, arg5, arg6)));
    }

    fun push_dominated_kicker(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
        };
    }

    fun push_flush_over_flush(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
        };
    }

    fun push_flush_pressure(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
        };
    }

    fun push_full_house_collision(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 2, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 2, arg2, arg3, arg4, arg5);
        };
    }

    fun push_pair_vs_overcards(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 0, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 6, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
        };
    }

    fun push_premium_collision(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
        };
    }

    fun push_set_over_set_pressure(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 2, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 6, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
        };
    }

    fun push_set_overpair_pressure(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 7, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 8, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 6, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
        };
    }

    fun push_suited_connector_vs_high(arg0: &mut vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        if (arg1 == 0) {
            push_card(arg0, 9, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 1, arg2, arg3, arg4, arg5);
        } else if (arg1 == 1) {
            push_card(arg0, 10, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 11, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 2, arg2, arg3, arg4, arg5);
        } else if (arg1 == 2) {
            push_card(arg0, 8, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 13, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 6, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 3, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 5, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg1 == 3, 1);
            push_card(arg0, 11, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 10, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 14, 3, arg2, arg3, arg4, arg5);
            push_card(arg0, 12, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 9, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 8, 2, arg2, arg3, arg4, arg5);
            push_card(arg0, 2, 1, arg2, arg3, arg4, arg5);
            push_card(arg0, 4, 0, arg2, arg3, arg4, arg5);
            push_card(arg0, 7, 3, arg2, arg3, arg4, arg5);
        };
    }

    fun random_runout(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : (vector<u8>, vector<u8>) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 4) {
            let v2 = draw_card(arg0, arg1, arg2, arg3);
            0x1::vector::push_back<u8>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = b"";
        v1 = 0;
        while (v1 < 5) {
            0x1::vector::push_back<u8>(&mut v3, draw_card(arg0, arg1, arg2, arg3));
            v1 = v1 + 1;
        };
        (v0, v3)
    }

    fun remove_card(arg0: &mut vector<u8>, arg1: u8) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return 0x1::vector::swap_remove<u8>(arg0, v0)
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun remove_runout_cards(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            remove_card(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg2)) {
            remove_card(arg0, *0x1::vector::borrow<u8>(arg2, v0));
            v0 = v0 + 1;
        };
    }

    fun sample_bucket_for_stage(arg0: u8, arg1: &vector<u8>, arg2: address, arg3: &mut u64) : u8 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = pick(arg1, arg2, arg3, 100);
        if (arg0 == 1) {
            if (v0 < 50) {
                0
            } else if (v0 < 65) {
                1
            } else if (v0 < 77) {
                2
            } else if (v0 < 87) {
                3
            } else if (v0 < 95) {
                4
            } else {
                5
            }
        } else if (arg0 == 2) {
            if (v0 < 3) {
                0
            } else if (v0 < 23) {
                1
            } else if (v0 < 38) {
                6
            } else if (v0 < 60) {
                7
            } else if (v0 < 80) {
                8
            } else if (v0 < 90) {
                2
            } else if (v0 < 97) {
                3
            } else {
                5
            }
        } else if (v0 < 35) {
            9
        } else if (v0 < 70) {
            10
        } else if (v0 < 90) {
            8
        } else {
            7
        }
    }

    fun sample_bucket_runout(arg0: u8, arg1: &mut vector<u8>, arg2: &vector<u8>, arg3: address, arg4: &mut u64) : (vector<u8>, vector<u8>) {
        if (arg0 == 0) {
            random_runout(arg1, arg2, arg3, arg4)
        } else {
            template_runout(arg0, arg1, arg2, arg3, arg4)
        }
    }

    public fun scheduler_stage(arg0: u32) : u8 {
        let v0 = if (arg0 == 0) {
            0
        } else {
            arg0 - 1
        };
        if (v0 < 8) {
            0
        } else if (v0 < 15) {
            1
        } else if (v0 < 24) {
            2
        } else {
            3
        }
    }

    public fun stage_random() : u8 {
        0
    }

    public fun stage_tension_v1() : u8 {
        1
    }

    public fun stage_tension_v2b() : u8 {
        2
    }

    public fun stage_tension_v3_late() : u8 {
        3
    }

    public fun standard_deck() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun suit_permutation(arg0: u8) : (u8, u8, u8, u8) {
        let v0 = x"00010203";
        let v1 = arg0 % 6;
        (0x1::vector::remove<u8>(&mut v0, ((arg0 / 6) as u64)), 0x1::vector::remove<u8>(&mut v0, ((v1 / 2) as u64)), 0x1::vector::remove<u8>(&mut v0, ((v1 % 2) as u64)), *0x1::vector::borrow<u8>(&v0, 0))
    }

    fun template_cards(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) : vector<u8> {
        let v0 = b"";
        if (arg0 == 1) {
            let v1 = &mut v0;
            push_pair_vs_overcards(v1, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 2) {
            let v2 = &mut v0;
            push_broadway_collision(v2, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 3) {
            let v3 = &mut v0;
            push_suited_connector_vs_high(v3, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 4) {
            let v4 = &mut v0;
            push_flush_pressure(v4, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 5) {
            let v5 = &mut v0;
            push_dominated_kicker(v5, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 6) {
            let v6 = &mut v0;
            push_premium_collision(v6, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 7) {
            let v7 = &mut v0;
            push_set_overpair_pressure(v7, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 8) {
            let v8 = &mut v0;
            push_flush_over_flush(v8, arg1, arg2, arg3, arg4, arg5);
        } else if (arg0 == 9) {
            let v9 = &mut v0;
            push_set_over_set_pressure(v9, arg1, arg2, arg3, arg4, arg5);
        } else {
            assert!(arg0 == 10, 1);
            let v10 = &mut v0;
            push_full_house_collision(v10, arg1, arg2, arg3, arg4, arg5);
        };
        v0
    }

    fun template_count(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else {
            assert!(arg0 <= 10, 1);
            4
        }
    }

    fun template_runout(arg0: u8, arg1: &mut vector<u8>, arg2: &vector<u8>, arg3: address, arg4: &mut u64) : (vector<u8>, vector<u8>) {
        let v0 = pick(arg2, arg3, arg4, template_count(arg0));
        let v1 = pick(arg2, arg3, arg4, 24);
        let (v2, v3, v4, v5) = suit_permutation((v1 as u8));
        let v6 = template_cards(arg0, (v0 as u8), v2, v3, v4, v5);
        let v7 = if (pick(arg2, arg3, arg4, 2) == 1) {
            let v8 = 0x1::vector::empty<u8>();
            let v9 = &mut v8;
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v6, 2));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v6, 3));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v6, 0));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v6, 1));
            v8
        } else {
            let v10 = 0x1::vector::empty<u8>();
            let v11 = &mut v10;
            0x1::vector::push_back<u8>(v11, *0x1::vector::borrow<u8>(&v6, 0));
            0x1::vector::push_back<u8>(v11, *0x1::vector::borrow<u8>(&v6, 1));
            0x1::vector::push_back<u8>(v11, *0x1::vector::borrow<u8>(&v6, 2));
            0x1::vector::push_back<u8>(v11, *0x1::vector::borrow<u8>(&v6, 3));
            v10
        };
        let v12 = v7;
        let v13 = 0x1::vector::empty<u8>();
        let v14 = &mut v13;
        0x1::vector::push_back<u8>(v14, *0x1::vector::borrow<u8>(&v6, 4));
        0x1::vector::push_back<u8>(v14, *0x1::vector::borrow<u8>(&v6, 5));
        0x1::vector::push_back<u8>(v14, *0x1::vector::borrow<u8>(&v6, 6));
        0x1::vector::push_back<u8>(v14, *0x1::vector::borrow<u8>(&v6, 7));
        0x1::vector::push_back<u8>(v14, *0x1::vector::borrow<u8>(&v6, 8));
        remove_runout_cards(arg1, &v12, &v13);
        (v12, v13)
    }

    // decompiled from Move bytecode v7
}

