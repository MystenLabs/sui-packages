module 0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fee_mint::mint_on_loss<T0, 0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fee_mint::minted_out(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

