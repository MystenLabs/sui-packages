module 0xf0913f7196a02b85fe1ffa504a61dcce1a5ccea9980f7884958b441235caeabb::CLAIM {
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

