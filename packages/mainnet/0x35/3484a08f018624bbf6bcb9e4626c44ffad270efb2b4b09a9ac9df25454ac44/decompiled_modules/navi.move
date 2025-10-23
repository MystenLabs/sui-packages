module 0x353484a08f018624bbf6bcb9e4626c44ffad270efb2b4b09a9ac9df25454ac44::navi {
    struct NaviAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: vector<0x1::ascii::String>, arg2: vector<address>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        assert!(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5), 1300);
        let v1 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, &v0);
        let v2 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg6, arg3, arg0, arg4, arg1, arg2, &v1), arg7);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0x353484a08f018624bbf6bcb9e4626c44ffad270efb2b4b09a9ac9df25454ac44::utils::calculate_yield_earnings(arg5, v3, 0);
        if (v5 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::collect_performance_fee<T0>(arg5, 0x2::coin::split<T0>(&mut v2, v5, arg7));
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_reward<T0, NaviAdapterModule>(arg5, 0x2::coin::into_balance<T0>(v2), &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_earnings_event<NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg7);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_adapter_activity_event<NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::claim_reward_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg7);
    }

    public fun deposit<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_adapter_name<NaviAdapterModule>(arg5, 0x1::string::utf8(b"navi"), &v0);
        let v1 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::asset_balance<T0>(arg5);
        let v2 = if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, &v0)
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg7)
        };
        let v3 = v2;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg0, arg1, arg2, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_coin<T0, NaviAdapterModule>(arg5, v1, &v0, arg7), arg3, arg4, &v3);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, v3, &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::record_adapter_deposit<NaviAdapterModule>(arg5, v1, &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_adapter_activity_event<NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v1, arg7);
    }

    public fun withdraw_all<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        assert!(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg6), 1300);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_adapter_name<NaviAdapterModule>(arg6, 0x1::string::utf8(b""), &v0);
        let v1 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg6, &v0);
        let v2 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg5, arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1)) as u64)), arg3, arg4, &v1), arg8);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_object<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg6, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0x353484a08f018624bbf6bcb9e4626c44ffad270efb2b4b09a9ac9df25454ac44::utils::calculate_yield_earnings(arg6, v3, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::adapter_total_deposited<NaviAdapterModule>(arg6));
        if (v5 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::collect_performance_fee<T0>(arg6, 0x2::coin::split<T0>(&mut v2, v5, arg8));
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_coin<T0, NaviAdapterModule>(arg6, v2, &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::reset_adapter_deposits<NaviAdapterModule>(arg6, &v0);
        if (v4 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_earnings_event<NaviAdapterModule>(arg6, &v0, 0x1::string::utf8(b"navi"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg8);
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_adapter_activity_event<NaviAdapterModule>(arg6, &v0, 0x1::string::utf8(b"navi"), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg8);
    }

    // decompiled from Move bytecode v6
}

