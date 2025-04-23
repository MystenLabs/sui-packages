module 0xc93b531bdad2e8ef30cd2ce8d0f688dd4aba7ffd3a4e46506b721e4f7f745522::toldyou {
    struct TOLDYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLDYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLDYOU>(arg0, 6, b"Toldyou", b"told you not to sell", b"told you not to sell ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1220_ea12a66b0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLDYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOLDYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

