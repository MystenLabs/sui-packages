module 0xb695213862c336d4b7bd2711aadfe412280465b7f3407dbe0e9f321ad8a120f4::alphalend {
    struct AlphalendAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1)) {
            return
        };
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg0, arg2, &v1, arg3, arg4);
        let v4 = v2;
        0x2::coin::join<T0>(&mut v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, v3, arg3, arg4));
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v1, &v0);
        let v5 = 0x2::coin::value<T0>(&v4);
        let (v6, v7, v8) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg1, v5, 0);
        if (v7 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, AlphalendAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v4, v7, arg4), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_reward<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, AlphalendAdapterModule>(arg1, 0x2::coin::into_balance<T0>(v4), &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0x1::type_name::with_defining_ids<T0>(), v6, v7, v8, arg4);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::claim_reward_operation(), 0x1::type_name::with_defining_ids<T0>(), v5, arg4);
    }

    public fun deposit<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<AlphalendAdapterModule>(arg1, 0x1::string::utf8(b"alphalend"), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg1);
        let v2 = if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0)
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg0, arg4)
        };
        let v3 = v2;
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg0, &v3, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, AlphalendAdapterModule>(arg1, v1, &v0, arg4), arg3, arg4);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v3, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_record_deposit<AlphalendAdapterModule>(arg1, v1, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v1, arg4);
    }

    public fun withdraw_all<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterModule{dummy_field: false};
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1), 1000);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<AlphalendAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, &v0);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg0, &v1, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v1), arg3), arg3), arg3, arg4);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphalendAdapterModule>(arg1, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg1, v3, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_get_total_deposited<AlphalendAdapterModule>(arg1, &v0));
        if (v5 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, AlphalendAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v2, v5, arg4), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, AlphalendAdapterModule>(arg1, v2, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_reset_deposits<AlphalendAdapterModule>(arg1, &v0);
        if (v4 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg4);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, AlphalendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"alphalend"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg4);
    }

    // decompiled from Move bytecode v6
}

