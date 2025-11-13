module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments {
    public fun create_tournament(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg1: bool, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg3) {
            assert!(0x2::vec_set::contains<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist(arg0), &v0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_verified_caller());
        };
        let v1 = if (arg3) {
            v0
        } else {
            @0x0
        };
        let v2 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_tournament(v0, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::vec_set::empty<address>(), 0x2::table::new<address, u64>(arg4), 0x1::vector::empty<address>(), 0x2::table::new<address, u64>(arg4), arg1, arg2, true, arg3, v1, 0, arg4);
        let v3 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament>(&v2);
        let v4 = if (arg3) {
            v0
        } else {
            @0x0
        };
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_tournament_created(0x2::object::id_to_address(&v3), v0, arg1, arg2, arg3, v4, 0x2::tx_context::epoch_timestamp_ms(arg4));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::share_tournament(v2);
    }

    public fun finalize_tournament(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_creator(arg6);
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_payout_type(arg6);
        let v2 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_is_external(arg6);
        let v3 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_api_caller(arg6);
        let v4 = *0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_players(arg6);
        let v5 = 0x2::vec_set::length<address>(&v4);
        let v6 = *0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_stake_keys(arg6);
        let v7 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_stakes(arg6);
        let v8 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_scores(arg6);
        let v9 = 0x2::table::new<address, u64>(arg7);
        let v10 = 0x2::table::new<address, u64>(arg7);
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(&v6)) {
            let v12 = *0x1::vector::borrow<address>(&v6, v11);
            0x2::table::add<address, u64>(&mut v9, v12, *0x2::table::borrow<address, u64>(v7, v12));
            0x2::table::add<address, u64>(&mut v10, v12, *0x2::table::borrow<address, u64>(v8, v12));
            v11 = v11 + 1;
        };
        assert!(0x2::tx_context::sender(arg7) == v0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_creator());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_active(arg6), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::tournament_closed());
        let v13 = 0;
        let v14 = &mut v13;
        let v15 = 0;
        let v16 = &mut v15;
        let v17 = 0;
        let v18 = &mut v17;
        let v19 = 0x1::vector::empty<address>();
        let v20 = &mut v19;
        let v21 = 0;
        let v22 = &mut v21;
        let v23 = 0;
        let v24 = &mut v23;
        let v25 = 0;
        let v26 = &mut v25;
        let v27 = 0x2::table::new<address, u64>(arg7);
        let v28 = @0x0;
        let v29 = &mut v28;
        let v30 = 0;
        let v31 = &mut v30;
        let v32 = 0;
        let v33 = &mut v32;
        let v34 = 0;
        let v35 = &mut v34;
        while (*v18 < 0x1::vector::length<address>(&v6)) {
            *v29 = *0x1::vector::borrow<address>(&v6, *v18);
            *v31 = *0x2::table::borrow<address, u64>(&v9, *v29);
            *v33 = *v31 / 10;
            let v36 = *v31 + *v33;
            *v16 = *v16 + v36;
            *v35 = v36;
            if (v2) {
                let v37 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_external_medals(arg1);
                if (0x2::table::contains<address, 0x2::vec_map::VecMap<address, u8>>(v37, v3)) {
                    let v38 = 0x2::table::borrow<address, 0x2::vec_map::VecMap<address, u8>>(v37, v3);
                    if (0x2::vec_map::contains<address, u8>(v38, v29)) {
                        let v39 = *0x2::vec_map::get<address, u8>(v38, v29);
                        if (v39 == 0) {
                            *v35 = *v33;
                        } else if (v39 == 1) {
                            *v35 = *v31 * 20 / 100;
                        } else if (v39 == 2) {
                            *v35 = *v31 * 30 / 100;
                        };
                    };
                };
            } else {
                let v40 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::leaderboard_medals(arg1);
                if (0x2::table::contains<address, u8>(v40, *v29)) {
                    let v41 = *0x2::table::borrow<address, u8>(v40, *v29);
                    if (v41 == 0) {
                        *v35 = *v33;
                    } else if (v41 == 1) {
                        *v35 = *v31 * 20 / 100;
                    } else if (v41 == 2) {
                        *v35 = *v31 * 30 / 100;
                    };
                };
            };
            0x2::table::add<address, u64>(&mut v27, *v29, *v35);
            *v14 = *v14 + *v35;
            *v18 = *v18 + 1;
        };
        let v42 = *v14;
        let v43 = *v16 - v42;
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg3, arg4, arg5, arg7);
        let v44 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_total_stake_mut(arg6);
        if (0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_is_bracket(arg6)) {
            if (v1 == 0 || v5 == 1) {
                assert!(v5 == 1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_number_of_players());
                let v45 = 0x2::vec_set::into_keys<address>(v4);
                let v46 = *0x1::vector::borrow<address>(&v45, 0);
                let v47 = *0x2::table::borrow<address, u64>(&v9, v46);
                let v48 = v47 / 10;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 + v48), arg7), v46);
                let v49 = 0;
                while (v49 < 0x1::vector::length<address>(&v6)) {
                    let v50 = *0x1::vector::borrow<address>(&v6, v49);
                    if (v50 != v46) {
                        let v51 = *0x2::table::borrow<address, u64>(&v9, v50);
                        let v52 = v51 + v51 / 10 - *0x2::table::borrow<address, u64>(&v27, v50);
                        if (v52 > 0) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v52), arg7), v50);
                        };
                    };
                    v49 = v49 + 1;
                };
                if (v2) {
                    let v53 = v42 / 5;
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v53), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v42 - v53), arg7), v3);
                    let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v46, @0x0, v47, v48, arg0, v3, arg7);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v42), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                    0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v46, @0x0, v47, v48, arg0, arg7);
                };
            } else if (v1 == 1) {
                assert!(v5 >= 2, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_number_of_players());
                *v20 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::sort_players_by_score(&v10, &v4);
                let v57 = *0x1::vector::borrow<address>(v20, 0);
                let v58 = *0x1::vector::borrow<address>(v20, 1);
                let v59 = *0x2::table::borrow<address, u64>(&v9, v57);
                let v60 = *0x2::table::borrow<address, u64>(&v9, v58);
                *v22 = v59 / 10;
                *v24 = v60 / 10;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 / 2 + *v22), arg7), v57);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 * 3 / 10 + *v24), arg7), v58);
                if (v5 >= 3) {
                    let v61 = *0x1::vector::borrow<address>(v20, 2);
                    *v26 = *0x2::table::borrow<address, u64>(&v9, v61) / 10;
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 * 2 / 10 + *v26), arg7), v61);
                };
                let v62 = 0;
                while (v62 < 0x1::vector::length<address>(&v6)) {
                    let v63 = *0x1::vector::borrow<address>(&v6, v62);
                    let v64 = if (v63 != v57) {
                        if (v63 != v58) {
                            v5 < 3 || v63 != *0x1::vector::borrow<address>(v20, 2)
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v64) {
                        let v65 = *0x2::table::borrow<address, u64>(&v9, v63);
                        let v66 = v65 / 10;
                        let v67 = v65 + v66 - *0x2::table::borrow<address, u64>(&v27, v63);
                        if (v67 > 0) {
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v67), arg7), v63);
                        };
                        if (v2) {
                            let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, @0x0, v63, v65, v66, arg0, v3, arg7);
                        } else {
                            0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, @0x0, v63, v65, v66, arg0, arg7);
                        };
                    };
                    v62 = v62 + 1;
                };
                let v71 = v42 - *v22 - *v24 - *v26;
                if (v2) {
                    let v72 = v71 / 5;
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v72), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v71 - v72), arg7), v3);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v71), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                };
                if (v2) {
                    let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v57, @0x0, v59, *v22, arg0, v3, arg7);
                    let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v58, @0x0, v60, *v24, arg0, v3, arg7);
                    if (v5 >= 3) {
                        let v79 = *0x1::vector::borrow<address>(v20, 2);
                        let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v79, @0x0, *0x2::table::borrow<address, u64>(&v9, v79), *v26, arg0, v3, arg7);
                    };
                } else {
                    0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v57, @0x0, v59, *v22, arg0, arg7);
                    0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v58, @0x0, v60, *v24, arg0, arg7);
                    if (v5 >= 3) {
                        let v83 = *0x1::vector::borrow<address>(v20, 2);
                        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v83, @0x0, *0x2::table::borrow<address, u64>(&v9, v83), *v26, arg0, arg7);
                    };
                };
            };
        } else if (v1 == 0) {
            let v84 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::get_max_score_player(&v10, &v4);
            let v85 = *0x2::table::borrow<address, u64>(&v9, v84);
            let v86 = v85 / 10;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 + v86), arg7), v84);
            let v87 = 0;
            while (v87 < 0x1::vector::length<address>(&v6)) {
                let v88 = *0x1::vector::borrow<address>(&v6, v87);
                if (v88 != v84) {
                    let v89 = *0x2::table::borrow<address, u64>(&v9, v88);
                    let v90 = v89 / 10;
                    let v91 = v89 + v90 - *0x2::table::borrow<address, u64>(&v27, v88);
                    if (v91 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v91), arg7), v88);
                    };
                    if (v2) {
                        let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, @0x0, v88, v89, v90, arg0, v3, arg7);
                    } else {
                        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, @0x0, v88, v89, v90, arg0, arg7);
                    };
                };
                v87 = v87 + 1;
            };
            if (v2) {
                let v95 = v42 / 5;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v95), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v42 - v95), arg7), v3);
                let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v84, @0x0, v85, v86, arg0, v3, arg7);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v42), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v84, @0x0, v85, v86, arg0, arg7);
            };
        } else {
            *v20 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::sort_players_by_score(&v10, &v4);
            let v99 = *0x1::vector::borrow<address>(v20, 0);
            let v100 = *0x2::table::borrow<address, u64>(&v9, v99);
            *v22 = v100 / 10;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 / 2 + *v22), arg7), v99);
            *v24 = 0;
            *v26 = 0;
            let v101 = @0x0;
            let v102 = &mut v101;
            let v103 = @0x0;
            let v104 = &mut v103;
            if (v5 >= 2) {
                *v102 = *0x1::vector::borrow<address>(v20, 1);
                let v105 = *0x2::table::borrow<address, u64>(&v9, *v102);
                *v24 = v105 / 10;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 * 3 / 10 + *v24), arg7), *v102);
                if (v2) {
                    let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, *v102, @0x0, v105, *v24, arg0, v3, arg7);
                } else {
                    0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, *v102, @0x0, v105, *v24, arg0, arg7);
                };
            };
            if (v5 >= 3) {
                *v104 = *0x1::vector::borrow<address>(v20, 2);
                let v109 = *0x2::table::borrow<address, u64>(&v9, *v104);
                *v26 = v109 / 10;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v43 * 2 / 10 + *v26), arg7), *v104);
                if (v2) {
                    let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, *v104, @0x0, v109, *v26, arg0, v3, arg7);
                } else {
                    0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, *v104, @0x0, v109, *v26, arg0, arg7);
                };
            };
            let v113 = 0;
            while (v113 < 0x1::vector::length<address>(&v6)) {
                let v114 = *0x1::vector::borrow<address>(&v6, v113);
                let v115 = if (v114 != v99) {
                    if (v5 < 2 || v114 != *v102) {
                        v5 < 3 || v114 != *v104
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v115) {
                    let v116 = *0x2::table::borrow<address, u64>(&v9, v114);
                    let v117 = v116 / 10;
                    let v118 = v116 + v117 - *0x2::table::borrow<address, u64>(&v27, v114);
                    if (v118 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v118), arg7), v114);
                    };
                    if (v2) {
                        let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, @0x0, v114, v116, v117, arg0, v3, arg7);
                    } else {
                        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, @0x0, v114, v116, v117, arg0, arg7);
                    };
                };
                v113 = v113 + 1;
            };
            let v122 = v42 - *v22 - *v24 - *v26;
            if (v2) {
                let v123 = v122 / 5;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v123), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v122 - v123), arg7), v3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v44, v122), arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
            };
            if (v2) {
                let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v99, @0x0, v100, *v22, arg0, v3, arg7);
            } else {
                0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v99, @0x0, v100, *v22, arg0, arg7);
            };
        };
        0x2::table::drop<address, u64>(v9);
        0x2::table::drop<address, u64>(v10);
        *0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_active_mut(arg6) = false;
        0x2::table::drop<address, u64>(v27);
        let v127 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament>(arg6);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_tournament_finalized(0x2::object::id_to_address(&v127), v0, v43, v42, v5, 0x2::tx_context::epoch_timestamp_ms(arg7));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::try_check_and_award_medals_with_callers(arg1, arg2, 0x1::vector::empty<address>(), arg7);
    }

    public fun join_tournament(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg3: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        join_tournament_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun join_tournament_internal(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg3: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_active(arg5), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::tournament_closed());
        assert!(arg7 > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        let v0 = arg7 + arg7 / 10;
        assert!(0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg6)) >= v0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg6);
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, v1, arg7, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg2, arg3, arg4, arg8), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_is_external(arg5), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_api_caller(arg5)), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        0x2::vec_set::insert<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_players_mut(arg5), v1);
        0x2::table::add<address, u64>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_stakes_mut(arg5), v1, arg7);
        0x1::vector::push_back<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_stake_keys_mut(arg5), v1);
        0x2::balance::join<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_total_stake_mut(arg5), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance_mut(arg6), v0, arg8)));
    }

    public fun process_round(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg7: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::TournamentRound, arg8: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg9: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_round_number(arg7);
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_is_external(arg6);
        let v2 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_api_caller(arg6);
        assert!(0x2::tx_context::sender(arg13) == 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_creator(arg6), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_creator());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_active(arg6), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::tournament_closed());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_current_round(arg6) == v0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_round());
        let v3 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_round_pairings(arg7);
        let v4 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg8);
        let v5 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_owner(arg9);
        assert!(0x2::table::contains<address, address>(v3, v4), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_player());
        assert!(0x2::table::contains<address, address>(v3, v5), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_player());
        assert!(0x2::table::borrow<address, address>(v3, v4) == &v5, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_pairing());
        assert!(0x2::table::borrow<address, address>(v3, v5) == &v4, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_pairing());
        assert!(arg12 > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        let v6 = arg12 / 10;
        let v7 = arg12 + v6;
        let v8 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg9);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance(arg8)) >= v7, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        assert!(0x2::balance::value<0x2::sui::SUI>(v8) >= v7, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v9 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_total_stake_mut(arg6);
        0x2::balance::join<0x2::sui::SUI>(v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance_mut(arg8), v7, arg13)));
        0x2::balance::join<0x2::sui::SUI>(v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::wallet_balance_mut(arg9), v7, arg13)));
        let v10 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg3, arg4, arg5, arg13);
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, v4, arg12, v10, v1, v2) && 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, v5, arg12, v10, v1, v2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_stake_amount());
        let v11 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_scores_mut(arg6);
        if (!0x2::table::contains<address, u64>(v11, v4)) {
            0x2::table::add<address, u64>(v11, v4, 0);
        };
        if (!0x2::table::contains<address, u64>(v11, v5)) {
            0x2::table::add<address, u64>(v11, v5, 0);
        };
        let v12 = 0x2::table::borrow_mut<address, u64>(v11, v4);
        *v12 = *v12 + arg10;
        let v13 = 0x2::table::borrow_mut<address, u64>(v11, v5);
        *v13 = *v13 + arg11;
        let v14 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_round_winners_mut(arg7);
        let v15 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_total_stake_mut(arg6);
        if (arg10 > arg11) {
            0x2::vec_set::insert<address>(v14, v4);
            let (v16, v17, v18, v19) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, v4, v5, arg12, v6, v1, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v16), arg13), v4);
            let v20 = v7 - v17;
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v20), arg13), v5);
            };
            if (v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v18), arg13), v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v19), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v4, v5, arg12, v6, arg0, v2, arg13);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v19), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v4, v5, arg12, v6, arg0, arg13);
            };
        } else if (arg11 > arg10) {
            0x2::vec_set::insert<address>(v14, v5);
            let (v24, v25, v26, v27) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, v5, v4, arg12, v6, v1, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v24), arg13), v5);
            let v28 = v7 - v25;
            if (v28 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v28), arg13), v4);
            };
            if (v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v26), arg13), v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v27), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                let (_, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, v5, v4, arg12, v6, arg0, v2, arg13);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v27), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, v5, v4, arg12, v6, arg0, arg13);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v7), arg13), v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v7), arg13), v5);
            if (v1) {
                let v32 = v6 * 2 / 5;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v32), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v6 * 2 - v32), arg13), v2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v15, v6 * 2), arg13), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
            };
            let v33 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_players_mut(arg6);
            0x2::vec_set::remove<address>(v33, &v4);
            0x2::vec_set::remove<address>(v33, &v5);
        };
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::try_check_and_award_medals_with_callers(arg1, arg2, 0x1::vector::empty<address>(), arg13);
        let v34 = 0x2::object::id<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament>(arg6);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_tournament_round_processed(0x2::object::id_to_address(&v34), v0, 0x2::tx_context::epoch_timestamp_ms(arg13));
        *v14 = 0x2::vec_set::empty<address>();
    }

    public fun submit_score(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_active(arg0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::tournament_closed());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_creator(arg0) == 0x2::tx_context::sender(arg3), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        assert!(0x2::vec_set::contains<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_players(arg0), &arg1), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_player());
        0x2::table::add<address, u64>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::tournament_scores_mut(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

