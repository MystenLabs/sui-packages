module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games {
    public fun external_pay_winner(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg4: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg5: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg6: &0x2::clock::Clock, arg7: 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::GameState, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_is_external(&arg7), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_verified_caller());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_requester(&arg7) == arg8 && 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_accepter(&arg7) == arg9, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_stake_amount(&arg7) > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_system_fee(&arg7);
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_stake_amount(&arg7);
        let v2 = v1 + v0;
        let v3 = v2 * 2;
        assert!(0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake(arg0)) >= v3, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v4 = 0x2::tx_context::sender(arg12);
        assert!(0x2::vec_set::contains<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist(arg3), &v4), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_verified_caller());
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg4, arg5, arg6, arg12);
        let (v5, v6, v7, v8, v9, v10) = if (arg10 > arg11) {
            let (v11, v12, v13, v14) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, arg8, arg9, v1, v0, true, v4);
            let (v15, v16, v17) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, arg8, arg9, v1, v0, arg0, v4, arg12);
            let v18 = if (v15 == v11) {
                if (v16 == v13) {
                    v17 == v14
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v18, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::amount_mismatch());
            (arg8, arg9, v11, v12, v13, v14)
        } else if (arg11 > arg10) {
            let (v19, v20, v21, v22) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, arg9, arg8, v1, v0, true, v4);
            let (v23, v24, v25) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_external_leaderboard(arg1, arg9, arg8, v1, v0, arg0, v4, arg12);
            let v26 = if (v23 == v19) {
                if (v24 == v21) {
                    v25 == v22
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v26, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::amount_mismatch());
            (arg9, arg8, v19, v20, v21, v22)
        } else {
            let v27 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v27, v2), arg12), arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v27, v2), arg12), arg9);
            (@0x0, @0x0, v2, v2, v0 * 8 / 10, v0 * 2 / 10)
        };
        if (v5 != @0x0) {
            let v28 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v28, v7), arg12), v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v28, v9), arg12), v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v28, v10), arg12), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
            let v29 = v2 - v8;
            if (v29 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v28, v29), arg12), v6);
            };
        };
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_external_game_completed(arg8, arg9, arg10, arg11, v5, v7, v9, v10, v3, v4, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_game_id(&arg7), 0x2::tx_context::epoch_timestamp_ms(arg12));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::try_check_and_award_medals_with_callers(arg1, arg2, 0x1::vector::singleton<address>(v4), arg12);
        let (v30, _, _, _, _, _, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::destroy_game_state(arg7);
        0x2::object::delete(v30);
    }

    public fun external_stake(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: address, arg10: address, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        let v0 = arg8 / 10;
        let v1 = arg8 + v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == v1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == v1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v2 = 0x2::tx_context::sender(arg12);
        assert!(0x2::vec_set::contains<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist(arg2), &v2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_verified_caller());
        let v3 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg3, arg4, arg5, arg12);
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, arg9, arg8, v3, true, v2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, arg10, arg8, v3, true, v2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        let v4 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        0x2::balance::join<0x2::sui::SUI>(v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::share_game_state(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_game_state(arg9, arg10, arg8, v0, true, v2, arg11, arg12));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_external_game_staked(arg9, arg10, arg8, v1 * 2, v0 * 2, v2, arg11, 0x2::tx_context::epoch_timestamp_ms(arg12));
    }

    public fun get_escrow_address(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0)
    }

    public fun get_stake_cap(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: address) : bool {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun get_total_stake(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake(arg0))
    }

    public fun pay_winner(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::GameState, arg7: address, arg8: address, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_is_external(&arg6), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::not_verified_caller());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_requester(&arg6) == arg7 && 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_accepter(&arg6) == arg8, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_stake_amount(&arg6) > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_system_fee(&arg6);
        let v1 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::game_state_stake_amount(&arg6);
        let v2 = v1 + v0;
        let v3 = v2 * 2;
        assert!(0x2::balance::value<0x2::sui::SUI>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake(arg0)) >= v3, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg3, arg4, arg5, arg11);
        let (v4, v5, v6, v7, v8) = if (arg9 > arg10) {
            let (v9, v10, v11, v12) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, arg7, arg8, v1, v0, false, @0x0);
            0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, arg7, arg8, v1, v0, arg0, arg11);
            let _ = v11;
            (v9, v10, v12, arg7, arg8)
        } else {
            let (v14, v15, v16, v17, v18, v19) = if (arg10 > arg9) {
                let (v20, v21, v22, v23) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::calculate_payout(arg1, arg8, arg7, v1, v0, false, @0x0);
                0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::update_leaderboard(arg1, arg8, arg7, v1, v0, arg0, arg11);
                (arg8, arg7, v20, v21, v22, v23)
            } else {
                let v24 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v24, v2), arg11), arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v24, v2), arg11), arg8);
                (@0x0, @0x0, v2, v2, 0, v0)
            };
            let _ = v18;
            (v16, v17, v19, v14, v15)
        };
        if (v7 != @0x0) {
            let v25 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v25, v4), arg11), v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v25, v6), arg11), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_escrow_address(arg0));
            let v26 = v2 - v5;
            if (v26 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v25, v26), arg11), v8);
            };
        };
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_game_completed(arg7, arg8, arg9, arg10, v7, v4, v0, v3, 0x2::tx_context::epoch_timestamp_ms(arg11));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::try_check_and_award_medals_with_callers(arg1, arg2, 0x1::vector::empty<address>(), arg11);
        let (v27, _, _, _, _, _, _, _) = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::destroy_game_state(arg6);
        0x2::object::delete(v27);
    }

    public fun stake(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg3: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: address, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::zero_amount());
        let v0 = arg7 / 10;
        let v1 = arg7 + v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == v1, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::insufficient_balance());
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg2, arg3, arg4, arg10);
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, v2, arg7, v3, false, @0x0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        assert!(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::utils::check_stake_cap(arg1, arg8, arg7, v3, false, @0x0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_amount());
        let v4 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::stake_pool_total_stake_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x2::balance::join<0x2::sui::SUI>(v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::share_game_state(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_game_state(v2, arg8, arg7, v0, false, @0x0, arg9, arg10));
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_game_staked(v2, arg8, arg7, v1 * 2, v0 * 2, 0x2::tx_context::epoch_timestamp_ms(arg10));
    }

    // decompiled from Move bytecode v6
}

