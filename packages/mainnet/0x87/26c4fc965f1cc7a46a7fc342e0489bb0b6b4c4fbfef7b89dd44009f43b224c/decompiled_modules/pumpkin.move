module 0x8726c4fc965f1cc7a46a7fc342e0489bb0b6b4c4fbfef7b89dd44009f43b224c::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 9, b"PUMPKIN", b"PUMPKIN", b"OCTOBER PUMP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759407290/sui_tokens/eejgpsxjx9sv48i0m6wc.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMPKIN>>(0x2::coin::mint<PUMPKIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMPKIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMPKIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

