module 0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet {
    struct MY_TOKEN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TOKEN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN_FAUCET>(arg0, 6, b"OVO", b"dyingforgefaucet Coin", b"My_faucet_Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_TOKEN_FAUCET>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN_FAUCET>>(0x2::coin::mint<MY_TOKEN_FAUCET>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

