module 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::emergency_fund {
    struct EMERGENCY_FUND has drop {
        dummy_field: bool,
    }

    struct MaintenanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendingPool has key {
        id: 0x2::object::UID,
        susdb_balance: 0x2::balance::Balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>,
        buck_reserve: 0x2::balance::Balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_buck_supply: 0x2::coin::TreasuryCap<EMERGENCY_FUND>,
        maintenance_balance: 0x2::balance::Balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>,
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
        deadline: u64,
    }

    struct BorrowEvent has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        ujrah: u64,
    }

    public fun borrow(arg0: &mut LendingPool, arg1: &mut 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SavingPool, arg2: &mut UserVault, arg3: &0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::Bottle, arg4: u64, arg5: u64, arg6: &mut 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::credit_score::CreditScore, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK> {
        assert!(arg2.owner == 0x2::tx_context::sender(arg8), 2);
        if (0x2::balance::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&arg0.buck_reserve) < arg4) {
            0x2::balance::join<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_reserve, 0x2::coin::into_balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::unstake(arg1, 0x2::coin::from_balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(0x2::balance::split<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(&mut arg0.susdb_balance, arg4 - 0x2::balance::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&arg0.buck_reserve)), arg8), arg8)));
        };
        let v0 = arg4 * 1000 / 10000;
        arg2.principal_debt = arg2.principal_debt + arg4;
        arg2.fee_debt = arg2.fee_debt + v0;
        arg2.deadline = 0x2::clock::timestamp_ms(arg7) + arg5 * 2592000000;
        let v1 = BorrowEvent{
            vault_id : 0x2::object::id<UserVault>(arg2),
            borrower : arg2.owner,
            amount   : arg4,
            ujrah    : v0,
        };
        0x2::event::emit<BorrowEvent>(v1);
        0x2::coin::take<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_reserve, arg4, arg8)
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : UserVault {
        UserVault{
            id                 : 0x2::object::new(arg0),
            owner              : 0x2::tx_context::sender(arg0),
            collateral_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            principal_debt     : 0,
            fee_debt           : 0,
            deadline           : 0,
        }
    }

    public fun deposit_collateral(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        arg0.total_sui_locked = arg0.total_sui_locked + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collateral_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun init(arg0: EMERGENCY_FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMERGENCY_FUND>(arg0, 9, b"lpBUCK", b"BEFS LP", b"Liquidity Provider Token for BEFS (Staked sUSDB)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMERGENCY_FUND>>(v1);
        let v2 = LendingPool{
            id                    : 0x2::object::new(arg1),
            susdb_balance         : 0x2::balance::zero<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(),
            buck_reserve          : 0x2::balance::zero<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(),
            sui_reserve           : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_buck_supply        : v0,
            maintenance_balance   : 0x2::balance::zero<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(),
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

    public fun provide_liquidity(arg0: &mut LendingPool, arg1: &mut 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SavingPool, arg2: 0x2::coin::Coin<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EMERGENCY_FUND> {
        let v0 = 0x2::coin::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply);
        let v2 = if (v1 == 0) {
            v0
        } else {
            v0 * v1 / (0x2::balance::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(&arg0.susdb_balance) + 0x2::balance::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&arg0.buck_reserve))
        };
        0x2::balance::join<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(&mut arg0.susdb_balance, 0x2::coin::into_balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::stake(arg1, arg2, arg3)));
        0x2::coin::mint<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, v2, arg3)
    }

    public fun remove_liquidity(arg0: &mut LendingPool, arg1: &mut 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SavingPool, arg2: 0x2::coin::Coin<EMERGENCY_FUND>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK> {
        0x2::coin::burn<EMERGENCY_FUND>(&mut arg0.lp_buck_supply, arg2);
        0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::unstake(arg1, 0x2::coin::from_balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(0x2::balance::split<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(&mut arg0.susdb_balance, 0x2::coin::value<EMERGENCY_FUND>(&arg2) * 0x2::balance::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::SUSDB>(&arg0.susdb_balance) / 0x2::coin::total_supply<EMERGENCY_FUND>(&arg0.lp_buck_supply)), arg3), arg3)
    }

    public fun repay(arg0: &mut LendingPool, arg1: &mut UserVault, arg2: 0x2::coin::Coin<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>, arg3: &mut 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::credit_score::CreditScore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&arg2);
        0x2::balance::join<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(&mut arg0.buck_reserve, 0x2::coin::into_balance<0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock::BUCKET_MOCK>(arg2));
        if (arg1.fee_debt > 0) {
            let v1 = if (v0 >= arg1.fee_debt) {
                arg1.fee_debt
            } else {
                v0
            };
            arg1.fee_debt = arg1.fee_debt - v1;
        };
        if (arg1.principal_debt > 0) {
            let v2 = if (v0 >= arg1.principal_debt) {
                arg1.principal_debt
            } else {
                v0
            };
            arg1.principal_debt = arg1.principal_debt - v2;
            if (arg1.principal_debt == 0 && arg1.fee_debt == 0) {
                0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::credit_score::update_credit_score(arg3, 0, v0, arg4);
            };
        };
    }

    // decompiled from Move bytecode v6
}

