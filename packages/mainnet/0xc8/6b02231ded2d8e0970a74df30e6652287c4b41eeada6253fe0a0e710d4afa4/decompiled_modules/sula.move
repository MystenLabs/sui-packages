module 0xc86b02231ded2d8e0970a74df30e6652287c4b41eeada6253fe0a0e710d4afa4::sula {
    struct SULA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULA>(arg0, 6, b"SULA", b"Suiland Coin", b"A Dynamic and Thrilling WEB3 Game Experience on SUI Network. Play-to-Earn experience with SUILAND.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rlogo_92ca347a19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULA>>(v1);
    }

    // decompiled from Move bytecode v6
}

