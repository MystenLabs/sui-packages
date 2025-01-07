module 0x993cf087ec477e855bf6dfffac1e4d221cc15c6bce1798115dff505a096e0d18::botu {
    struct BOTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTU>(arg0, 6, b"BOTU", b"Book of Turbos", b"Study Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983685918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

