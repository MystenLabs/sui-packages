module 0xc6cd82698c14e62764b1b6c1ae424a0b9fc04d1be17109280dd4e5d9d4330852::suia {
    struct SUIA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIA>, arg1: 0x2::coin::Coin<SUIA>) {
        0x2::coin::burn<SUIA>(arg0, arg1);
    }

    fun init(arg0: SUIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIA>(arg0, 6, b"SUIA", b"SUIA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

