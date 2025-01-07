module 0xd3fb3696af416641e4598b6294853018c2918079122eb7b2090d1d04bc36cbf5::xpanda {
    struct XPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPANDA>(arg0, 6, b"XPANDA", b"XRPanda", b"A fun, meme-able panda mascot celebrating Ripple's hard-fought victory. Dedicated to Ripple's Victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731873398329.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

