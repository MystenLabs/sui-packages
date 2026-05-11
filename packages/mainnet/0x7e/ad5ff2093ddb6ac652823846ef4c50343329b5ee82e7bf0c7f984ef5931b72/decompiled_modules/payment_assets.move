module 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::payment_assets {
    public fun is_native_type<T0>() : bool {
        is_sui_type<T0>()
    }

    public fun is_sui_type<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::order_payment_assets::is_supported_order_payment_sui_type<T0>()
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

