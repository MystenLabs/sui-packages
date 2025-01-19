module 0x6ece52b510212a1b2d35697b96a48a9c747bc6d54153d0ec31a09eeeaf2035e9::president {
    struct PRESIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PRESIDENT>(arg0, 6, b"PRESIDENT", b"President TrumpAI by SuiAI", b"The 45th and 47th President Of the United States of America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2197_20f81ce14d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRESIDENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESIDENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

