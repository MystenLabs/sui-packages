module 0x350d83954bfa16c26fac7679a99e1d3f3e5f3c064e17fcec015391e2bc2a8e03::marshmallow {
    struct SavingsGoal<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        target_amount: u64,
        unlock_timestamp: u64,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_goal<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingsGoal<T0>{
            id               : 0x2::object::new(arg3),
            name             : arg0,
            target_amount    : arg1,
            unlock_timestamp : arg2,
            owner            : 0x2::tx_context::sender(arg3),
            balance          : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<SavingsGoal<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit<T0>(arg0: &mut SavingsGoal<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_goal_balance<T0>(arg0: &SavingsGoal<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_goal_name<T0>(arg0: &SavingsGoal<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_goal_target_amount<T0>(arg0: &SavingsGoal<T0>) : u64 {
        arg0.target_amount
    }

    public fun get_goal_unlock_timestamp<T0>(arg0: &SavingsGoal<T0>) : u64 {
        arg0.unlock_timestamp
    }

    public entry fun withdraw<T0>(arg0: SavingsGoal<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let SavingsGoal {
            id               : v0,
            name             : _,
            target_amount    : v2,
            unlock_timestamp : v3,
            owner            : v4,
            balance          : v5,
        } = arg0;
        let v6 = v5;
        assert!(0x2::tx_context::sender(arg2) == v4, 0);
        let v7 = 0x2::balance::value<T0>(&v6);
        assert!(v7 >= v2 || 0x2::clock::timestamp_ms(arg1) >= v3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v7), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::destroy_zero<T0>(v6);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

