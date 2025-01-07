module 0x39b301ebd8856ab34164790e125d35c8ee7ec38d2807032ed2f0e3d1e6470e84::aaac {
    struct AAAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAC>(arg0, 6, b"AAAC", b"aaa coin", b"Just like aaa cat but a meme coin we can trust.  Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yes_f17c2e90bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

