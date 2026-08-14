module 0xb57ab4ec033faf8324ea9151adeef4b21a6b67e7e188a2f22511ac721273f74a::adaptt {
    struct ADAPTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAPTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAPTT>(arg0, 9, b"ADT", b"ADAPTT", b"ADAPTT is the testnet-only test token for ADAPT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ADAPTT>>(0x2::coin::mint<ADAPTT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADAPTT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADAPTT>>(v2);
    }

    // decompiled from Move bytecode v7
}

