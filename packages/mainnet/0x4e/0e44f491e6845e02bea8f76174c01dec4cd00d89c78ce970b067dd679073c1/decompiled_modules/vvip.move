module 0x4e0e44f491e6845e02bea8f76174c01dec4cd00d89c78ce970b067dd679073c1::vvip {
    struct VVIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVIP>(arg0, 6, b"VVIP", b"ALL VIP", b"ALL EXCLUSIVE VIPS SHOULD GET INTO THIS EARLY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731531303133.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

