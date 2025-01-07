module 0x52887d999d84f4d8e068e310d7ed828aba9659d1151d3df81f01a1fd42232d61::cchini {
    struct CCHINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCHINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCHINI>(arg0, 6, b"Cchini", b"Suicchini", b"Big GREEN SENDOOOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_09_11_30_607bf06407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCHINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCHINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

