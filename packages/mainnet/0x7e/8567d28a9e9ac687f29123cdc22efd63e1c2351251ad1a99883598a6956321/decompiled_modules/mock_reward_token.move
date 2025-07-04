module 0x7e8567d28a9e9ac687f29123cdc22efd63e1c2351251ad1a99883598a6956321::mock_reward_token {
    struct MOCK_REWARD_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_REWARD_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_REWARD_TOKEN>>(0x2::coin::mint<MOCK_REWARD_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_REWARD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_REWARD_TOKEN>(arg0, 9, b"REWARD", b"REWARD", b"Mock REWARD Token for Gas Testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_REWARD_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_REWARD_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_metadata(arg0: &0x2::coin::CoinMetadata<MOCK_REWARD_TOKEN>) {
    }

    // decompiled from Move bytecode v6
}

