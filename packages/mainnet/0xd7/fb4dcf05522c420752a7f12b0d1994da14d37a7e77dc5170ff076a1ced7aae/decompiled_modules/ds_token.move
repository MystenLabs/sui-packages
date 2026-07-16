module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::ds_token {
    struct TransferApproval<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ClawbackApproval<phantom T0> has drop {
        dummy_field: bool,
    }

    struct DsTokenKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        paused: bool,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T0>>, arg4: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>, arg5: 0x1::string::String, arg6: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg6);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::owner<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>(&arg4));
        let v1 = 0x2::balance::value<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::funds<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>(&arg4)));
        assert!(v1 > 0, 13836466911930089483);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::BurnTokens>(arg1, 0x2::tx_context::sender(arg7)), 13835622495589498885);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::validate_burn<T0>(arg2, v0, v1);
        let v2 = ClawbackApproval<T0>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>, ClawbackApproval<T0>>(&mut arg4, v2);
        let v3 = TreasuryCapKey{dummy_field: false};
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v3), 0x2::coin::from_balance<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::resolve<0x2::balance::Balance<T0>>(arg4, arg3), arg7));
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg2, v0)) {
            let v4 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_id_by_wallet<T0>(arg2, v0);
            let v5 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance_total<T0>(arg2, v4);
            assert!(v5 >= v1, 13837592871966867473);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_investor_total_balance<T0>(arg2, v4, v5 - v1);
            let v6 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance<T0>(arg2, v0);
            assert!(v6 >= v1, 13837592897736671249);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_wallet_balance<T0>(arg2, v0, v6 - v1);
        } else if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg2, v0)) {
            let v7 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg2, v0);
            assert!(v7 >= v1, 13837592927801442321);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg2, v0, v7 - v1);
        };
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_burn_event<T0>(v0, v1, arg5);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_transfer_event<T0>(v0, @0x0, v1);
    }

    public fun transfer<T0>(arg0: &Treasury<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, arg3: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>, arg4: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg5: &0x2::clock::Clock) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg4);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::sender<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg3));
        let v1 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::recipient<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg3));
        let v2 = 0x2::balance::value<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::funds<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg3)));
        assert!(v2 > 0, 13836467405851328523);
        let v3 = if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg1, v0)) {
            if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg1, v1)) {
                is_paused<T0>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(!v3, 13835904490257383431);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::validate_transfer<T0>(arg2, arg1, arg3, 0x2::clock::timestamp_ms(arg5), arg4);
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg1, v1)) {
            let v4 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_id_by_wallet<T0>(arg1, v1);
            let v5 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance_total<T0>(arg1, v4) as u256) + (v2 as u256));
            assert!(0x1::option::is_some<u64>(&v5), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_investor_total_balance<T0>(arg1, v4, 0x1::option::extract<u64>(&mut v5));
            let v6 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance<T0>(arg1, v1) as u256) + (v2 as u256));
            assert!(0x1::option::is_some<u64>(&v6), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_wallet_balance<T0>(arg1, v1, 0x1::option::extract<u64>(&mut v6));
        } else if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg1, v1)) {
            let v7 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg1, v1) as u256) + (v2 as u256));
            assert!(0x1::option::is_some<u64>(&v7), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg1, v1, 0x1::option::extract<u64>(&mut v7));
        };
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg1, v0)) {
            let v8 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_id_by_wallet<T0>(arg1, v0);
            let v9 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance_total<T0>(arg1, v8);
            assert!(v9 >= v2, 13837593477557256209);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_investor_total_balance<T0>(arg1, v8, v9 - v2);
            let v10 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance<T0>(arg1, v0);
            assert!(v10 >= v2, 13837593507622027281);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_wallet_balance<T0>(arg1, v0, v10 - v2);
        } else if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg1, v0)) {
            let v11 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg1, v0);
            assert!(v11 >= v2, 13837593524801896465);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg1, v0, v11 - v2);
        };
        let v12 = TransferApproval<T0>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>, TransferApproval<T0>>(arg3, v12);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_transfer_event<T0>(v0, v1, v2);
    }

    public fun is_paused<T0>(arg0: &Treasury<T0>) : bool {
        arg0.paused
    }

    public fun issue_tokens<T0>(arg0: &mut Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg3: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, arg4: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg5: address, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg9);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::IssueTokens>(arg1, 0x2::tx_context::sender(arg14)), 13835621778329960453);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg4) == arg5, 13836184732578611209);
        let v0 = TreasuryCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0);
        issue_tokens_internal<T0>(arg2, arg3, arg5, arg6, 0x2::coin::total_supply<T0>(v1), arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T0>(arg4, 0x2::coin::mint_balance<T0>(v1, arg6));
    }

    fun issue_tokens_internal<T0>(arg0: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg8: vector<u64>, arg9: vector<u64>, arg10: u64, arg11: &0x2::clock::Clock) {
        assert!(arg3 > 0, 13836466589807542283);
        assert!(0x1::vector::length<u64>(&arg8) == 0x1::vector::length<u64>(&arg9), 13836748069079351309);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::validate_issue<T0>(arg1, arg0, arg2, arg3, arg4, arg10, v0, arg7);
        let v1 = 0;
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg0, arg2)) {
            let v2 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_id_by_wallet<T0>(arg0, arg2);
            let v3 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance_total<T0>(arg0, v2) as u256) + (arg3 as u256));
            assert!(0x1::option::is_some<u64>(&v3), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_investor_total_balance<T0>(arg0, v2, 0x1::option::extract<u64>(&mut v3));
            let v4 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance<T0>(arg0, arg2) as u256) + (arg3 as u256));
            assert!(0x1::option::is_some<u64>(&v4), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_wallet_balance<T0>(arg0, arg2, 0x1::option::extract<u64>(&mut v4));
            let v5 = 0;
            while (v5 < 0x1::vector::length<u64>(&arg8)) {
                let v6 = *0x1::vector::borrow<u64>(&arg8, v5);
                let v7 = 0x1::u256::try_as_u64((v1 as u256) + (v6 as u256));
                assert!(0x1::option::is_some<u64>(&v7), 13837875583894290451);
                v1 = 0x1::option::extract<u64>(&mut v7);
                0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::lock_manager::add_lock_internal<T0>(arg0, v2, v6, arg5, arg6, *0x1::vector::borrow<u64>(&arg9, v5), v0);
                v5 = v5 + 1;
            };
        } else if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg0, arg2)) {
            let v8 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg0, arg2) as u256) + (arg3 as u256));
            assert!(0x1::option::is_some<u64>(&v8), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg0, arg2, 0x1::option::extract<u64>(&mut v8));
        };
        assert!(v1 <= arg3, 13837029754509590543);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_issue_event<T0>(arg2, arg3, v1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_transfer_event<T0>(@0x0, arg2, arg3);
    }

    public fun issue_tokens_no_account<T0>(arg0: &mut Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg3: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::ComplianceConfig<T0>, arg4: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg5: address, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg9);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::IssueTokens>(arg1, 0x2::tx_context::sender(arg14)), 13835622001668259845);
        let v0 = TreasuryCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0);
        issue_tokens_internal<T0>(arg2, arg3, arg5, arg6, 0x2::coin::total_supply<T0>(v1), arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::balance::send_funds<T0>(0x2::coin::mint_balance<T0>(v1, arg6), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_address(arg4, arg5));
    }

    public(friend) fun new<T0: key>(arg0: &mut 0x2::object::UID, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin_registry::MetadataCap<T0>, arg5: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg6: &0x2::tx_context::TxContext) : Treasury<T0> {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::IssueTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::BurnTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SeizeTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::MetadataUpdate>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTemplateCommand>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::AccessPolicyCap>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Master, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::Pauser>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Issuer, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::IssueTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Issuer, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::BurnTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::BurnTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SeizeTokens>(arg1, arg5, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::add_role_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::TransferAgent, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::Pauser>(arg1, arg5, arg6);
        let v0 = DsTokenKey<T0>{dummy_field: false};
        let v1 = Treasury<T0>{
            id           : 0x2::derived_object::claim<DsTokenKey<T0>>(arg0, v0),
            metadata_cap : arg4,
            paused       : false,
        };
        let (v2, v3) = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::new_for_currency<T0>(arg2, &mut arg3, true);
        let v4 = v3;
        let v5 = v2;
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T0>, TransferApproval<T0>>(&mut v5, &v4, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::send_funds_action());
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T0>, ClawbackApproval<T0>>(&mut v5, &v4, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::clawback_funds_action());
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::share<0x2::balance::Balance<T0>>(v5);
        let v6 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v1.id, v6, arg3);
        let v7 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PolicyCapKey, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T0>>>(&mut v1.id, v7, v4);
        v1
    }

    public fun pause<T0>(arg0: &mut Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::Pauser>(arg1, 0x2::tx_context::sender(arg3)), 13835623556446420997);
        assert!(!is_paused<T0>(arg0), 13835060610787704833);
        arg0.paused = true;
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_pause_event<T0>(0x2::tx_context::sender(arg3));
    }

    public fun policy_cap<T0>(arg0: &Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &0x2::tx_context::TxContext) : &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T0>> {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::AccessPolicyCap>(arg1, 0x2::tx_context::sender(arg3)), 13835623715360210949);
        let v0 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PolicyCapKey, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T0>>>(&arg0.id, v0)
    }

    public fun seize<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::InvestorInfo<T0>, arg2: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T0>>, arg3: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>, arg4: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg5: address, arg6: 0x1::string::String, arg7: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg7);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::owner<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>(&arg3));
        let v1 = 0x2::balance::value<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::funds<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>>(&arg3)));
        assert!(v1 > 0, 13836467161038192651);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SeizeTokens>(arg0, 0x2::tx_context::sender(arg8)), 13835622744697602053);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg4) == arg5, 13836185698946252809);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::compliance_service::validate_seize<T0>(arg1, v0, arg5, v1);
        let v2 = ClawbackApproval<T0>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::ClawbackFunds<0x2::balance::Balance<T0>>, ClawbackApproval<T0>>(&mut arg3, v2);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T0>(arg4, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds::resolve<0x2::balance::Balance<T0>>(arg3, arg2));
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg1, arg5)) {
            let v3 = 0x1::u256::try_as_u64((0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg1, arg5) as u256) + (v1 as u256));
            assert!(0x1::option::is_some<u64>(&v3), 13837875583894290451);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg1, arg5, 0x1::option::extract<u64>(&mut v3));
        };
        if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_wallet<T0>(arg1, v0)) {
            let v4 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::get_investor_id_by_wallet<T0>(arg1, v0);
            let v5 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance_total<T0>(arg1, v4);
            assert!(v5 >= v1, 13837593151139741713);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_investor_total_balance<T0>(arg1, v4, v5 - v1);
            let v6 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::investor_wallet_balance<T0>(arg1, v0);
            assert!(v6 >= v1, 13837593168319610897);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_wallet_balance<T0>(arg1, v0, v6 - v1);
        } else if (0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::is_special_wallet<T0>(arg1, v0)) {
            let v7 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::special_wallet_balance<T0>(arg1, v0);
            assert!(v7 >= v1, 13837593185499480081);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::registry_service::update_special_wallet_total_balance<T0>(arg1, v0, v7 - v1);
        };
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_seize_event<T0>(v0, arg5, v1, arg6);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_transfer_event<T0>(v0, arg5, v1);
    }

    public fun set_metadata<T0>(arg0: &Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg6);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::MetadataUpdate>(arg1, 0x2::tx_context::sender(arg7)), 13835623307338317829);
        let v0 = &arg0.metadata_cap;
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v1 = 0x1::option::destroy_some<0x1::string::String>(arg3);
            0x2::coin_registry::set_name<T0>(arg2, v0, v1);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_name_updated_event<T0>(0x2::coin_registry::name<T0>(arg2), v1);
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v2 = 0x1::option::destroy_some<0x1::string::String>(arg4);
            0x2::coin_registry::set_description<T0>(arg2, v0, v2);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_description_updated_event<T0>(0x2::coin_registry::description<T0>(arg2), v2);
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg4);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            let v3 = 0x1::option::destroy_some<0x1::string::String>(arg5);
            0x2::coin_registry::set_icon_url<T0>(arg2, v0, v3);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_icon_uri_updated_event<T0>(0x2::coin_registry::icon_url<T0>(arg2), v3);
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg5);
        };
    }

    public fun set_template_command<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg2: 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Command, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTemplateCommand>(arg0, 0x2::tx_context::sender(arg4)), 13835623423302434821);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::set_template_command<TransferApproval<T0>>(arg1, 0x1::internal::permit<TransferApproval<T0>>(), arg2);
    }

    public(friend) fun share<T0>(arg0: Treasury<T0>) {
        0x2::transfer::share_object<Treasury<T0>>(arg0);
    }

    public fun unpause<T0>(arg0: &mut Treasury<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::Pauser>(arg1, 0x2::tx_context::sender(arg3)), 13835623638050799621);
        assert!(is_paused<T0>(arg0), 13835342167368925187);
        arg0.paused = false;
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_unpause_event<T0>(0x2::tx_context::sender(arg3));
    }

    public fun unset_template_command<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTemplateCommand>(arg0, 0x2::tx_context::sender(arg3)), 13835623483431976965);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::unset_template_command<TransferApproval<T0>>(arg1, 0x1::internal::permit<TransferApproval<T0>>());
    }

    // decompiled from Move bytecode v7
}

