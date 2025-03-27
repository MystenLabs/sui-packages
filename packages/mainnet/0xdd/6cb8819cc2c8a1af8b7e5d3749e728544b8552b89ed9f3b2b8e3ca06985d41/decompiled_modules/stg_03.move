module 0xdd6cb8819cc2c8a1af8b7e5d3749e728544b8552b89ed9f3b2b8e3ca06985d41::stg_03 {
    struct STG_03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_03>(arg0, 6, b"STG_03", b"STG03", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/ether/0x9e18d5bab2fa94a6a95f509ecb38f8f68322abd3.jpeg?1695390169867"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_03>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_03>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_03>>(v2);
    }

    // decompiled from Move bytecode v6
}

