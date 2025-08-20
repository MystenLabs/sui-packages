module 0x31d0f1f5b6244da31062539e9e27ac5993b760911737c5275f92261153aa8250::new_mock_navx_token {
    struct NEW_MOCK_NAVX_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_MOCK_NAVX_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_MOCK_NAVX_TOKEN>(arg0, 9, b"NEW_MOCK_NAVX", b"New Mock NAVX Token", b"New Mock NAVX Token for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW_MOCK_NAVX_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_MOCK_NAVX_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEW_MOCK_NAVX_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEW_MOCK_NAVX_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

