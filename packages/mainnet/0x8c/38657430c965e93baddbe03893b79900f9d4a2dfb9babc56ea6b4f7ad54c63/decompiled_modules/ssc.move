module 0x8c38657430c965e93baddbe03893b79900f9d4a2dfb9babc56ea6b4f7ad54c63::ssc {
    struct SSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSC>(arg0, 8, b"SSC", b"SeashellCoin", b"GEMITA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSC>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

