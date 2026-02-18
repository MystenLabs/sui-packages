module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::index_fund {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct SHARE has drop {
        dummy_field: bool,
    }

    struct FundVault has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_balance: 0x2::balance::Balance<USDC>,
        total_shares: u64,
        ratio_sui_per_usdc: u64,
    }

    struct FundTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SHARE>,
    }

    struct FundCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun create_fund_with_cap(arg0: 0x2::coin::TreasuryCap<SHARE>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FundVault{
            id                 : 0x2::object::new(arg1),
            sui_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance       : 0x2::balance::zero<USDC>(),
            total_shares       : 0,
            ratio_sui_per_usdc : 100,
        };
        let v1 = FundCreated{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<FundCreated>(v1);
        0x2::transfer::share_object<FundVault>(v0);
        let v2 = FundTreasury{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::share_object<FundTreasury>(v2);
    }

    public fun mint_shares(arg0: &mut FundVault, arg1: &mut FundTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<USDC>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SHARE> {
        let v0 = 0x2::coin::value<USDC>(&arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0 * arg0.ratio_sui_per_usdc, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<USDC>(arg3));
        arg0.total_shares = arg0.total_shares + v0;
        0x2::coin::mint<SHARE>(&mut arg1.cap, v0, arg4)
    }

    public fun redeem_shares(arg0: &mut FundVault, arg1: &mut FundTreasury, arg2: 0x2::coin::Coin<SHARE>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<USDC>) {
        let v0 = 0x2::coin::value<SHARE>(&arg2);
        assert!(arg0.total_shares >= v0, 1);
        0x2::coin::burn<SHARE>(&mut arg1.cap, arg2);
        arg0.total_shares = arg0.total_shares - v0;
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0 * arg0.ratio_sui_per_usdc), arg3), 0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg0.usdc_balance, v0), arg3))
    }

    // decompiled from Move bytecode v6
}

