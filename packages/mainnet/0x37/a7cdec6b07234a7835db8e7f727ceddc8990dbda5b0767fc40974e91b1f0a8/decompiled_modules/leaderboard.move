module 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::leaderboard {
    public fun check_and_award_medals(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(v0 >= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::medal_check_state_last_check_timestamp(arg1) + 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::medal_check_state_check_interval_ms(arg1), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::check_not_due());
        *0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::medal_check_state_last_check_timestamp_mut(arg1) = v0;
        let (v1, v2) = if (arg3) {
            let v3 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_wins(arg0);
            if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u64>>(v3, arg2)) {
                0x2::vec_map::into_keys_values<address, u64>(*0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u64>>(v3, arg2))
            } else {
                (0x1::vector::empty<address>(), 0x1::vector::empty<u64>())
            }
        } else {
            0x2::vec_map::into_keys_values<address, u64>(*0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_wins(arg0))
        };
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x1::vector::length<address>(&v5);
        let v7 = 0;
        while (v7 < v6 - 1) {
            let v8 = 0;
            while (v8 < v6 - v7 - 1) {
                if (*0x1::vector::borrow<u64>(&v4, v8) < *0x1::vector::borrow<u64>(&v4, v8 + 1)) {
                    0x1::vector::swap<u64>(&mut v4, v8, v8 + 1);
                    0x1::vector::swap<address>(&mut v5, v8, v8 + 1);
                };
                v8 = v8 + 1;
            };
            v7 = v7 + 1;
        };
        let v9 = @0x0;
        let v10 = @0x0;
        let v11 = @0x0;
        let v12 = 0;
        while (v12 < v6) {
            let v13 = *0x1::vector::borrow<address>(&v5, v12);
            let v14 = if (arg3) {
                let v15 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals(arg0);
                0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v15, arg2) && 0x2::vec_map::contains<address, u8>(0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u8>>(v15, arg2), &v13)
            } else {
                0x2::table::contains<address, u8>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals(arg0), v13)
            };
            if (v14) {
                let v16 = if (arg3) {
                    *0x2::vec_map::get<address, u8>(0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u8>>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals(arg0), arg2), &v13)
                } else {
                    *0x2::table::borrow<address, u8>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals(arg0), v13)
                };
                if (v16 == 0) {
                    v9 = v13;
                } else if (v16 == 1) {
                    v10 = v13;
                } else if (v16 == 2) {
                    v11 = v13;
                };
            };
            v12 = v12 + 1;
        };
        let v17 = 0;
        while (v17 < v6) {
            let v18 = *0x1::vector::borrow<address>(&v5, v17);
            let v19 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            if (0x2::table::contains<address, u64>(v19, v18) && v0 - *0x2::table::borrow<address, u64>(v19, v18) > 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms() || true) {
                if (arg3) {
                    let v20 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals_mut(arg0);
                    if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v20, arg2)) {
                        let v21 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v20, arg2);
                        if (0x2::vec_map::contains<address, u8>(v21, &v18)) {
                            let (_, _) = 0x2::vec_map::remove<address, u8>(v21, &v18);
                        };
                    };
                } else {
                    let v24 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals_mut(arg0);
                    if (0x2::table::contains<address, u8>(v24, v18)) {
                        0x2::table::remove<address, u8>(v24, v18);
                    };
                };
            };
            v17 = v17 + 1;
        };
        if (v6 >= 1) {
            let v25 = *0x1::vector::borrow<address>(&v5, 0);
            let v26 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v27 = if (v9 == v25) {
                if (0x2::table::contains<address, u64>(v26, v25)) {
                    v0 - *0x2::table::borrow<address, u64>(v26, v25) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms()
                } else {
                    false
                }
            } else {
                false
            };
            let v28 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v29 = 0x2::table::contains<address, u64>(v28, v25) && v0 - *0x2::table::borrow<address, u64>(v28, v25) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms();
            if (v27) {
            } else if (v29) {
                if (arg3) {
                    let v30 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals_mut(arg0);
                    let v31 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v30, arg2)) {
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v30, arg2)
                    } else {
                        0x2::table::add<address, 0x2::vec_map::VecMap<address, u8>>(v30, arg2, 0x2::vec_map::empty<address, u8>());
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v30, arg2)
                    };
                    0x2::vec_map::insert<address, u8>(v31, v25, 0);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::GoldenChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_golden_champion(v25, true, v0, arg4), v25);
                } else {
                    0x2::table::add<address, u8>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals_mut(arg0), v25, 0);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::GoldenChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_golden_champion(v25, false, v0, arg4), v25);
                };
                0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::events::emit_medal_awarded(0, v25, arg3, v0);
            };
        };
        if (v6 >= 2) {
            let v32 = *0x1::vector::borrow<address>(&v5, 1);
            let v33 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v34 = if (v10 == v32) {
                if (0x2::table::contains<address, u64>(v33, v32)) {
                    v0 - *0x2::table::borrow<address, u64>(v33, v32) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms()
                } else {
                    false
                }
            } else {
                false
            };
            let v35 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v36 = 0x2::table::contains<address, u64>(v35, v32) && v0 - *0x2::table::borrow<address, u64>(v35, v32) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms();
            if (v34) {
            } else if (v36) {
                if (arg3) {
                    let v37 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals_mut(arg0);
                    let v38 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v37, arg2)) {
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v37, arg2)
                    } else {
                        0x2::table::add<address, 0x2::vec_map::VecMap<address, u8>>(v37, arg2, 0x2::vec_map::empty<address, u8>());
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v37, arg2)
                    };
                    0x2::vec_map::insert<address, u8>(v38, v32, 1);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::SilverChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_silver_champion(v32, true, v0, arg4), v32);
                } else {
                    0x2::table::add<address, u8>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals_mut(arg0), v32, 1);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::SilverChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_silver_champion(v32, false, v0, arg4), v32);
                };
                0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::events::emit_medal_awarded(1, v32, arg3, v0);
            };
        };
        if (v6 >= 3) {
            let v39 = *0x1::vector::borrow<address>(&v5, 2);
            let v40 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v41 = if (v11 == v39) {
                if (0x2::table::contains<address, u64>(v40, v39)) {
                    v0 - *0x2::table::borrow<address, u64>(v40, v39) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms()
                } else {
                    false
                }
            } else {
                false
            };
            let v42 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp(arg0);
            let v43 = 0x2::table::contains<address, u64>(v42, v39) && v0 - *0x2::table::borrow<address, u64>(v42, v39) <= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms();
            if (v41) {
            } else if (v43) {
                if (arg3) {
                    let v44 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_medals_mut(arg0);
                    let v45 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v44, arg2)) {
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v44, arg2)
                    } else {
                        0x2::table::add<address, 0x2::vec_map::VecMap<address, u8>>(v44, arg2, 0x2::vec_map::empty<address, u8>());
                        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u8>>(v44, arg2)
                    };
                    0x2::vec_map::insert<address, u8>(v45, v39, 2);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::BronzeChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_bronze_champion(v39, true, v0, arg4), v39);
                } else {
                    0x2::table::add<address, u8>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_medals_mut(arg0), v39, 2);
                    0x2::transfer::public_transfer<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::BronzeChampion>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_bronze_champion(v39, false, v0, arg4), v39);
                };
                0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::events::emit_medal_awarded(2, v39, arg3, v0);
            };
        };
    }

    public fun try_check_and_award_medals_with_callers(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::medal_check_state_last_check_timestamp(arg1) + 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::medal_check_state_check_interval_ms(arg1)) {
            check_and_award_medals(arg0, arg1, @0x0, false, arg3);
            let v0 = 0;
            while (v0 < 0x1::vector::length<address>(&arg2)) {
                check_and_award_medals(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), true, arg3);
                v0 = v0 + 1;
            };
        };
    }

    public fun update_external_leaderboard(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_external_wins_mut(arg0);
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<address, u64>>(v0, arg6)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<address, u64>>(v0, arg6, 0x2::vec_map::empty<address, u64>());
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, u64>>(v0, arg6);
        if (!0x2::vec_map::contains<address, u64>(v1, &arg1)) {
            0x2::vec_map::insert<address, u64>(v1, arg1, 0);
        };
        let v2 = 0x2::vec_map::get_mut<address, u64>(v1, &arg1);
        *v2 = *v2 + 1;
        if (arg2 != @0x0) {
            if (!0x2::vec_map::contains<address, u64>(v1, &arg2)) {
                0x2::vec_map::insert<address, u64>(v1, arg2, 0);
            };
        };
        let v3 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp_mut(arg0);
        0x2::table::add<address, u64>(v3, arg1, 0x2::tx_context::epoch_timestamp_ms(arg7));
        if (arg2 != @0x0) {
            0x2::table::add<address, u64>(v3, arg2, 0x2::tx_context::epoch_timestamp_ms(arg7));
        };
        (arg3 + arg4, arg4 * 8 / 10, arg4 * 2 / 10)
    }

    public fun update_leaderboard(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_wins_mut(arg0);
        if (!0x2::vec_map::contains<address, u64>(v0, &arg1)) {
            0x2::vec_map::insert<address, u64>(v0, arg1, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u64>(v0, &arg1);
        *v1 = *v1 + 1;
        if (arg2 != @0x0) {
            if (!0x2::vec_map::contains<address, u64>(v0, &arg2)) {
                0x2::vec_map::insert<address, u64>(v0, arg2, 0);
            };
        };
        let v2 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::leaderboard_last_game_timestamp_mut(arg0);
        0x2::table::add<address, u64>(v2, arg1, 0x2::tx_context::epoch_timestamp_ms(arg6));
        if (arg2 != @0x0) {
            0x2::table::add<address, u64>(v2, arg2, 0x2::tx_context::epoch_timestamp_ms(arg6));
        };
    }

    // decompiled from Move bytecode v6
}

