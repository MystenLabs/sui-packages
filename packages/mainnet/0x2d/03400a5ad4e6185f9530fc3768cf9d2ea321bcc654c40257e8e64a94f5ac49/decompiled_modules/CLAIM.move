module 0x2d03400a5ad4e6185f9530fc3768cf9d2ea321bcc654c40257e8e64a94f5ac49::CLAIM {
    struct CLAIM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAIM>, arg1: 0x2::coin::Coin<CLAIM>) {
        0x2::coin::burn<CLAIM>(arg0, arg1);
    }

    fun init(arg0: CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAIM>(arg0, 9, b"CLAIM REWARD", b"Claim Reward", b"Claim Reward", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLAIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAIM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

