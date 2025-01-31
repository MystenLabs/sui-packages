module 0x49317b0a8f5de1aa03cf05a70bee9c04eefb2197577d9a572358395c690506f8::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"Eco AI", x"45636f416c3a20416c2d64726976656e206167656e74732065636f73797374656d206372656174696e6720696e6e6f766174697665207574696c69746965732c2067656e65726174696e6720726576656e75652c20616e642070726f6d6f74696e67207375737461696e6162696c6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738343787487.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

