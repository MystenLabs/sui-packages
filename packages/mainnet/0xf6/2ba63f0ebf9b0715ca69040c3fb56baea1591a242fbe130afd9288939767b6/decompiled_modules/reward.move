module 0xf62ba63f0ebf9b0715ca69040c3fb56baea1591a242fbe130afd9288939767b6::reward {
    struct REWARD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REWARD>, arg1: 0x2::coin::Coin<REWARD>) {
        0x2::coin::burn<REWARD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REWARD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REWARD>>(0x2::coin::mint<REWARD>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWARD>(arg0, 9, b"test REWARD", b"REWARD", b"Test REWARD token for Mmt Finance protocol.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REWARD>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

