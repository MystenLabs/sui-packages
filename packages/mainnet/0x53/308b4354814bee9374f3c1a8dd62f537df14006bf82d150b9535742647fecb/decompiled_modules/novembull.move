module 0x53308b4354814bee9374f3c1a8dd62f537df14006bf82d150b9535742647fecb::novembull {
    struct NOVEMBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVEMBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVEMBULL>(arg0, 9, b"NOVEMBULL", b"Novembull ", b"Bullish month", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifhicjzdkx6vclrmmzfgsa2begdvi5gutqgby2m2bryxg3yhqrm4i")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVEMBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVEMBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

