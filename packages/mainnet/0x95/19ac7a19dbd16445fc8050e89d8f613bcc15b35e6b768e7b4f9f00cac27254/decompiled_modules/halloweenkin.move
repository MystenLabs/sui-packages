module 0x9519ac7a19dbd16445fc8050e89d8f613bcc15b35e6b768e7b4f9f00cac27254::halloweenkin {
    struct HALLOWEENKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEENKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEENKIN>(arg0, 6, b"HALLOWEENKIN", b"Halloweenkin", x"48616c6c6f7765656e2050756d706b696e200a0a537469636b657220706163206973206c69766520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030900_538760b257.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEENKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEENKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

