module 0x83fda91f48bc431a5a7ae88d9a34b0cc9026eda044fd727230bb43d8ae1a63a1::SUIAIRDROP {
    struct SUIAIRDROP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIAIRDROP>, arg1: 0x2::coin::Coin<SUIAIRDROP>) {
        0x2::coin::burn<SUIAIRDROP>(arg0, arg1);
    }

    fun init(arg0: SUIAIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAIRDROP>(arg0, 2, b"SUIAIRDROP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAIRDROP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAIRDROP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAIRDROP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIAIRDROP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

