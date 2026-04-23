module 0xd77ea937a804c4f17fa219ca95009fb8a4c695369a6e2a968b93dd64b9348929::primary {
    struct PRIMARY has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY> {
        0x2::coin::mint<PRIMARY>(arg0, arg1, arg2)
    }

    public entry fun create_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY>>(0x2::coin::mint<PRIMARY>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: 0x2::coin::Coin<PRIMARY>) {
        0x2::coin::burn<PRIMARY>(arg0, arg1);
    }

    fun init(arg0: PRIMARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

