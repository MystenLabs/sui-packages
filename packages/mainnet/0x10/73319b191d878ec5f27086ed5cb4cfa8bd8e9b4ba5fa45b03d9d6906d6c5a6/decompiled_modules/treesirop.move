module 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop {
    struct TREESIROP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TREESIROP>, arg1: 0x2::coin::Coin<TREESIROP>) {
        0x2::coin::burn<TREESIROP>(arg0, arg1);
    }

    fun init(arg0: TREESIROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREESIROP>(arg0, 2, b"TREESIROP", b"MY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREESIROP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREESIROP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TREESIROP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TREESIROP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

