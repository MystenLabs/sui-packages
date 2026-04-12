module 0xc9bd275ab0c3c306fcd2646ecf02979a1956af98ba3e858ede516244ddbbd42c::mcombo {
    struct MCOMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOMBO>(arg0, 9, b"mCOMBO", b"mCOMBO", b"Combo coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/thumbnails/041/444/729/small/ai-generated-fresh-organic-potatoe-with-potato-slice-isolated-healthy-and-organic-food-ai-generated-transparent-with-shadow-png.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCOMBO>>(v1);
    }

    // decompiled from Move bytecode v7
}

