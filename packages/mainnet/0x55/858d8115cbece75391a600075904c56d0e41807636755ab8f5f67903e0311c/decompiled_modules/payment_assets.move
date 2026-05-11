module 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::payment_assets {
    public fun is_native_type<T0>() : bool {
        is_sui_type<T0>()
    }

    public fun is_sui_type<T0>() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::order_payment_assets::is_supported_order_payment_sui_type<T0>()
    }

    public fun is_supported_dispute_bond_typed_coin_type<T0>() : bool {
        false
    }

    public fun is_supported_reviewer_stake_typed_coin_type<T0>() : bool {
        false
    }

    public fun typed_order_payment_matches_dispute_bond_asset<T0, T1>() : bool {
        if (is_sui_type<T1>()) {
            return is_sui_type<T0>()
        };
        false
    }

    // decompiled from Move bytecode v7
}

