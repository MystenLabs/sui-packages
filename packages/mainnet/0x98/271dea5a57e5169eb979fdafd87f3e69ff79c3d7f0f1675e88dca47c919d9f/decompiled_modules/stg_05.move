module 0x98271dea5a57e5169eb979fdafd87f3e69ff79c3d7f0f1675e88dca47c919d9f::stg_05 {
    struct STG_05 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_05, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_05>(arg0, 6, b"STG_05", b"STG05", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/solana/AEsHWNsasurhsjuErPoFxHwzJYBYMUj2zgNzTggcwTXB.jpg?1743060128918"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_05>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_05>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_05>>(v2);
    }

    // decompiled from Move bytecode v6
}

