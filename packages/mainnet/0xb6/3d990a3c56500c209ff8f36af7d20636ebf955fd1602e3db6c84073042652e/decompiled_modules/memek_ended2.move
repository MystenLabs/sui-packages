module 0xb63d990a3c56500c209ff8f36af7d20636ebf955fd1602e3db6c84073042652e::memek_ended2 {
    struct MEMEK_ENDED2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ENDED2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ENDED2>(arg0, 6, b"MEMEKENDED2", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ENDED2>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ENDED2>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ENDED2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

