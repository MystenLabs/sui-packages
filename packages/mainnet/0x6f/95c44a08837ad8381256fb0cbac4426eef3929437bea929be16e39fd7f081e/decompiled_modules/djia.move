module 0x6f95c44a08837ad8381256fb0cbac4426eef3929437bea929be16e39fd7f081e::djia {
    struct DJIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJIA>(arg0, 6, b"DJIA", b"DJIA6900", b"Dow Jones Industrial Average", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DJIA_4d2db77596.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

