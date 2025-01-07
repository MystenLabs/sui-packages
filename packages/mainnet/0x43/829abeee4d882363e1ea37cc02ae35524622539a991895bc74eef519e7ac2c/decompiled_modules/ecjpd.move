module 0x43829abeee4d882363e1ea37cc02ae35524622539a991895bc74eef519e7ac2c::ecjpd {
    struct ECJPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECJPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECJPD>(arg0, 6, b"ECJPD", b"Experienced CTO team just paid Dex", b"experienced cto team just paid Dex!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_26_08_18_08_9300882331.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECJPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECJPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

