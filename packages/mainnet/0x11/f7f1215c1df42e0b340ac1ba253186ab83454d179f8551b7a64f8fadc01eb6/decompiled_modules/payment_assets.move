module 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::payment_assets {
    public fun is_native_type<T0>() : bool {
        is_sui_type<T0>()
    }

    public fun is_sui_type<T0>() : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_sui_type<T0>()
    }

    public fun is_supported_dispute_bond_typed_coin_type<T0>() : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::is_supported_dispute_bond_typed_non_sui_asset<T0>()
    }

    public fun is_supported_reviewer_stake_typed_coin_type<T0>() : bool {
        false
    }

    public fun typed_order_payment_matches_dispute_bond_asset<T0, T1>() : bool {
        if (is_sui_type<T1>()) {
            return is_sui_type<T0>()
        };
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::same_supported_order_typed_non_sui_asset<T0, T1>()
    }

    // decompiled from Move bytecode v7
}

