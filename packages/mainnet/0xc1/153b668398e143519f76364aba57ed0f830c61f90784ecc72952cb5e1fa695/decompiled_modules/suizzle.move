module 0xc1153b668398e143519f76364aba57ed0f830c61f90784ecc72952cb5e1fa695::suizzle {
    struct SUIZZLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZLE>(arg0, 9, b"SUIZZLE", b"Suizzle", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/Bh2sI5t.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZZLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZZLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

