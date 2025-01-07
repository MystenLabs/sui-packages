module 0x90a4bd93dd5c071052b87c17f53a3bdbee1f97f7b1096941fec6e236b275b50e::titantrading {
    struct TITANTRADING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TITANTRADING>, arg1: 0x2::coin::Coin<TITANTRADING>) {
        0x2::coin::burn<TITANTRADING>(arg0, arg1);
    }

    fun init(arg0: TITANTRADING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANTRADING>(arg0, 2, b"Titan Trading Token", b"TES", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://titan-trading.storage.googleapis.com/images/27d1d8bbfd-256.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITANTRADING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANTRADING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TITANTRADING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TITANTRADING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

