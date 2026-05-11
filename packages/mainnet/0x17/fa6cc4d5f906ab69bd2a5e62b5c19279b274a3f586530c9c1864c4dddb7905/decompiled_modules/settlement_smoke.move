module 0x17fa6cc4d5f906ab69bd2a5e62b5c19279b274a3f586530c9c1864c4dddb7905::settlement_smoke {
    public(friend) fun native_sui_order_payment_supported() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::order_payment_assets::is_supported_order_payment_sui_type<0x2::sui::SUI>()
    }

    public(friend) fun native_sui_payment_matches_native_bond() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::payment_assets::typed_order_payment_matches_dispute_bond_asset<0x2::sui::SUI, 0x2::sui::SUI>()
    }

    public(friend) fun typed_non_sui_dispute_bond_stays_closed<T0>() : bool {
        !0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::payment_assets::is_supported_dispute_bond_typed_coin_type<T0>()
    }

    public(friend) fun typed_non_sui_reviewer_stake_stays_closed<T0>() : bool {
        !0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::payment_assets::is_supported_reviewer_stake_typed_coin_type<T0>()
    }

    // decompiled from Move bytecode v7
}

