module 0xc325df1243f1c4e4e6bcd644428322e405bbc53b34350c31c663c69310cb67e1::frogo {
    struct FROGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGO>(arg0, 6, b"Frogo", b"Frgo", b"The Sui's Frogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063399_3b9b63265f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

