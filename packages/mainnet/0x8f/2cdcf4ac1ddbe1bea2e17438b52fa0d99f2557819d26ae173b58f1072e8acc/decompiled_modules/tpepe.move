module 0x8f2cdcf4ac1ddbe1bea2e17438b52fa0d99f2557819d26ae173b58f1072e8acc::tpepe {
    struct TPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TPEPE>, arg1: 0x2::coin::Coin<TPEPE>) {
        0x2::coin::burn<TPEPE>(arg0, arg1);
    }

    fun init(arg0: TPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEPE>(arg0, 6, b"TPEPE", b"Turbo PEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

