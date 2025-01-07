module 0x1415ac61f7cc24526247576c359ce02e836ea738268964db56fa78db2c6f0104::daagu {
    struct DAAGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAAGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAAGU>(arg0, 6, b"DaAgu", b"Agu", b"BigA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_299_da86f38a39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAAGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAAGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

