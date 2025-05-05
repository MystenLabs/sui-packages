module 0x8edbc6a47e6fe02b6b9424f0b746c47cf3eeaed3c6dfc6ddfb815a61c2f854a9::pogo {
    struct POGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGO>(arg0, 6, b"POGO", b"pokemon goo", b"pogo is utility from pokemon anime", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiggpaddip5df3updmdaoxuxyaely3xvxpapldbcts2vdgr3prxc4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

