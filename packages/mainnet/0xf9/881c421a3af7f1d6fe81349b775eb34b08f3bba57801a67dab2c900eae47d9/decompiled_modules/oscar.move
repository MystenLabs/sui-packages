module 0xf9881c421a3af7f1d6fe81349b775eb34b08f3bba57801a67dab2c900eae47d9::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"Oscar Lion", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSCAR>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OSCAR>>(v2);
    }

    // decompiled from Move bytecode v6
}

