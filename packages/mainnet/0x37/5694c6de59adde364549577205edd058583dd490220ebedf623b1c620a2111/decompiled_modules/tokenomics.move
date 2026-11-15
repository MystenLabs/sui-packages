module 0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fee_mint::mint_on_loss<T0, 0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fee_mint::minted_out(arg0, arg1)
    }

    public fun mint_pending_for<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::claim_pending_for<T0>(arg0, arg1, arg2);
        if (0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::basis(&v0) == 0) {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::discard_zero_loss(v0);
            return
        };
        let v1 = MintWitness{dummy_field: false};
        let (v2, v3, v4, v5, v6) = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fee_mint::mint_on_loss<T0, 0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::parchment::PARCHMENT, MintWitness>(v1, arg0, arg1, arg2, v0, arg3, arg4);
        0x2::coin::destroy_zero<0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::parchment::PARCHMENT>(v6);
        if (v4 > 0) {
            0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::events::emit_mint_event(v2, v3, v4, v5);
        };
    }

    // decompiled from Move bytecode v7
}

