module 0x62849578abaa264b0b38fc06f54d4b5b7df206bf2d1fde165500bef0f511c077::settlement_smoke {
    public(friend) fun native_sui_order_payment_supported() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::order_payment_assets::is_supported_order_payment_sui_type<0x2::sui::SUI>()
    }

    public(friend) fun native_sui_payment_matches_native_bond() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::payment_assets::typed_order_payment_matches_dispute_bond_asset<0x2::sui::SUI, 0x2::sui::SUI>()
    }

    public(friend) fun typed_non_sui_dispute_bond_stays_closed<T0>() : bool {
        !0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::payment_assets::is_supported_dispute_bond_typed_coin_type<T0>()
    }

    public(friend) fun typed_non_sui_reviewer_stake_stays_closed<T0>() : bool {
        !0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::payment_assets::is_supported_reviewer_stake_typed_coin_type<T0>()
    }

    // decompiled from Move bytecode v7
}

