module 0x47accfe6e8be9467f7fca5f13087ab81cec2c2560cea57c1e9b9b0a0d5785980::fast {
    struct FAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST>(arg0, 6, b"FAST", b"Fast and Bullish", b"$FAST (and bullish)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_e17df48f0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

