module 0x8973e7dae505d12c668d73cea5a85999be5b08a878f92b72beee59ec3c8d540a::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"Crash", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRASH>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRASH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CRASH>>(v2);
    }

    // decompiled from Move bytecode v6
}

