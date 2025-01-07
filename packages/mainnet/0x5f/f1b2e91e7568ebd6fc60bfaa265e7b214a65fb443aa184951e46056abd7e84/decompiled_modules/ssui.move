module 0x5ff1b2e91e7568ebd6fc60bfaa265e7b214a65fb443aa184951e46056abd7e84::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"SUIMIPOUR", b"Simipour is one of the strongest special wallbreakers in ZU, with high Special Attack, a great Speed tier, and access to Nasty Plot. Backing this up is a good movepool, with an incredibly strong STAB move in Hydro Pump and great coverage moves like Ice Beam and Focus Blast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JWjD74e.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSUI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

