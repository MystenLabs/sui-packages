module 0x5038ba2e24f5b42a1692d46c21621eab19d29bdb476148c0104d06838bdce848::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUSK>, arg1: 0x2::coin::Coin<TUSK>) {
        0x2::coin::burn<TUSK>(arg0, arg1);
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 9, b"MTUSK", b"My Tusk Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUSK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUSK>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<TUSK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TUSK>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

