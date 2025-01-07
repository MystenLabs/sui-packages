module 0x417fb795d4143c42c90745bbd8509f42c2c074250cea95fdf73ccae5cffab9b2::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 6, b"HOLD", b"HOLD SUI", b"If you can't $HOLD, you won't be rich.SUI $5 | https://www.holdsui.vip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hold_logo_93ff63c15c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

