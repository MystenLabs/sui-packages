module 0x9a81c10a5809c963e34fe8d0ebc863521f23e8074f75b8385c53ade32c335111::CHILLGUY {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<CHILLGUY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLGUY>>(0x2::coin::split<CHILLGUY>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<CHILLGUY>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHILLGUY>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<CHILLGUY>(arg0);
        };
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGUY>(arg0, 9, b"CHILLGUY ", b"Just a Chill Guy", b"Just a Chill Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/b6nmFqY/png3.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGUY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLGUY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLGUY>>(0x2::coin::mint<CHILLGUY>(&mut v2, 6500000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

