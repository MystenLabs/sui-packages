module 0x60eaa90cb51cc3fe04a2f576cc75419297f36460c2db456c1bcc5fe090393374::suidawg {
    struct SUIDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAWG>(arg0, 9, b"SUIDAWG", b"SUIDAWG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761483439/sui_tokens/lwnzfiur02sjmvqsq9jx.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDAWG>>(0x2::coin::mint<SUIDAWG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDAWG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDAWG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

