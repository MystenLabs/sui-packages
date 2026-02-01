module 0xf9cf79e7b2216d9eab6c08c73fa34248d602e49c1a510c5371e49d8e15b5d8a7::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 9, b"OCEAN", b"OCN", b"OCEAN is a fixed-supply community token on Sui with no minting, no burning, and no admin control.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://bafybeid2atd5mly4jjrmf6rpey4tj6pmrfegkgzvhyepq5hr6y76uatktu"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OCEAN>>(0x2::coin::mint<OCEAN>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OCEAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

