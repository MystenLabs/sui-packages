module 0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::parchment {
    struct PARCHMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHMENT>(arg0, 9, b"PARCHMENT", b"PARCHMENT", b"Freely transferable. Not collateral.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARCHMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun install_treasury<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<PARCHMENT>) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::install_reward_cap<T0, PARCHMENT>(arg0, arg1, arg2, arg3);
    }

    public fun supply<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>) : u64 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::reward_supply<T0, PARCHMENT>(arg0)
    }

    // decompiled from Move bytecode v7
}

