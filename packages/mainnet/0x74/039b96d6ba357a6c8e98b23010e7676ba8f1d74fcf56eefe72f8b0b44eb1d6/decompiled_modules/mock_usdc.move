module 0x74039b96d6ba357a6c8e98b23010e7676ba8f1d74fcf56eefe72f8b0b44eb1d6::mock_usdc {
    struct MOCK_USDC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_USDC>>(0x2::coin::mint<MOCK_USDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_USDC>(arg0, 6, b"USDC", b"Mock Circle USDC", b"Fake USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://strapi-dev.scand.app/uploads/usdc_03b37ed889.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_USDC>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MOCK_USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

