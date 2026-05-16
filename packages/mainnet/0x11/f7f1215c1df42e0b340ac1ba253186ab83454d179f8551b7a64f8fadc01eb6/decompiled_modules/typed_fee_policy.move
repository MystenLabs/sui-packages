module 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy {
    public fun exact_typed_fee_policy_required<T0>() : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_typed_coin_type<T0>()
    }

    public fun fee_policy_exact_typed_order_asset() : u8 {
        2
    }

    public fun fee_policy_native_sui() : u8 {
        1
    }

    public fun fee_policy_unsupported() : u8 {
        0
    }

    public fun generic_zero_fee_path_rejected<T0>() : bool {
        true
    }

    public fun native_sui_fee_policy_active<T0>() : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_sui_type<T0>()
    }

    public fun native_sui_fee_policy_kind() : u8 {
        order_payment_fee_policy_kind<0x2::sui::SUI>()
    }

    public fun order_payment_fee_asset_matches_order_asset<T0, T1>() : bool {
        if (!exact_typed_fee_policy_required<T1>()) {
            return false
        };
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::same_supported_order_typed_non_sui_asset<T0, T1>()
    }

    public fun order_payment_fee_policy_defined<T0>() : bool {
        native_sui_fee_policy_active<T0>() || exact_typed_fee_policy_required<T0>()
    }

    public fun order_payment_fee_policy_kind<T0>() : u8 {
        if (native_sui_fee_policy_active<T0>()) {
            return 1
        };
        if (exact_typed_fee_policy_required<T0>()) {
            return 2
        };
        0
    }

    public fun typed_collateral_fee_policy_closed<T0>() : bool {
        !0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::payment_assets::is_supported_reviewer_stake_typed_coin_type<T0>()
    }

    // decompiled from Move bytecode v7
}

