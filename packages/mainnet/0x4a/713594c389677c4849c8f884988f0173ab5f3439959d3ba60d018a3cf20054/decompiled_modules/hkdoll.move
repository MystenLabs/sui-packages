module 0x4a713594c389677c4849c8f884988f0173ab5f3439959d3ba60d018a3cf20054::hkdoll {
    struct HKDOLL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HKDOLL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HKDOLL>>(0x2::coin::mint<HKDOLL>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<HKDOLL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDOLL>>(arg0, arg1);
    }

    fun init(arg0: HKDOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKDOLL>(arg0, 8, b"Hong Kong Doll", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKDOLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDOLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

