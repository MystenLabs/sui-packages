module 0x616aa657a6910ce4f48fdd2ca214c9e639e31a3a0b310520c4c70d64e02f89f::far {
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

