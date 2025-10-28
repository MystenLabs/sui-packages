module 0xaf45e4bbe022f06017c6595e1eb89c0c19ae6c8328b042ad586f02f212e939e::bluegek {
    struct BLUEGEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEGEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEGEK>(arg0, 9, b"BLUEGEK", b"BLUEGEK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761664550/sui_tokens/tfqwdmw1jzky1detsomx.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEGEK>>(0x2::coin::mint<BLUEGEK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEGEK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEGEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

