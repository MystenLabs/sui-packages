module 0xd7bc9642aea06d3a7133f4a5fce49dc3c2f6d9400e249754f774023684a30aab::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REAL>, arg1: 0x2::coin::Coin<REAL>) {
        0x2::coin::burn<REAL>(arg0, arg1);
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 2, b"REAL", b"REAL", b"REAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

