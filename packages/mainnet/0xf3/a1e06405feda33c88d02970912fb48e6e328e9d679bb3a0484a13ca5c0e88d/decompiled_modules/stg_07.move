module 0xf3a1e06405feda33c88d02970912fb48e6e328e9d679bb3a0484a13ca5c0e88d::stg_07 {
    struct STG_07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_07>(arg0, 6, b"STG_07", b"STG07", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/ether/0x3ffeea07a27fab7ad1df5297fa75e77a43cb5790.png?1718197118310"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_07>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_07>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_07>>(v2);
    }

    // decompiled from Move bytecode v6
}

