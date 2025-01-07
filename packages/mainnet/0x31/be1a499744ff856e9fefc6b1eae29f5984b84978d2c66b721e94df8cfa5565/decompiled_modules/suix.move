module 0x31be1a499744ff856e9fefc6b1eae29f5984b84978d2c66b721e94df8cfa5565::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"Suix", b"Sui Sex", b"wwww.suisex.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisex11_778024f6a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

