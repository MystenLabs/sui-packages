module 0xda147c984b6c9a0d17893122b172efae21fd80a90b5b7ca587e9b9ac4d6a70e7::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 9, b"CHOPSUI", b"CHOPSUI", b"CHOPSUI BULLRUN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759845935/sui_tokens/q9o1tihexakbnhc5qdx9.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOPSUI>>(0x2::coin::mint<CHOPSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHOPSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

