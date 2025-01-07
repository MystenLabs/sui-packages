module 0x7c0b788f32ccb44462dd485743509856c1008dbe59d4fc9d868cc510e8141da2::lotus {
    struct LOTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTUS>(arg0, 6, b"LOTUS", b"Black Lotus", b"Black Lotus - first lotus on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017001_76d84a9539.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

