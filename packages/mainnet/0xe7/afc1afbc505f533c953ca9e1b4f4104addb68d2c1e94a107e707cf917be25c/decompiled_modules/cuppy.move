module 0xe7afc1afbc505f533c953ca9e1b4f4104addb68d2c1e94a107e707cf917be25c::cuppy {
    struct CUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPPY>(arg0, 6, b"CUPPY", b"Cuppy On Sui", x"43757070792069736e742061207765656b656e64206275696c642e0a0a57657665206265656e206275696c64696e672074686973207465726d696e616c20666f72206f7665722036206d6f6e74687320776974682061206465646963617465642066756c6c2d74696d65207465616d2e0a4e6f206f7574736f757263656420646576732e204e6f2073686f7274637574732e0a4a7573742068656164732d646f776e2070726f6475637420776f726b2c206576657279206461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20250505_014405_X_13b387204f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

