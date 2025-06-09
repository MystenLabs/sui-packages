module 0xf61cd58371cc97128b651e6a4c3ad1c3582c8414f25fa58ee61db4ef26e01cf7::mmop {
    struct MMOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMOP>(arg0, 6, b"MMOP", b"MoonMop", b"MoonMop $MMOP | With tentacle hair! Ready to adventure & share laughter in Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiefc4hag5ojgw4eiogk4tgcxifxwe4inhxzxwdxpandf3in4nkqey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

