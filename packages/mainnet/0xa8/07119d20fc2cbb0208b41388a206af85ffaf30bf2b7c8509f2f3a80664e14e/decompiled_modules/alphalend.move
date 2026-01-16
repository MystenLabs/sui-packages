module 0xa807119d20fc2cbb0208b41388a206af85ffaf30bf2b7c8509f2f3a80664e14e::alphalend {
    struct AlphalendAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        if (!0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1)) {
            return
        };
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg0, arg2, &v1, arg3, arg4);
        let v4 = v2;
        0x2::coin::join<T0>(&mut v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, v3, arg3, arg4));
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v1, &v0);
        let v5 = 0x2::coin::value<T0>(&v4);
        let (v6, v7, v8) = 0xa807119d20fc2cbb0208b41388a206af85ffaf30bf2b7c8509f2f3a80664e14e::utils::calculate_yield_earnings(arg1, v5, 0);
        if (v7 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::collect_performance_fee<T0, AlphalendAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v4, v7, arg4), &v0);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_reward<T0, AlphalendAdapterModule>(arg1, 0x2::coin::into_balance<T0>(v4), &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_earnings_event<AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0x1::type_name::with_defining_ids<T0>(), v6, v7, v8, arg4);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_adapter_activity_event<AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::claim_reward_operation(), 0x1::type_name::with_defining_ids<T0>(), v5, arg4);
    }

    public fun deposit<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::set_adapter_name<AlphalendAdapterModule>(arg1, 0x1::string::utf8(b"alphalend"), &v0);
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::asset_balance<T0>(arg1);
        let v2 = if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1)) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0)
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg0, arg4)
        };
        let v3 = v2;
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg0, &v3, arg2, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_coin<T0, AlphalendAdapterModule>(arg1, v1, &v0, arg4), arg3, arg4);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v3, &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::record_adapter_deposit<AlphalendAdapterModule>(arg1, v1, &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_adapter_activity_event<AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v1, arg4);
    }

    public fun withdraw_all<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        assert!(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1), 1000);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::set_adapter_name<AlphalendAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg0, &v1, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v1), arg3), arg3), arg3, arg4);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_object<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0xa807119d20fc2cbb0208b41388a206af85ffaf30bf2b7c8509f2f3a80664e14e::utils::calculate_yield_earnings(arg1, v3, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::adapter_total_deposited<AlphalendAdapterModule>(arg1));
        if (v5 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::collect_performance_fee<T0, AlphalendAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v2, v5, arg4), &v0);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_coin<T0, AlphalendAdapterModule>(arg1, v2, &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::reset_adapter_deposits<AlphalendAdapterModule>(arg1, &v0);
        if (v4 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_earnings_event<AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg4);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_adapter_activity_event<AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg4);
    }

    // decompiled from Move bytecode v6
}

