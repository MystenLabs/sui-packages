module 0xf428b429055ad0fc92ceee2cd648188d04f886d04bc117fd8886d186af0c6801::gekmon {
    struct GEKMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEKMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEKMON>(arg0, 9, b"GEKMON", b"GEKMON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761662896/sui_tokens/qqezwfhvjhrrz9ew0x2k.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKMON>>(0x2::coin::mint<GEKMON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GEKMON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEKMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

