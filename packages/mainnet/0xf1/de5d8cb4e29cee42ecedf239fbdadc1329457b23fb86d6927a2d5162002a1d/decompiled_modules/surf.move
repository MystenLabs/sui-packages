module 0xf1de5d8cb4e29cee42ecedf239fbdadc1329457b23fb86d6927a2d5162002a1d::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 6, b"SURF", b"SURF WALLET", x"54686520626573742077616c6c6574206f6e0a537569204e6574776f726b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5811_db7a276c9d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

