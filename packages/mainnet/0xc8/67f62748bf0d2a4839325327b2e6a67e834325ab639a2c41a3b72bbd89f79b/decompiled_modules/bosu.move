module 0xc867f62748bf0d2a4839325327b2e6a67e834325ab639a2c41a3b72bbd89f79b::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: 0x2::coin::Coin<BOSU>) {
        0x2::coin::burn<BOSU>(arg0, arg1);
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 9, b"BOSU", b"Bosu Token", b"The ultimate meme token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOSU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

