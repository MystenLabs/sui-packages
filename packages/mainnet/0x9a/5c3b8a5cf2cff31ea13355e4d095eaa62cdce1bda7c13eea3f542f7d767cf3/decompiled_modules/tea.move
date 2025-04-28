module 0x9a5c3b8a5cf2cff31ea13355e4d095eaa62cdce1bda7c13eea3f542f7d767cf3::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 6, b"TEA", b"ALL LIFE IS TEA", b"TEA IS VERY IMPORTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/B6h248NJkAcBAkaCnji889a26tCiGXGN8cxhEJ4dX391.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEA>>(0x2::coin::mint<TEA>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEA>>(v2);
    }

    // decompiled from Move bytecode v6
}

