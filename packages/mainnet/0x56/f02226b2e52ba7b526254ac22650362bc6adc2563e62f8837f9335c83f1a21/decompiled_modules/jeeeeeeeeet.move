module 0x56f02226b2e52ba7b526254ac22650362bc6adc2563e62f8837f9335c83f1a21::jeeeeeeeeet {
    struct JEEEEEEEEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEEEEEEEEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEEEEEEEEET>(arg0, 6, b"JEEEEEEEEET", b"RUG BY DEV JEETED BY HOLDER", b"WELCOME TO HELL WHY YOU JOIN IDIOT  YOU WANT LOSE MONEY  LETS BUY THIS SHIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123123123123_bb59d10c2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEEEEEEEEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEEEEEEEEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

