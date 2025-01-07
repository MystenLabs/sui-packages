module 0x80f60cf594635993a6f4559bdc29ddf3329d8cacdd4d1fd6c0ce3bef4abeab93::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 6, b"Csui", b"c | Sui", x"48656164206f662052657461696c204d61726b6574696e67200a40537569466f756e646174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3054_e4343c63c7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

