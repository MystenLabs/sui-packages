module 0x37582792b3011e4682c0543191b94fc5f92608a21ea5e725bbf3bf86f4a3f56c::blizzard_hooks {
    public fun fcfs<T0>(arg0: &mut 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::BlizzardStaking<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: u64) : (u64, vector<0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::IX>) {
        0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::sync_exchange_rate<T0>(arg0, arg1);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        let v1 = 0x1::option::destroy_some<u64>(0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::to_wal_at_epoch<T0>(arg0, v0, arg2, false));
        let v2 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::allowed_nodes<T0>(arg0);
        let v3 = 0x1::vector::empty<0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::IX>();
        let v4 = &v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            let v6 = 0x1::vector::borrow<0x2::object::ID>(v4, v5);
            if (1000000000 > v1) {
            } else {
                let v7 = vector[];
                let v8 = vector[];
                let v9 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::staked_wal_vector_at_node<T0>(arg0, v6);
                let v10 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v9);
                if (v10 != 0) {
                    let v11 = (0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::slice_size<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v9) as u64);
                    let v12 = 0;
                    let v13 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v9, v12);
                    let v14 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v13);
                    let v15 = 0;
                    while (v15 < v10) {
                        let v16 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_from_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v13, v15 % v11);
                        if (!0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg1, v16)) {
                        } else if (1000000000 > v1) {
                        } else {
                            let v17 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v16);
                            let v18 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(v16);
                            let v19 = v17 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg1, *v6, v17, v18, v0);
                            if (v19 > v1) {
                                let v20 = 0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u64::mul_div_down(v1, v17, v19);
                                if (v17 >= v20 + 1000000000) {
                                    0x1::vector::push_back<u32>(&mut v7, v18);
                                    v1 = 0;
                                    0x1::vector::push_back<u64>(&mut v8, v20);
                                };
                            } else {
                                0x1::vector::push_back<u32>(&mut v7, v18);
                                v1 = v1 - v19;
                                0x1::vector::push_back<u64>(&mut v8, v17);
                            };
                        };
                        if (v15 + 1 < v10 && v15 + 1 == v12 * v11 + v14) {
                            let v21 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_idx<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v13) + 1;
                            v12 = v21;
                            let v22 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v9, v21);
                            v13 = v22;
                            v14 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v22);
                        };
                        v15 = v15 + 1;
                    };
                };
                0x1::vector::push_back<0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::IX>(&mut v3, 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::new_ix(*v6, 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::new_epoch_value_vector(v7, v8)));
            };
            v5 = v5 + 1;
        };
        let v23 = &v2;
        let v24 = 0;
        while (v24 < 0x1::vector::length<0x2::object::ID>(v23)) {
            let v25 = 0x1::vector::borrow<0x2::object::ID>(v23, v24);
            if (1000000000 > v1) {
            } else {
                let v26 = vector[];
                let v27 = vector[];
                let v28 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_protocol::staked_wal_vector_at_node<T0>(arg0, v25);
                let v29 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v28);
                if (v29 != 0) {
                    let v30 = (0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::slice_size<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v28) as u64);
                    let v31 = 0;
                    let v32 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v28, v31);
                    let v33 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v32);
                    let v34 = 0;
                    while (v34 < v29) {
                        let v35 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_from_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v32, v34 % v30);
                        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg1, v35)) {
                        } else if (1000000000 > v1) {
                        } else {
                            let v36 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v35);
                            let v37 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(v35);
                            let v38 = v36 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg1, *v25, v36, v37, v0);
                            if (v38 > v1) {
                                let v39 = 0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u64::mul_div_down(v1, v36, v38);
                                if (v36 >= v39 + 1000000000) {
                                    0x1::vector::push_back<u32>(&mut v26, v37);
                                    v1 = 0;
                                    0x1::vector::push_back<u64>(&mut v27, v39);
                                };
                            } else {
                                0x1::vector::push_back<u32>(&mut v26, v37);
                                v1 = v1 - v38;
                                0x1::vector::push_back<u64>(&mut v27, v36);
                            };
                        };
                        if (v34 + 1 < v29 && v34 + 1 == v31 * v30 + v33) {
                            let v40 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_idx<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v32) + 1;
                            v31 = v40;
                            let v41 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v28, v40);
                            v32 = v41;
                            v33 = 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v41);
                        };
                        v34 = v34 + 1;
                    };
                };
                0x1::vector::push_back<0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::IX>(&mut v3, 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::new_ix(*v25, 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_withdraw_ix::new_epoch_value_vector(v26, v27)));
            };
            v24 = v24 + 1;
        };
        (v1 - v1, v3)
    }

    // decompiled from Move bytecode v6
}

