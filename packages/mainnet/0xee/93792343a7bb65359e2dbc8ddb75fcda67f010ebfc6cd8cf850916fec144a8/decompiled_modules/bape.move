module 0xee93792343a7bb65359e2dbc8ddb75fcda67f010ebfc6cd8cf850916fec144a8::bape {
    struct BAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPE>(arg0, 6, b"BAPE", b"Sui Baby Pepe", b"WELCOME TO $BEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_23_33_04_d785b6fea2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

