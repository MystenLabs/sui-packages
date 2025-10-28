module 0xcacc04d9086e88bb362a0c9714a80f73f7793690747ba49a8b77785890b45a9e::NEO {
    struct NEO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: 0x2::coin::Coin<NEO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<NEO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEO>>(0x2::coin::mint<NEO>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<NEO>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEO>>(arg0);
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 9, b"NEO", b"NeoNeko", b"NeoNeko is the best Anime character on SUI. We will be hosting Anime Watch parties while we earn rewards and hold giveaways", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_69003df4c6d885.13000538.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

