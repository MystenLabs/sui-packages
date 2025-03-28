module 0x2bb37f9ef0bc2b335407b87f99763cb722a8b3f41ebfc0fcd484268cc995a31f::kara_coin {
    struct KARA_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KARA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KARA_COIN>>(0x2::coin::mint<KARA_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KARA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARA_COIN>(arg0, 8, b"KRSW", b"Karacoin", b"Karacoin comes from a Japanese internet meme called \"Koshinism.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://krsw-wiki.in/images/3/37/KoshinismMark.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

