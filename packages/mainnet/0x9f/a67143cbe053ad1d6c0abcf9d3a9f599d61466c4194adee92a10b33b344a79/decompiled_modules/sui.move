module 0x9fa67143cbe053ad1d6c0abcf9d3a9f599d61466c4194adee92a10b33b344a79::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: 0x2::coin::Coin<SUI>) {
        0x2::coin::burn<SUI>(arg0, arg1);
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 7, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

