module 0x2cc91099702d11628349e8a1a264d3ce0282677cc60a3fe9f4a6c03a1914d70e::depe {
    struct DEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPE>(arg0, 6, b"DEPE", b"Dark Lord Pepe", x"57656c636f6d6520746f204461726b204c6f72642050657065202824444550452920746865206d6f73742062756c6c697368204d656d65636f696e20504c4159206f662074686973206379636c652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/depe_451bebce7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

