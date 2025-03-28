module 0x67bb6564ac7ebfb3a995789ae231b2414bd9dc433605e7e634936cb5a136c76d::stg_04 {
    struct STG_04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_04, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_04>(arg0, 6, b"STG_04", b"STG04", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/ether/0xca530408c3e552b020a2300debc7bd18820fb42f.png?1707628363039"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_04>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_04>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_04>>(v2);
    }

    // decompiled from Move bytecode v6
}

