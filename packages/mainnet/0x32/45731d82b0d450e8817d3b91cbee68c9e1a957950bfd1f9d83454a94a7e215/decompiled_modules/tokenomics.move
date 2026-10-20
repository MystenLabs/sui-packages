module 0x3245731d82b0d450e8817d3b91cbee68c9e1a957950bfd1f9d83454a94a7e215::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3245731d82b0d450e8817d3b91cbee68c9e1a957950bfd1f9d83454a94a7e215::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fee_mint::mint_on_loss<T0, 0x3245731d82b0d450e8817d3b91cbee68c9e1a957950bfd1f9d83454a94a7e215::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        0x3245731d82b0d450e8817d3b91cbee68c9e1a957950bfd1f9d83454a94a7e215::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fee_mint::minted_out(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

