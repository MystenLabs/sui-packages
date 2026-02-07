module 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::emergency_fund {
    struct EMERGENCY_FUND has drop {
        dummy_field: bool,
    }

    struct MaintenanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendingPool has key {
        id: 0x2::object::UID,
        buck_balance: 0x2::balance::Balance<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>,
        lp_buck_supply: 0x2::coin::TreasuryCap<EMERGENCY_FUND>,
        maintenance_balance: 0x2::balance::Balance<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>,
        waqf_reserve: 0x2::balance::Balance<EMERGENCY_FUND>,
        service_fee_bps: u64,
        min_collateral_ratio: u64,
        split_maintenance_bps: u64,
        split_waqf_bps: u64,
    }

    struct UserVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        collateral_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        principal_debt: u64,
        fee_debt: u64,
    }

    struct BorrowEvent has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        ujrah: u64,
    }

    struct RepayEvent has copy, drop {
        vault_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        remaining_principal: u64,
    }

    public fun borrow(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: &0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::CDP, arg3: u64, arg4: &mut 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::credit_score::CreditScore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg6), 2);
        assert!(0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::check_cdp_owner(arg2, 0x2::tx_context::sender(arg6)), 2);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance) >= arg3, 1);
        let v0 = 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::credit_score::get_fee_discount(0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::credit_score::get_tier(arg4));
        let v1 = if (arg0.service_fee_bps > v0) {
            arg0.service_fee_bps - v0
        } else {
            0
        };
        let v2 = arg3 * v1 / 10000;
        arg1.principal_debt = arg1.principal_debt + arg3;
        arg1.fee_debt = arg1.fee_debt + v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.collateral_balance) * 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::price_feed_mock::get_predicted_low_price() / 1000000000 >= (arg1.principal_debt + arg1.fee_debt) * arg0.min_collateral_ratio / 100, 4);
        let v3 = BorrowEvent{
            vault_id : 0x2::object::id<UserVault>(arg1),
            borrower : arg1.owner,
            amount   : arg3,
            ujrah    : v2,
        };
        0x2::event::emit<BorrowEvent>(v3);
        0x2::coin::take<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, arg3, arg6)
    }

    public fun claim_maintenance(arg0: &MaintenanceCap, arg1: &mut LendingPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK> {
        let v0 = 0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg1.maintenance_balance);
        assert!(v0 > 0, 3);
        0x2::coin::from_balance<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(0x2::balance::split<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg1.maintenance_balance, v0), arg2)
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : UserVault {
        UserVault{
            id                 : 0x2::object::new(arg0),
            owner              : 0x2::tx_context::sender(arg0),
            collateral_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            principal_debt     : 0,
            fee_debt           : 0,
        }
    }

    public fun deposit_collateral(arg0: &mut UserVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collateral_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_waqf_shares(arg0: &LendingPool) : u64 {
        0x2::balance::value<EMERGENCY_FUND>(&arg0.waqf_reserve)
    }

    fun init(arg0: EMERGENCY_FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMERGENCY_FUND>(arg0, 9, b"lpBUCK", b"BUCK Emergency LP", b"Liquidity Provider Token for BUCK Emergency Fund", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMERGENCY_FUND>>(v1);
        let v2 = LendingPool{
            id                    : 0x2::object::new(arg1),
            buck_balance          : 0x2::balance::zero<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(),
            lp_buck_supply        : v0,
            maintenance_balance   : 0x2::balance::zero<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(),
            waqf_reserve          : 0x2::balance::zero<EMERGENCY_FUND>(),
            service_fee_bps       : 1000,
            min_collateral_ratio  : 150,
            split_maintenance_bps : 2000,
            split_waqf_bps        : 4000,
        };
        0x2::transfer::share_object<LendingPool>(v2);
        let v3 = MaintenanceCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MaintenanceCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun provide_liquidity(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EMERGENCY_FUND> {
        let v0 = 0x2::coin::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply);
        let v2 = if (v1 == 0) {
            v0
        } else {
            v0 * v1 / 0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance)
        };
        0x2::balance::join<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, 0x2::coin::into_balance<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(arg1));
        0x2::coin::mint<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, v2, arg2)
    }

    public fun remove_liquidity(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<EMERGENCY_FUND>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK> {
        let v0 = 0x2::coin::value<EMERGENCY_FUND>(&arg1);
        assert!(v0 > 0, 3);
        0x2::coin::burn<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, arg1);
        0x2::coin::take<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, v0 * 0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance) / 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply), arg2)
    }

    public fun repay(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: 0x2::coin::Coin<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>, arg3: &mut 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::credit_score::CreditScore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::into_balance<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(arg2);
        let v2 = v0;
        if (arg1.fee_debt > 0) {
            let v3 = if (v0 >= arg1.fee_debt) {
                arg1.fee_debt
            } else {
                v0
            };
            0x2::balance::join<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.maintenance_balance, 0x2::balance::split<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut v1, v3 * arg0.split_maintenance_bps / 10000));
            let v4 = v3 * arg0.split_waqf_bps / 10000;
            if (v4 > 0) {
                let v5 = 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply);
                let v6 = if (v5 == 0) {
                    v4
                } else {
                    v4 * v5 / 0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance)
                };
                0x2::balance::join<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, 0x2::balance::split<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut v1, v4));
                0x2::balance::join<EMERGENCY_FUND>(&mut arg0.waqf_reserve, 0x2::coin::into_balance<EMERGENCY_FUND>(0x2::coin::mint<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, v6, arg5)));
            };
            arg1.fee_debt = arg1.fee_debt - v3;
            v2 = v0 - v3;
        };
        if (v2 > 0 && arg1.principal_debt > 0) {
            let v7 = if (v2 >= arg1.principal_debt) {
                arg1.principal_debt
            } else {
                v2
            };
            arg1.principal_debt = arg1.principal_debt - v7;
            if (arg1.principal_debt == 0 && arg1.fee_debt == 0) {
                0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::credit_score::update_credit_score(arg3, 0, v0, arg4);
            };
        };
        if (0x2::balance::value<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&v1) > 0) {
            0x2::balance::join<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, v1);
        } else {
            0x2::balance::destroy_zero<0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::bucket_mock::BUCKET_MOCK>(v1);
        };
        let v8 = RepayEvent{
            vault_id            : 0x2::object::id<UserVault>(arg1),
            payer               : 0x2::tx_context::sender(arg5),
            amount              : v0,
            remaining_principal : arg1.principal_debt,
        };
        0x2::event::emit<RepayEvent>(v8);
    }

    public fun withdraw_collateral(arg0: &mut UserVault, arg1: u64, arg2: &LendingPool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.collateral_balance) >= arg1, 4);
        let v0 = arg0.principal_debt + arg0.fee_debt;
        if (v0 > 0) {
            assert!((0x2::balance::value<0x2::sui::SUI>(&arg0.collateral_balance) - arg1) * 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::price_feed_mock::get_predicted_low_price() / 1000000000 >= v0 * arg2.min_collateral_ratio / 100, 4);
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collateral_balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

