module 0x4a46ba168f5cf75b93ebd33a1d397b9abfccded2150287c70ac35ca5a519d78b::MOBY {
    struct MOBY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOBY>, arg1: 0x2::coin::Coin<MOBY>) {
        0x2::coin::burn<MOBY>(arg0, arg1);
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 9, b"SUP", b"MOBY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOBY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOBY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

