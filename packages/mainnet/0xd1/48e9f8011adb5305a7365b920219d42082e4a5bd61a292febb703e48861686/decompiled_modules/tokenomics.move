module 0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::tokenomics {
    struct MintWitness has drop {
        dummy_field: bool,
    }

    public fun mint_on_loss<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg2: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT> {
        let v0 = MintWitness{dummy_field: false};
        let (v1, v2, v3, v4, v5) = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fee_mint::mint_on_loss<T0, 0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment::PARCHMENT, MintWitness>(v0, arg0, arg1, arg2, arg3, arg4);
        0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::events::emit_mint_event(v1, v2, v3, v4);
        v5
    }

    public fun minted_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fee_mint::minted_out(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

