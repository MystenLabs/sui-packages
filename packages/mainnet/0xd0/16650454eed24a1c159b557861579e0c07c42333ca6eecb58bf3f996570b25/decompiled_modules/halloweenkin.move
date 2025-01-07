module 0xd016650454eed24a1c159b557861579e0c07c42333ca6eecb58bf3f996570b25::halloweenkin {
    struct HALLOWEENKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEENKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEENKIN>(arg0, 6, b"HALLOWEENKIN", b"Halloweenkin", x"48616c6c6f7765656e2050756d706b696e20737469636b6572206d656d652050726f6a656374200a687474703a2f2f742e6d652f616464737469636b6572732f48616c6c6f7765656e6b696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031395_e2feef47bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEENKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEENKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

