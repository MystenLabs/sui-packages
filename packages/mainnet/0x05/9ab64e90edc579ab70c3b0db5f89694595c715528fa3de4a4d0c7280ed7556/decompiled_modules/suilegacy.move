module 0x59ab64e90edc579ab70c3b0db5f89694595c715528fa3de4a4d0c7280ed7556::suilegacy {
    struct SUILEGACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEGACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEGACY>(arg0, 9, b"SUIlegacy", b"SUILEGACY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761230224/sui_tokens/g0yeazmsgmuoxpqkxqi4.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEGACY>>(0x2::coin::mint<SUILEGACY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUILEGACY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEGACY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

