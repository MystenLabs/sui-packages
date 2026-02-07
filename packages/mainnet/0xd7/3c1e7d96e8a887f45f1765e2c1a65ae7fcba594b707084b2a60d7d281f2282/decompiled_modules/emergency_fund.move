module 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::emergency_fund {
    struct EMERGENCY_FUND has drop {
        dummy_field: bool,
    }

    struct MaintenanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendingPool has key {
        id: 0x2::object::UID,
        buck_balance: 0x2::balance::Balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_buck_supply: 0x2::coin::TreasuryCap<EMERGENCY_FUND>,
        maintenance_balance: 0x2::balance::Balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>,
        waqf_reserve: 0x2::balance::Balance<EMERGENCY_FUND>,
        total_sui_locked: u64,
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
        start_time: u64,
        deadline: u64,
    }

    struct BorrowEvent has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        ujrah: u64,
        deadline: u64,
    }

    struct RepayEvent has copy, drop {
        vault_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        is_collateral_payment: bool,
    }

    public fun borrow(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: &0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::Bottle, arg3: u64, arg4: u64, arg5: &mut 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::CreditScore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg7), 2);
        assert!(0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::is_legit_bottle(arg2), 2);
        assert!(arg4 >= 1 && arg4 <= 24, 3);
        assert!(0x2::balance::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance) >= arg3, 1);
        let v0 = 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::get_fee_discount(0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::get_tier(arg5));
        let v1 = if (arg0.service_fee_bps > v0) {
            arg0.service_fee_bps - v0
        } else {
            0
        };
        let v2 = arg3 * v1 / 10000;
        arg1.principal_debt = arg1.principal_debt + arg3;
        arg1.fee_debt = arg1.fee_debt + v2;
        let v3 = 0x2::clock::timestamp_ms(arg6);
        arg1.start_time = v3;
        arg1.deadline = v3 + arg4 * 2592000000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.collateral_balance) * 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::price_feed_mock::get_predicted_low_price() / 1000000000 >= (arg1.principal_debt + arg1.fee_debt) * arg0.min_collateral_ratio / 100, 4);
        let v4 = BorrowEvent{
            vault_id : 0x2::object::id<UserVault>(arg1),
            borrower : arg1.owner,
            amount   : arg3,
            ujrah    : v2,
            deadline : arg1.deadline,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::take<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, arg3, arg7)
    }

    public fun claim_maintenance(arg0: &MaintenanceCap, arg1: &mut LendingPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK> {
        0x2::coin::from_balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(0x2::balance::split<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg1.maintenance_balance, 0x2::balance::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg1.maintenance_balance)), arg2)
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : UserVault {
        UserVault{
            id                 : 0x2::object::new(arg0),
            owner              : 0x2::tx_context::sender(arg0),
            collateral_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            principal_debt     : 0,
            fee_debt           : 0,
            start_time         : 0,
            deadline           : 0,
        }
    }

    public fun deposit_collateral(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        arg0.total_sui_locked = arg0.total_sui_locked + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collateral_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun execute_repayment_math(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: &mut 0x2::balance::Balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>, arg3: u64, arg4: &mut 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::CreditScore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext, arg7: bool) {
        let v0 = arg3;
        if (arg1.fee_debt > 0) {
            let v1 = if (arg3 >= arg1.fee_debt) {
                arg1.fee_debt
            } else {
                arg3
            };
            if (!arg7) {
                0x2::balance::join<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg0.maintenance_balance, 0x2::balance::split<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(arg2, v1 * arg0.split_maintenance_bps / 10000));
            };
            arg1.fee_debt = arg1.fee_debt - v1;
            v0 = arg3 - v1;
        };
        if (v0 > 0 && arg1.principal_debt > 0) {
            let v2 = if (v0 >= arg1.principal_debt) {
                arg1.principal_debt
            } else {
                v0
            };
            arg1.principal_debt = arg1.principal_debt - v2;
            if (arg1.principal_debt == 0 && arg1.fee_debt == 0) {
                0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::update_credit_score(arg4, 0, arg3, arg5);
            };
        };
        let v3 = RepayEvent{
            vault_id              : 0x2::object::id<UserVault>(arg1),
            payer                 : arg1.owner,
            amount                : arg3,
            is_collateral_payment : arg7,
        };
        0x2::event::emit<RepayEvent>(v3);
    }

    fun init(arg0: EMERGENCY_FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMERGENCY_FUND>(arg0, 9, b"lpBUCK", b"BUCK Emergency LP", b"Liquidity Provider Token for BUCK Emergency Fund", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMERGENCY_FUND>>(v1);
        let v2 = LendingPool{
            id                    : 0x2::object::new(arg1),
            buck_balance          : 0x2::balance::zero<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(),
            sui_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_buck_supply        : v0,
            maintenance_balance   : 0x2::balance::zero<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(),
            waqf_reserve          : 0x2::balance::zero<EMERGENCY_FUND>(),
            total_sui_locked      : 0,
            service_fee_bps       : 1000,
            min_collateral_ratio  : 150,
            split_maintenance_bps : 2000,
            split_waqf_bps        : 4000,
        };
        0x2::transfer::share_object<LendingPool>(v2);
        let v3 = MaintenanceCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MaintenanceCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun provide_liquidity(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EMERGENCY_FUND> {
        let v0 = 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply);
        let v1 = if (v0 == 0) {
            0x2::coin::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg1)
        } else {
            0x2::coin::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg1) * v0 / 0x2::balance::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance)
        };
        0x2::balance::join<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, 0x2::coin::into_balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(arg1));
        0x2::coin::mint<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, v1, arg2)
    }

    public fun remove_liquidity(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<EMERGENCY_FUND>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<EMERGENCY_FUND>(&arg1);
        let v1 = 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply);
        0x2::coin::burn<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, arg1);
        (0x2::coin::take<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, v0 * 0x2::balance::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg0.buck_balance) / v1, arg2), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0 * 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / v1, arg2))
    }

    public fun repay(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: 0x2::coin::Coin<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>, arg3: &mut 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::CreditScore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(arg2);
        let v1 = &mut v0;
        execute_repayment_math(arg0, arg1, v1, 0x2::coin::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&arg2), arg3, arg4, arg5, false);
        if (0x2::balance::value<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&v0) > 0) {
            0x2::balance::join<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_balance, v0);
        } else {
            0x2::balance::destroy_zero<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(v0);
        };
    }

    public fun repay_with_jaminan(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: u64, arg3: &mut 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::credit_score::CreditScore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.collateral_balance) >= arg2, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.collateral_balance, arg2));
        arg0.total_sui_locked = arg0.total_sui_locked - arg2;
        let v0 = 0x2::balance::zero<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>();
        let v1 = &mut v0;
        execute_repayment_math(arg0, arg1, v1, arg2 * 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::price_feed_mock::get_sui_price() / 1000000000, arg3, arg4, arg5, true);
        0x2::balance::destroy_zero<0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock::BUCKET_MOCK>(v0);
    }

    public fun withdraw_collateral(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.collateral_balance) >= arg2, 4);
        let v0 = arg1.principal_debt + arg1.fee_debt;
        if (v0 > 0) {
            assert!((0x2::balance::value<0x2::sui::SUI>(&arg1.collateral_balance) - arg2) * 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::price_feed_mock::get_predicted_low_price() / 1000000000 >= v0 * arg0.min_collateral_ratio / 100, 4);
        };
        arg0.total_sui_locked = arg0.total_sui_locked - arg2;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.collateral_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

