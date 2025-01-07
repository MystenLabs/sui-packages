module 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::actions {
    fun assert_epoch(arg0: &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &0x2::tx_context::TxContext) {
        assert!(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::active_epoch(arg0) == 0x2::tx_context::epoch(arg1), 0);
    }

    fun assert_provided_afsui_amount(arg0: &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>) {
        assert!(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_to_sui(arg0, arg1, 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2)) >= 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::min_staking_threshold(arg0), 7);
    }

    fun assert_validator_has_sufficient_onchain_history(arg0: &0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x3::staking_pool::StakedSui, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x3::staking_pool::pool_id(arg2);
        assert!(0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(0x3::sui_system::pool_exchange_rates(arg1, &v0), 0x2::tx_context::epoch(arg3) - 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::pool_rates_epoch_gap(arg0)), 4);
    }

    fun calc_amount_to_unstake(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u64 {
        let v0 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_to_sui(arg0, arg1, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_bin_value(arg0));
        if (v0 >= 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_reserves_value(arg0)) {
            return v0 - 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_reserves_value(arg0)
        };
        0
    }

    public(friend) fun epoch_was_changed(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::active_epoch(arg0) != 0x2::tx_context::epoch(arg6), 1);
        let v0 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::active_epoch(arg0) + 1;
        if (!0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_epoch_processing(arg0)) {
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::switch_epoch_processing(arg0);
        };
        let v1 = 0;
        let v2 = 0x2::math::max(arg5, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::min_fields_requests_per_tx(arg0));
        if (!0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_inactive_stakes_processed(arg0) && v1 < v2) {
            let v3 = &mut v1;
            let v4 = process_inactive_stakes(arg0, v3, v2, arg6);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_is_inactive_stakes_processed(arg0, v4);
        };
        if (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_inactive_stakes_processed(arg0) && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_unstaking_deque_sorted(arg0) && v1 < v2) {
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_is_unstaking_deque_sorted(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sort_unstaking_deque(arg0, arg2, v0, v2, &mut v1));
        };
        if (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_unstaking_deque_sorted(arg0) && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_total_sui_amount_updated(arg0)) {
            let (v5, v6, v7) = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::calculate_total_amounts_in_vault(arg0, arg2, v0, v2, &mut v1);
            if (v5) {
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_total_sui_amount(arg0, v6);
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_total_rewards_amount(arg0, v7);
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_is_total_sui_amount_updated(arg0, v5);
                let v8 = calc_amount_to_unstake(arg0, arg1);
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_amount_to_unstake(arg0, v8);
            };
        };
        if (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_total_sui_amount_updated(arg0) && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_unstaking_from_storage_processed(arg0) && v1 < v2) {
            let v9 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::amount_to_unstake(arg0);
            let v10 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::unstake_from_storage(arg0, arg2, v9, v2, &mut v1, arg6);
            let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::join_into_sui_reserves(arg0, v10);
            if (v11 >= v9) {
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_is_unstaking_from_storage_processed(arg0, true);
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_reserves_before_unstake(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_reserves_value(arg0));
            } else {
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_amount_to_unstake(arg0, v9 - v11);
            };
        };
        if (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_unstaking_from_storage_processed(arg0) && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_pending_unstakes_processed(arg0) && v1 < v2) {
            let v12 = &mut v1;
            let v13 = process_pending_unstake_requests(arg0, arg1, arg3, arg4, v12, v2, arg6);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::set_is_pending_unstakes_processed(arg0, v13);
        };
        if (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_pending_unstakes_processed(arg0)) {
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::burn_afsui_bin(arg0, arg1, arg6);
            let v14 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(arg0);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::dec_total_sui_amount(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::reserves_before_unstake(arg0) - 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::sui_reserves_value(arg0));
            let v15 = 0;
            if (v14 != 0) {
                v15 = (((0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(arg0) as u128) * (0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_rewards_amount(arg0) as u128) / (v14 as u128)) as u64);
            };
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::update_total_rewards_amount(arg0, v15);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::switch_epoch_processing(arg0);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::inc_active_epoch(arg0);
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_epoch_was_changed_event(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::active_epoch(arg0), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(arg0), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_rewards_amount(arg0), 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1));
        } else {
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_one_round_of_epoch_processing_finished_event(0x2::object::id<0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1>(arg0), v0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_epoch_processing(arg0), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_pending_unstakes_processed(arg0), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_unstaking_deque_sorted(arg0));
        };
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::reward_caller_with_crank_incentives(arg0, v1, 0x2::tx_context::sender(arg6), arg6);
    }

    fun process_inactive_stakes(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : bool {
        while (*arg1 < arg2 && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_inactive_stakes_empty(arg0)) {
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::push_staked_sui(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::pop_inactive_stake(arg0), arg3);
            *arg1 = *arg1 + 2;
        };
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_inactive_stakes_empty(arg0)
    }

    fun process_pending_unstake_requests(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: &mut u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : bool {
        while (*arg4 < arg5 && !0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_pending_unstake_records_empty(arg0)) {
            let v0 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::pop_pending_unstake_record(arg0);
            let v1 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::requester(&v0);
            let v2 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::afsui_amount(&v0);
            let v3 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::afsui_to_sui(v2, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(arg0));
            let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::split_from_sui_reserves(arg0, v3), arg6);
            if (0x1::option::is_some<address>(&v1)) {
                let v5 = *0x1::option::borrow<address>(&mut v1);
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::take_default_unstake_protocol_fee(arg0, arg2, arg3, &mut v4, v5, arg6);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v5);
            } else {
                0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::join_into_atomic_unstake_sui_reserves(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
            };
            0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_unstaked_event(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::afsui_id(&v0), v2, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v4), v3, v1, 0x2::tx_context::epoch(arg6));
            *arg4 = *arg4 + 1;
        };
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::is_pending_unstake_records_empty(arg0)
    }

    public(friend) fun request_stake(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        assert_epoch(arg0, arg7);
        assert!(0x8e6adb40c50cf2ce81d7dd12d240fb881df715343ab61233124aadb87a9fd1fd::sui_system_utils::is_validator_active(arg2, &arg5), 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::min_staking_threshold(arg0) <= v0, 3);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg2, arg4, arg5, arg7);
        assert_validator_has_sufficient_onchain_history(arg0, arg2, &v1, arg7);
        let v2 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::calculations::sui_to_afsui(v0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::total_supply(arg1), 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::total_sui_amount(arg0));
        let v3 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::mint_afsui(arg0, arg1, v2, arg7);
        let v4 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::validator_fee(arg0, arg5, arg7);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::take_validator_fee(&mut v3, arg5, v4, arg7);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::push_inactive_stake(arg0, v1);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::inc_total_sui_amount(arg0, v0);
        let v5 = 0x2::tx_context::sender(arg7);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_staked_event(v5, arg5, 0x2::object::id<0x3::staking_pool::StakedSui>(&v1), 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), v0, 0x2::object::id<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&v3), v2, v4, 0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::referrer_for(arg3, v5), 0x2::tx_context::epoch(arg7), arg6);
        v3
    }

    public(friend) fun request_stake_staked_sui(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x3::staking_pool::StakedSui, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg2, arg4, arg6), arg6);
        request_stake(arg0, arg1, arg2, arg3, v0, arg5, true, arg6)
    }

    public(friend) fun request_stake_staked_sui_vec(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x3::staking_pool::StakedSui>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        assert!(!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&arg4), 5);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x8e6adb40c50cf2ce81d7dd12d240fb881df715343ab61233124aadb87a9fd1fd::sui_system_utils::request_withdraw_stake_vec_non_entry(arg2, arg4, arg6), arg6);
        request_stake(arg0, arg1, arg2, arg3, v0, arg5, true, arg6)
    }

    public(friend) fun request_stake_vec(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 5);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg4);
        request_stake(arg0, arg1, arg2, arg3, v0, arg5, false, arg6)
    }

    public(friend) fun request_unstake(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_epoch(arg0, arg3);
        assert_provided_afsui_amount(arg0, arg1, &arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg2);
        let v2 = 0x2::object::id<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&arg2);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::push_pending_unstake_record(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::new(0x1::option::some<address>(v0), v1, v2));
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::move_to_afsui_bin(arg0, arg2);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_unstake_requested_event(v2, v1, v0, 0x2::tx_context::epoch(arg3));
    }

    public(friend) fun request_unstake_atomic(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_epoch(arg0, arg5);
        assert_provided_afsui_amount(arg0, arg1, &arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg4);
        let v2 = 0x2::object::id<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&arg4);
        let v3 = 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::afsui_to_sui(arg0, arg1, v1);
        assert!(v3 <= 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::atomic_unstake_sui_reserves_value(arg0), 6);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::split_from_atomic_unstake_sui_reserves(arg0, v3), arg5);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::take_atomic_unstake_protocol_fee(arg0, arg2, arg3, &mut v4, v0, arg5);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::push_pending_unstake_record(arg0, 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::record::new(0x1::option::none<address>(), v1, v2));
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::move_to_afsui_bin(arg0, arg4);
        0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::events::emit_unstaked_event(v2, v1, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v4), 0x2::coin::value<0x2::sui::SUI>(&v4), 0x1::option::some<address>(v0), 0x2::tx_context::epoch(arg5));
        v4
    }

    public(friend) fun request_unstake_vec(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&arg2), 5);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&mut arg2);
        0x2::pay::join_vec<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&mut v0, arg2);
        request_unstake(arg0, arg1, v0, arg3);
    }

    public(friend) fun request_unstake_vec_atomic(arg0: &mut 0x202143b52d1a43a894f8c45a8ee222489f5d4354a722a328af125085566046d1::staked_sui_vault_state::StakedSuiVaultStateV1, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&arg4), 5);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&mut arg4);
        0x2::pay::join_vec<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&mut v0, arg4);
        request_unstake_atomic(arg0, arg1, arg2, arg3, v0, arg5)
    }

    // decompiled from Move bytecode v6
}

