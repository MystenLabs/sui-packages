module 0x7e8567d28a9e9ac687f29123cdc22efd63e1c2351251ad1a99883598a6956321::mock_token_one {
    struct MOCK_TOKEN_ONE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_TOKEN_ONE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_TOKEN_ONE>>(0x2::coin::mint<MOCK_TOKEN_ONE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_TOKEN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_TOKEN_ONE>(arg0, 9, b"TOKEN1", b"TOKEN1", b"Mock TOKEN1 Token for Gas Testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_TOKEN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_TOKEN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_metadata(arg0: &0x2::coin::CoinMetadata<MOCK_TOKEN_ONE>) {
    }

    // decompiled from Move bytecode v6
}

