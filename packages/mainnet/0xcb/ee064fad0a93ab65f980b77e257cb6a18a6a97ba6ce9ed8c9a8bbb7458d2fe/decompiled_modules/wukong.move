module 0xcbee064fad0a93ab65f980b77e257cb6a18a6a97ba6ce9ed8c9a8bbb7458d2fe::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Wukong", b"Game and Meme Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731115370918.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

