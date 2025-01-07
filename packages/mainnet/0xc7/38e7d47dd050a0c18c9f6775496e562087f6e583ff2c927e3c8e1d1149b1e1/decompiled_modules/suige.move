module 0xc738e7d47dd050a0c18c9f6775496e562087f6e583ff2c927e3c8e1d1149b1e1::suige {
    struct SUIGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGE>(arg0, 6, b"SUIGE", b"Suige", b"SUIGE The groovy Doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2467_1469ea9c97.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

