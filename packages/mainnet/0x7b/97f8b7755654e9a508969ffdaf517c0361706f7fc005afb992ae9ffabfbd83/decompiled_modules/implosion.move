module 0x7b97f8b7755654e9a508969ffdaf517c0361706f7fc005afb992ae9ffabfbd83::implosion {
    struct IMPLOSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMPLOSION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMPLOSION>(arg0, 9, b"IMPLOSION", b"implosionpad.fun", b"The native token of Implosionpad, the single-sided launchpad on Sui. Liquidity locked forever. Trading fees fund buybacks and burns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://implosionpad.fun/uploads/46c1f8408455d8d4d51c2e25.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMPLOSION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMPLOSION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

