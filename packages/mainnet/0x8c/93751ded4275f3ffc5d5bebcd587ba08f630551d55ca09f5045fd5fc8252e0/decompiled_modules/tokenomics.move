module 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fee_mint::mint_on_loss<T0, 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fee_mint::minted_out(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

