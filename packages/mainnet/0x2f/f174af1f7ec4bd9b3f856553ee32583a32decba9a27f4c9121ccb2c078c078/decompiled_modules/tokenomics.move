module 0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fee_mint::mint_on_loss<T0, 0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun mint_pending_for<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::claim_pending_for<T0>(arg0, arg1, arg2);
        if (0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::basis(&v0) == 0) {
            0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::discard_zero_loss(v0);
            return
        };
        let v1 = MintWitness{dummy_field: false};
        let (v2, v3, v4, v5, v6) = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fee_mint::mint_on_loss<T0, 0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT, MintWitness>(v1, arg0, arg1, arg2, v0, arg3, arg4);
        0x2::coin::destroy_zero<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(v6);
        if (v4 > 0) {
            0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_mint_event(v2, v3, v4, v5);
        };
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fee_mint::minted_out(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

