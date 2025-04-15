module 0x633f6f336e0cee40726215a6f04069e0f83e38784498c78e9defd4f46a88dbd4::stg_07 {
    struct STG_07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_07>(arg0, 6, b"STG_07", b"STG07", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/bsc/0xf86ef0abe36c7aa4066408479acf37decdb739ec.jpg?1744648350155"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_07>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_07>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_07>>(v2);
    }

    // decompiled from Move bytecode v6
}

