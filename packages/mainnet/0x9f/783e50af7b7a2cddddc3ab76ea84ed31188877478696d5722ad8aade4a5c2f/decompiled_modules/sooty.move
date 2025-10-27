module 0x9f783e50af7b7a2cddddc3ab76ea84ed31188877478696d5722ad8aade4a5c2f::sooty {
    struct SOOTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOTY>(arg0, 9, b"SOOTY", b"SOOTY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761564773/sui_tokens/juoi0w8dymegt6b9xkt6.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SOOTY>>(0x2::coin::mint<SOOTY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOOTY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOOTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

