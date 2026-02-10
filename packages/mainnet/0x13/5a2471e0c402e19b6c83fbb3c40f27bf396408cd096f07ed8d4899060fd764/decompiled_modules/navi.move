module 0x135a2471e0c402e19b6c83fbb3c40f27bf396408cd096f07ed8d4899060fd764::navi {
    struct NaviAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: vector<0x1::ascii::String>, arg2: vector<address>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5), 1300);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, &v0);
        let v2 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg6, arg3, arg0, arg4, arg1, arg2, &v1), arg7);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg5, v3, 0);
        if (v5 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, NaviAdapterModule>(arg5, 0x2::coin::split<T0>(&mut v2, v5, arg7), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_reward<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, NaviAdapterModule>(arg5, 0x2::coin::into_balance<T0>(v2), &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg7);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::claim_reward_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg7);
    }

    public fun deposit<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<NaviAdapterModule>(arg5, 0x1::string::utf8(b"navi"), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg5);
        let v2 = if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, &v0)
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg7)
        };
        let v3 = v2;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg0, arg1, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, NaviAdapterModule>(arg5, v1, &v0, arg7), arg3, arg4, &v3);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg5, v3, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_record_deposit<NaviAdapterModule>(arg5, v1, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, NaviAdapterModule>(arg5, &v0, 0x1::string::utf8(b"navi"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v1, arg7);
    }

    public fun withdraw_all<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterModule{dummy_field: false};
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg6), 1300);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<NaviAdapterModule>(arg6, 0x1::string::utf8(b""), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg6, &v0);
        let v2 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg5, arg0, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1)) as u64)), arg3, arg4, &v1), arg8);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviAdapterModule>(arg6, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg6, v3, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_get_total_deposited<NaviAdapterModule>(arg6, &v0));
        if (v5 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, NaviAdapterModule>(arg6, 0x2::coin::split<T0>(&mut v2, v5, arg8), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, NaviAdapterModule>(arg6, v2, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_reset_deposits<NaviAdapterModule>(arg6, &v0);
        if (v4 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, NaviAdapterModule>(arg6, &v0, 0x1::string::utf8(b"navi"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg8);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, NaviAdapterModule>(arg6, &v0, 0x1::string::utf8(b"navi"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg8);
    }

    // decompiled from Move bytecode v6
}

