module 0x4a5313fa76e8abad0f812467de9bd7188abefba666fe9e262a2ded0863d60ea8::mock_navx_token {
    struct MOCK_NAVX_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_NAVX_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_NAVX_TOKEN>>(0x2::coin::mint<MOCK_NAVX_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_NAVX_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_NAVX_TOKEN>(arg0, 9, b"NAVX", b"NAVX", b"Mock NAVX token for veNAVX mainnet deployment", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_NAVX_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_NAVX_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_metadata(arg0: &0x2::coin::CoinMetadata<MOCK_NAVX_TOKEN>) {
    }

    // decompiled from Move bytecode v6
}

