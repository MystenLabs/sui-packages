module 0x330c0c46bc6cf0d42ffee7d1f847be97b1b981360e0da09e45c6fac7fb4899e2::dukes {
    struct DUKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKES>(arg0, 6, b"DUKES", b"DUKE", b"Duke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731516906999.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

