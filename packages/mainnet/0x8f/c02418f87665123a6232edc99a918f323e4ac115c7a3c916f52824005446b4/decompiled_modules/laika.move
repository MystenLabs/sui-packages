module 0x8fc02418f87665123a6232edc99a918f323e4ac115c7a3c916f52824005446b4::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 6, b"LAIKA", b"Sui Laika", x"41207370616365206a6f75726e657920776974686f757420612072657475726e207469636b65740a4c61696b6120697320746865206d6f73742066616d6f757320646f6720696e2074686520776f726c642e0a746865206669727374206c6976696e6720637265617475726520746f2062652073656e7420696e746f2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Laika_900b104f9d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

