module 0x9325d2147c7b13f5f70389ba1c212a6967c359098a5aa9a7c2133eb1aeb73b17::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"wCAT", b"Water Cat", x"43617420696e2077617465722c206f6e207375692e200a0a4e6f20736f6369616c732c206974277320612063617420696e2074686520737569207761746572732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001140_02771ccdd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

