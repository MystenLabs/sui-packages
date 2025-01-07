module 0x148a4508d515989dac04e446037aefb29941051eff60c8f31c441d78d7ed1c0e::tgodpepe {
    struct TGODPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGODPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGODPEPE>(arg0, 6, b"TGODPEPE", b"The Godpepe", x"696e737069726564206279207468652066696c6d2054686520476f646661746865722c206d656d65207769746820746865206d6f73742062656c6f7665642066726f67206f6e2074686520696e7465726e657420706570652e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/de06feea21820f64e95b6483cdf24936_676c894a1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGODPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGODPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

