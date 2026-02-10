module 0xf2fafbf6444b76680fdf05daf5551aa732e85f0d08c4206762d06d72a3dd3005::margin {
    struct DeepBookMarginAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookMarginAdapterModule{dummy_field: false};
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<DeepBookMarginAdapterModule>(arg2, 0x1::string::utf8(b"deepbook_margin"), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg2);
        let v2 = if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg2)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, DeepBookMarginAdapterModule>(arg2, &v0)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg1, arg3, arg4)
        };
        let v3 = v2;
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg0, arg1, &v3, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, DeepBookMarginAdapterModule>(arg2, v1, &v0, arg4), 0x1::option::none<0x2::object::ID>(), arg3);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, DeepBookMarginAdapterModule>(arg2, v3, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_record_deposit<DeepBookMarginAdapterModule>(arg2, v1, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, DeepBookMarginAdapterModule>(arg2, &v0, 0x1::string::utf8(b"deepbook_margin"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v1, arg4);
    }

    public fun withdraw_all<T0>(arg0: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookMarginAdapterModule{dummy_field: false};
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg2), 1400);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<DeepBookMarginAdapterModule>(arg2, 0x1::string::utf8(b""), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, DeepBookMarginAdapterModule>(arg2, &v0);
        let v2 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg0, arg1, &v1, 0x1::option::none<u64>(), arg3, arg4);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, DeepBookMarginAdapterModule>(arg2, v1, &v0);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5, v6) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg2, v3, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_get_total_deposited<DeepBookMarginAdapterModule>(arg2, &v0));
        if (v5 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, DeepBookMarginAdapterModule>(arg2, 0x2::coin::split<T0>(&mut v2, v5, arg4), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, DeepBookMarginAdapterModule>(arg2, v2, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_reset_deposits<DeepBookMarginAdapterModule>(arg2, &v0);
        if (v4 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, DeepBookMarginAdapterModule>(arg2, &v0, 0x1::string::utf8(b"deepbook_margin"), 0x1::type_name::with_defining_ids<T0>(), v4, v5, v6, arg4);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, DeepBookMarginAdapterModule>(arg2, &v0, 0x1::string::utf8(b"deepbook_margin"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v3, arg4);
    }

    // decompiled from Move bytecode v6
}

