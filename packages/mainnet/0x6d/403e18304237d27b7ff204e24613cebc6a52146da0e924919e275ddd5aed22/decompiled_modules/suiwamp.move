module 0x6d403e18304237d27b7ff204e24613cebc6a52146da0e924919e275ddd5aed22::suiwamp {
    struct SUIWAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAMP>(arg0, 9, b"SUIWAMP", b"SUIWAMP", b"SUIWAMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1760621310/sui_tokens/vcnyhuucxjsi5ojegowk.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIWAMP>>(0x2::coin::mint<SUIWAMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWAMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWAMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

