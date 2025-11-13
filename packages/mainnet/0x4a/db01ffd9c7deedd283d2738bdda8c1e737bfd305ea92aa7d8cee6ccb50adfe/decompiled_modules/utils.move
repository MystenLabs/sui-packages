module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils {
    public fun calculate_payout(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: bool, arg6: address) : (u64, u64, u64, u64) {
        let v0 = if (arg5) {
            arg4 * 8 / 10
        } else {
            0
        };
        let v1 = if (arg5) {
            arg4 * 2 / 10
        } else {
            arg4
        };
        let (v2, v3, v4) = if (arg5) {
            let v5 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_external_medals(arg0), arg6)) {
                0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u8>>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_external_medals(arg0), arg6)
            } else {
                let v6 = 0x2::vec_map::empty<address, u8>();
                &v6
            };
            if (0x2::vec_map::contains<address, u8>(v5, &arg2)) {
                let v7 = *0x2::vec_map::get<address, u8>(v5, &arg2);
                if (v7 == 0) {
                    (arg3 + arg4, arg4, v1)
                } else {
                    let (v8, v9, v10) = if (v7 == 1) {
                        let v11 = arg3 * 20 / 100;
                        (v11 + arg4, v1 + v11 / 2, arg3 + arg4 + v11 / 2)
                    } else {
                        let (v12, v13, v14) = if (v7 == 2) {
                            let v15 = arg3 * 30 / 100;
                            (arg3 + arg4 + v15 * 2 / 3, v15 + arg4, v1 + v15 / 3)
                        } else {
                            (arg3 + arg4 + arg3, arg3 + arg4, v1)
                        };
                        (v13, v14, v12)
                    };
                    (v10, v8, v9)
                }
            } else {
                (arg3 + arg4 + arg3, arg3 + arg4, v1)
            }
        } else if (0x2::table::contains<address, u8>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_medals(arg0), arg2)) {
            let v16 = *0x2::table::borrow<address, u8>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_medals(arg0), arg2);
            if (v16 == 0) {
                (arg3 + arg4, arg4, v1)
            } else if (v16 == 1) {
                let v17 = arg3 * 20 / 100;
                (arg3 + arg4 + v17 / 2, v17 + arg4, v1 + v17 / 2)
            } else if (v16 == 2) {
                let v18 = arg3 * 30 / 100;
                (arg3 + arg4 + v18 * 2 / 3, v18 + arg4, v1 + v18 / 3)
            } else {
                (arg3 + arg4 + arg3, arg3 + arg4, v1)
            }
        } else {
            (arg3 + arg4 + arg3, arg3 + arg4, v1)
        };
        (v2, v3, v0, v4)
    }

    public fun check_stake_cap(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: address) : bool {
        if (arg4) {
            let v1 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_external_medals(arg0), arg5)) {
                0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u8>>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_external_medals(arg0), arg5)
            } else {
                let v2 = 0x2::vec_map::empty<address, u8>();
                &v2
            };
            if (0x2::vec_map::contains<address, u8>(v1, &arg1)) {
                let v3 = *0x2::vec_map::get<address, u8>(v1, &arg1);
                v3 == 0 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::gold_stake_cap_usd() * 1000000000 / arg3 || v3 == 1 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::silver_stake_cap_usd() * 1000000000 / arg3 || v3 == 2 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::bronze_stake_cap_usd() * 1000000000 / arg3 || true
            } else {
                true
            }
        } else if (0x2::table::contains<address, u8>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_medals(arg0), arg1)) {
            let v4 = *0x2::table::borrow<address, u8>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_medals(arg0), arg1);
            v4 == 0 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::gold_stake_cap_usd() * 1000000000 / arg3 || v4 == 1 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::silver_stake_cap_usd() * 1000000000 / arg3 || v4 == 2 && arg2 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::bronze_stake_cap_usd() * 1000000000 / arg3 || true
        } else {
            true
        }
    }

    public fun get_max_score_player(arg0: &0x2::table::Table<address, u64>, arg1: &0x2::vec_set::VecSet<address>) : address {
        let v0 = 0x2::vec_set::into_keys<address>(*arg1);
        let v1 = 0;
        let v2 = &mut v1;
        let v3 = *0x1::vector::borrow<address>(&v0, 0);
        let v4 = &mut v3;
        let v5 = 0;
        let v6 = &mut v5;
        while (*v6 < 0x1::vector::length<address>(&v0)) {
            let v7 = *0x1::vector::borrow<address>(&v0, *v6);
            let v8 = if (0x2::table::contains<address, u64>(arg0, v7)) {
                *0x2::table::borrow<address, u64>(arg0, v7)
            } else {
                0
            };
            if (v8 > *v2) {
                *v2 = v8;
                *v4 = v7;
            };
            *v6 = *v6 + 1;
        };
        *v4
    }

    public fun is_verified_caller(arg0: &0x2::vec_set::VecSet<address>, arg1: address) : bool {
        0x2::vec_set::contains<address>(arg0, &arg1)
    }

    public fun pow10(arg0: u32) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun sort_players_by_score(arg0: &0x2::table::Table<address, u64>, arg1: &0x2::vec_set::VecSet<address>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        let v2 = 0x2::vec_set::into_keys<address>(*arg1);
        let v3 = 0;
        let v4 = &mut v3;
        while (*v4 < 0x1::vector::length<address>(&v2)) {
            let v5 = *0x1::vector::borrow<address>(&v2, *v4);
            let v6 = if (0x2::table::contains<address, u64>(arg0, v5)) {
                *0x2::table::borrow<address, u64>(arg0, v5)
            } else {
                0
            };
            let v7 = 0;
            let v8 = &mut v7;
            let v9 = false;
            let v10 = &mut v9;
            while (*v8 < 0x1::vector::length<address>(v1)) {
                let v11 = *0x1::vector::borrow<address>(v1, *v8);
                let v12 = if (0x2::table::contains<address, u64>(arg0, v11)) {
                    *0x2::table::borrow<address, u64>(arg0, v11)
                } else {
                    0
                };
                if (v6 > v12) {
                    0x1::vector::insert<address>(v1, v5, *v8);
                    *v10 = true;
                    break
                };
                *v8 = *v8 + 1;
            };
            if (!*v10) {
                0x1::vector::push_back<address>(v1, v5);
            };
            *v4 = *v4 + 1;
        };
        *v1
    }

    // decompiled from Move bytecode v6
}

