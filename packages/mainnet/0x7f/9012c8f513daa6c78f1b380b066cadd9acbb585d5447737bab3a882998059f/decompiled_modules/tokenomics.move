module 0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::tokenomics {
    public fun mint_on_loss<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::parchment::PARCHMENT> {
        let (v0, v1, v2, v3, v4) = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fee_mint::mint_on_loss<T0, 0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::parchment::PARCHMENT>(arg0, arg1, arg2, arg3, arg4);
        0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::events::emit_mint_event(v0, v1, v2, v3);
        v4
    }

    public fun minted_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fee_mint::minted_out(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

