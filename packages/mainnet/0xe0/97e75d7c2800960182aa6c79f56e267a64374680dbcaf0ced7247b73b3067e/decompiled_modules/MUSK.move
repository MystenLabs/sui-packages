module 0xe097e75d7c2800960182aa6c79f56e267a64374680dbcaf0ced7247b73b3067e::MUSK {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 9, b"LALA", b"Lala Token", b"Lala Token Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUSK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

