module 0xbe7ebe17e3fbd76ada7762fd0dea4794689ea3a89ccf6c66ede271b1f7213ce6::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"TOKEN", b"token", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w7.pngwing.com/pngs/527/648/png-transparent-person-smile-joy-stupidity-foolish-crazy-the-language-portrait-view-eyes.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

