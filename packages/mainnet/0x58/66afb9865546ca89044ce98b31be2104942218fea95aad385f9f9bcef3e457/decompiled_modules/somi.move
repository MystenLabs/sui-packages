module 0x5866afb9865546ca89044ce98b31be2104942218fea95aad385f9f9bcef3e457::somi {
    struct SOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMI>(arg0, 6, b"SOMI", b"Somi", b"Sonic on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052617_37e5c73dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

