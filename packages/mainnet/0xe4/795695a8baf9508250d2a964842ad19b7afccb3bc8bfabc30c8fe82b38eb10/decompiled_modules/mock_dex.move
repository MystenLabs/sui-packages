module 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex {
    struct MOCK_DEX has drop {
        dummy_field: bool,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mock_dex_balance: 0x2::balance::Balance<MOCK_DEX>,
        rate_sui_to_MOCK_DEX: u64,
    }

    fun init(arg0: MOCK_DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_DEX>(arg0, 6, b"USDC", b"Mock USDC", b"Mock USDC for SuiSyndicate", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCK_DEX>>(v1);
        let v3 = Pool{
            id                   : 0x2::object::new(arg1),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            mock_dex_balance     : 0x2::balance::zero<MOCK_DEX>(),
            rate_sui_to_MOCK_DEX : 2000000,
        };
        0x2::balance::join<MOCK_DEX>(&mut v3.mock_dex_balance, 0x2::coin::into_balance<MOCK_DEX>(0x2::coin::mint<MOCK_DEX>(&mut v2, 100000000000, arg1)));
        0x2::transfer::public_share_object<Pool>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_DEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun swap_mock_dex_to_sui(arg0: &mut Pool, arg1: 0x2::coin::Coin<MOCK_DEX>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::balance::join<MOCK_DEX>(&mut arg0.mock_dex_balance, 0x2::coin::into_balance<MOCK_DEX>(arg1));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::value<MOCK_DEX>(&arg1) * 1000 / 2), arg2)
    }

    public fun swap_sui_to_MOCK_DEX(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOCK_DEX> {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::coin::from_balance<MOCK_DEX>(0x2::balance::split<MOCK_DEX>(&mut arg0.mock_dex_balance, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 2 / 1000), arg2)
    }

    // decompiled from Move bytecode v7
}

