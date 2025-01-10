module 0xf5f5a19062bdaaee3a21a882b3ca18682e3dd929ace6ad84671e6188f8eeebf9::far {
    struct FAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAR>(arg0, 6, b"Far", b"Fishy-finger", b"Far jay jays", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736468230810.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

