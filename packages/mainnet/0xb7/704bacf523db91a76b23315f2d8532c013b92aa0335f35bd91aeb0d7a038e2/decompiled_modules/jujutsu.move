module 0xb7704bacf523db91a76b23315f2d8532c013b92aa0335f35bd91aeb0d7a038e2::jujutsu {
    struct JUJUTSU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JUJUTSU>, arg1: 0x2::coin::Coin<JUJUTSU>) {
        0x2::coin::burn<JUJUTSU>(arg0, arg1);
    }

    fun init(arg0: JUJUTSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJUTSU>(arg0, 9, b"JJK", b"Jujutsu", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUJUTSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJUTSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUJUTSU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUJUTSU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

