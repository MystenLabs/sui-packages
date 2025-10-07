module 0x967a062105a6205e48d050f8606f73d39520c876f54a47403610edb37c8711bc::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 9, b"CHOPSUI", b"CHOPSUI", b"CHOPSUI BULLRUN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759846439/sui_tokens/omxoepb75gjnruejd3ae.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOPSUI>>(0x2::coin::mint<CHOPSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHOPSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

