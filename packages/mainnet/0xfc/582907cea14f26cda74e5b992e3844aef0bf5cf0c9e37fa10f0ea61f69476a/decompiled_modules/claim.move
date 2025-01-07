module 0xfc582907cea14f26cda74e5b992e3844aef0bf5cf0c9e37fa10f0ea61f69476a::claim {
    struct DepositEvent has copy, drop {
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        amount: u64,
        claimer: address,
    }

    struct AdminWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SetupCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardsPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        leaderboard: 0x2::table::Table<address, u64>,
        required_funds: u64,
    }

    public fun claim(arg0: &mut RewardsPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<address, u64>(&arg0.leaderboard, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.leaderboard, 0x2::tx_context::sender(arg1));
        arg0.required_funds = arg0.required_funds - v0;
        let v1 = ClaimEvent{
            amount  : v0,
            claimer : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1)
    }

    public fun admin_withdraw_funds(arg0: &AdminCap, arg1: &mut RewardsPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        let v1 = AdminWithdrawEvent{amount: v0};
        0x2::event::emit<AdminWithdrawEvent>(v1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2)
    }

    public fun deposit(arg0: &mut RewardsPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RewardsPool{
            id             : 0x2::object::new(arg0),
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            leaderboard    : 0x2::table::new<address, u64>(arg0),
            required_funds : 0,
        };
        0x2::transfer::share_object<RewardsPool>(v2);
    }

    public fun leaderboard(arg0: &RewardsPool) : &0x2::table::Table<address, u64> {
        &arg0.leaderboard
    }

    public fun setup_leaderboard_and_deposit(arg0: &mut RewardsPool, arg1: vector<address>, arg2: vector<u64>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v0);
            v0 = v0 + 1;
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v3 = DepositEvent{amount: v2};
        0x2::event::emit<DepositEvent>(v3);
        assert!(v1 == v2, 3);
        deposit(arg0, arg3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.required_funds = arg0.required_funds + v4;
            0x2::table::add<address, u64>(&mut arg0.leaderboard, 0x1::vector::pop_back<address>(&mut arg1), v4);
        };
    }

    public fun user_rewards(arg0: &RewardsPool, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.leaderboard, arg1)
    }

    // decompiled from Move bytecode v6
}

