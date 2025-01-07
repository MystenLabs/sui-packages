module 0x38c9e081b0414e3585af7a00af1849f80e553cd29ed61acfd657243068833023::mint {
    struct MINT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MINT>>(0x2::coin::mint<MINT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINT>(arg0, 9, b"Cetus", b"Cetus", b"Cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/30256/standard/cetus.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MINT>>(v0);
    }

    // decompiled from Move bytecode v6
}

