module 0xd6e7e5ffa825b46a19912aa89da07c5a06c5efa4b253a4eeb7419af4ce5e3af2::stg_06 {
    struct STG_06 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_06, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_06>(arg0, 6, b"STG_06", b"STG06", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/solana/E9D7aX81j1h1eTgXQn7rXKSwLnRXNQbgHXBuCFD2dRfz.gif?1743974102386"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_06>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_06>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_06>>(v2);
    }

    // decompiled from Move bytecode v6
}

