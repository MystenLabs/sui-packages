module 0x9e1701ec8d7942a79874a40d4d5c9d94c45ffd141c9cd2cff4f4fc3820329b61::fee_distribution {
    struct FeeState<phantom T0, phantom T1> has store {
        fees_x: 0x2::balance::Balance<T0>,
        fees_y: 0x2::balance::Balance<T1>,
        user_withdrawals_x: 0x2::table::Table<address, u64>,
        user_withdrawals_y: 0x2::table::Table<address, u64>,
        stakes_total: u64,
        fees_x_total: u64,
        fees_y_total: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeState<T0, T1> {
        FeeState<T0, T1>{
            fees_x             : 0x2::balance::zero<T0>(),
            fees_y             : 0x2::balance::zero<T1>(),
            user_withdrawals_x : 0x2::table::new<address, u64>(arg1),
            user_withdrawals_y : 0x2::table::new<address, u64>(arg1),
            stakes_total       : arg0,
            fees_x_total       : 0,
            fees_y_total       : 0,
        }
    }

    public(friend) fun add_fees<T0, T1>(arg0: &mut FeeState<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        arg0.fees_x_total = arg0.fees_x_total + 0x2::coin::value<T0>(&arg1);
        arg0.fees_y_total = arg0.fees_y_total + 0x2::coin::value<T1>(&arg2);
        0x2::balance::join<T0>(&mut arg0.fees_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.fees_y, 0x2::coin::into_balance<T1>(arg2));
    }

    fun get_max_withdraw(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256) * (arg2 as u256) * 1000000000000000 / (arg3 as u256);
        assert!(v1 <= v0 * 1000000000000000, 0x9e1701ec8d7942a79874a40d4d5c9d94c45ffd141c9cd2cff4f4fc3820329b61::errors::no_funds_to_withdraw());
        (((v1 - v0) / 1000000000000000) as u64)
    }

    fun get_withdraw_diff(arg0: u64, arg1: u256) : u64 {
        (((arg0 as u256) * arg1 / 1000000000000000) as u64)
    }

    public(friend) fun update_stake<T0, T1>(arg0: u64, arg1: u64, arg2: &mut FeeState<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = withdraw<T0, T1>(arg2, arg0, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = (arg1 as u256) * 1000000000000000 / (arg0 as u256);
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_withdrawals_x, v2);
        *v4 = *v4 - get_withdraw_diff(*v4, v3);
        let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_withdrawals_y, v2);
        *v5 = *v5 - get_withdraw_diff(*v5, v3);
        arg2.stakes_total = arg2.stakes_total - arg1;
        (v0, v1)
    }

    public fun withdraw<T0, T1>(arg0: &mut FeeState<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_withdrawals_x, v0);
        let v2 = get_max_withdraw(*v1, arg0.fees_x_total, arg1, arg0.stakes_total);
        *v1 = ((*v1 + v2) as u64);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_withdrawals_y, v0);
        let v4 = get_max_withdraw(*v3, arg0.fees_y_total, arg1, arg0.stakes_total);
        *v3 = ((*v3 + v4) as u64);
        (0x2::balance::split<T0>(&mut arg0.fees_x, v2), 0x2::balance::split<T1>(&mut arg0.fees_y, v4))
    }

    // decompiled from Move bytecode v6
}

