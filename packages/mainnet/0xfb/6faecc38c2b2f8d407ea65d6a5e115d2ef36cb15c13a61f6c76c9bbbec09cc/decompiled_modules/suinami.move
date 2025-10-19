module 0xfb6faecc38c2b2f8d407ea65d6a5e115d2ef36cb15c13a61f6c76c9bbbec09cc::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 9, b"SUINAMI", b"SUINAMI", b"It's not just a token, it's a wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1760884880/sui_tokens/h6lahecrmwzmekviglg9.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINAMI>>(0x2::coin::mint<SUINAMI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINAMI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINAMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

