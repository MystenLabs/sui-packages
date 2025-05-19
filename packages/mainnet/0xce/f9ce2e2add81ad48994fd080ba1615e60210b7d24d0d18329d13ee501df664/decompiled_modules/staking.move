module 0xcef9ce2e2add81ad48994fd080ba1615e60210b7d24d0d18329d13ee501df664::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: 0x2::object::ID,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        owner: address,
        staked_amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    public entry fun admin_withdraw_all(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg2), v0);
        let v2 = AdminWithdrawEvent{
            admin  : v0,
            amount : v1,
        };
        0x2::event::emit<AdminWithdrawEvent>(v2);
    }

    public entry fun deposit(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        find_or_create_user_stake(arg0, v1, arg2);
        let v2 = DepositEvent{
            user   : v1,
            amount : v0,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    fun find_or_create_user_stake(arg0: &StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = UserStake{
            id            : 0x2::object::new(arg2),
            owner         : arg1,
            staked_amount : 0,
            pool_id       : 0x2::object::id<StakingPool>(arg0),
        };
        0x2::transfer::transfer<UserStake>(v0, arg1);
        0x2::object::id<UserStake>(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = StakingPool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin   : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<StakingPool>(v1);
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
        let v1 = WithdrawEvent{
            user   : v0,
            amount : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

