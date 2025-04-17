module 0xfc221b4d56fa815c8543846ecdba5b6d14ee5e68d13b0f1a94a505bb8dc379ef::stg09 {
    struct STG09 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG09, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG09>(arg0, 7, b"STG09", b"STG_09", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/solana/FnpNhThpxJdMNHRZXVRsw7bHgbApoLcoyf1bT8NQu2eL.jpg?1744815675869"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG09>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG09>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG09>>(v2);
    }

    // decompiled from Move bytecode v6
}

