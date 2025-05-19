module 0x68f021f3dfaced66157ef2ab00fbd119884a623632716e22c4fe2a60842fca31::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: 0x2::object::ID,
        user_stakes: 0x2::table::Table<address, u64>,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        total_staked: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        remaining_stake: u64,
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
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_stakes, v1)) {
            0x2::table::remove<address, u64>(&mut arg0.user_stakes, v1);
            *0x2::table::borrow<address, u64>(&arg0.user_stakes, v1) + v0
        } else {
            v0
        };
        0x2::table::add<address, u64>(&mut arg0.user_stakes, v1, v2);
        let v3 = DepositEvent{
            user         : v1,
            amount       : v0,
            total_staked : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun get_total_staked(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_user_stake(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_stakes, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_stakes, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = StakingPool{
            id          : 0x2::object::new(arg0),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            admin       : 0x2::object::id<AdminCap>(&v0),
            user_stakes : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<StakingPool>(v1);
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.user_stakes, v0), 3);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_stakes, v0);
        assert!(v1 >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
        0x2::table::remove<address, u64>(&mut arg0.user_stakes, v0);
        let v2 = v1 - arg1;
        if (v2 > 0) {
            0x2::table::add<address, u64>(&mut arg0.user_stakes, v0, v2);
        };
        let v3 = WithdrawEvent{
            user            : v0,
            amount          : arg1,
            remaining_stake : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

