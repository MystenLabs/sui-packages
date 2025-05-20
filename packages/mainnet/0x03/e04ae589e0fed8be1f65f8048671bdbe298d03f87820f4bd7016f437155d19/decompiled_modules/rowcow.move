module 0x3e04ae589e0fed8be1f65f8048671bdbe298d03f87820f4bd7016f437155d19::rowcow {
    struct ROWCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWCOW>(arg0, 6, b"ROWCOW", b"MOONRAWCOW", b"RAWCOWWWWWWWWWWWWWWWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhv2ewxqjkpqnsifrjv2riqqfgx4vosyegsxwyusaps4hkeadpgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWCOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

