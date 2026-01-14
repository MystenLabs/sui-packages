module 0xf5fbfce7adcb864f6dfc36891134a5e5ca6c0095cd3e78c7586d3fcec8b437c1::mock_link_token {
    struct MOCK_LINK_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_LINK_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_LINK_TOKEN>>(0x2::coin::mint<MOCK_LINK_TOKEN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MOCK_LINK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_LINK_TOKEN>(arg0, 9, b"MOCK_LINK_TOKEN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_LINK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_LINK_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MOCK_LINK_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_LINK_TOKEN>>(0x2::coin::mint<MOCK_LINK_TOKEN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

