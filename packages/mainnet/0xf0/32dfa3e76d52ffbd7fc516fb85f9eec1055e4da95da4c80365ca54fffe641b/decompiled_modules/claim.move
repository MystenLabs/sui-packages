module 0xf032dfa3e76d52ffbd7fc516fb85f9eec1055e4da95da4c80365ca54fffe641b::claim {
    struct AdminWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        leaderboard: 0x2::table::Table<address, u64>,
        required_funds: u64,
    }

    public fun claim<T0>(arg0: &mut RewardsPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<address, u64>(&arg0.leaderboard, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.leaderboard, 0x2::tx_context::sender(arg1));
        arg0.required_funds = arg0.required_funds - v0;
        0x2::coin::take<T0>(&mut arg0.balance, v0, arg1)
    }

    public fun admin_withdraw_funds<T0>(arg0: &AdminCap, arg1: &mut RewardsPool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        let v1 = AdminWithdrawEvent{amount: v0};
        0x2::event::emit<AdminWithdrawEvent>(v1);
        0x2::coin::take<T0>(&mut arg1.balance, v0, arg2)
    }

    public fun create_rewards_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardsPool<T0>{
            id             : 0x2::object::new(arg0),
            balance        : 0x2::balance::zero<T0>(),
            leaderboard    : 0x2::table::new<address, u64>(arg0),
            required_funds : 0,
        };
        0x2::transfer::share_object<RewardsPool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun leaderboard<T0>(arg0: &RewardsPool<T0>) : &0x2::table::Table<address, u64> {
        &arg0.leaderboard
    }

    public fun setup_leaderboard_and_deposit<T0>(arg0: &mut RewardsPool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v0);
            v0 = v0 + 1;
        };
        assert!(v1 == 0x2::coin::value<T0>(&arg3), 3);
        deposit<T0>(arg0, arg3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.required_funds = arg0.required_funds + v2;
            let v3 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, u64>(&arg0.leaderboard, v3)) {
                0x2::table::add<address, u64>(&mut arg0.leaderboard, v3, 0x2::table::remove<address, u64>(&mut arg0.leaderboard, v3) + v2);
                continue
            };
            0x2::table::add<address, u64>(&mut arg0.leaderboard, v3, v2);
        };
    }

    public fun user_rewards<T0>(arg0: &RewardsPool<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.leaderboard, arg1)
    }

    // decompiled from Move bytecode v6
}

