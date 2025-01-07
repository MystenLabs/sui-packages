module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::mock_usdc {
    struct MOCK_USDC has drop {
        dummy_field: bool,
    }

    struct USDCGlobal has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<MOCK_USDC>,
    }

    public entry fun burn(arg0: &mut USDCGlobal, arg1: 0x2::coin::Coin<MOCK_USDC>) {
        0x2::balance::decrease_supply<MOCK_USDC>(&mut arg0.supply, 0x2::coin::into_balance<MOCK_USDC>(arg1));
    }

    fun init(arg0: MOCK_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_USDC>(arg0, 6, b"MOCK USDC TOKEN", b"MOCK-USDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_USDC>>(v1);
        let v2 = USDCGlobal{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<MOCK_USDC>(v0),
        };
        0x2::transfer::share_object<USDCGlobal>(v2);
    }

    public entry fun mint(arg0: &mut USDCGlobal, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_USDC>>(0x2::coin::from_balance<MOCK_USDC>(0x2::balance::increase_supply<MOCK_USDC>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

