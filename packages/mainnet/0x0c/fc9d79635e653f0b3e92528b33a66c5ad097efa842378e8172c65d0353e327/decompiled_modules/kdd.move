module 0xcfc9d79635e653f0b3e92528b33a66c5ad097efa842378e8172c65d0353e327::kdd {
    struct KDD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<KDD>, arg1: 0x2::coin::Coin<KDD>) {
        0x2::coin::burn<KDD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KDD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KDD>>(0x2::coin::mint<KDD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDD>(arg0, 9, b"KDD", b"KOOL", b"KOOL token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

