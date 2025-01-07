module 0xbe075be548f3506e8a9ffdb380cf7bc3ed7f58103da5e379ce207ec3f7fdc353::fee_distribution {
    struct FeeState<phantom T0, phantom T1> has store {
        fees_meme: 0x2::balance::Balance<T1>,
        fees_s: 0x2::balance::Balance<T0>,
        user_withdrawals_x: 0x2::table::Table<address, u64>,
        user_withdrawals_y: 0x2::table::Table<address, u64>,
        stakes_total: u64,
        fees_meme_total: u64,
        fees_s_total: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeState<T0, T1> {
        FeeState<T0, T1>{
            fees_meme          : 0x2::balance::zero<T1>(),
            fees_s             : 0x2::balance::zero<T0>(),
            user_withdrawals_x : 0x2::table::new<address, u64>(arg1),
            user_withdrawals_y : 0x2::table::new<address, u64>(arg1),
            stakes_total       : arg0,
            fees_meme_total    : 0,
            fees_s_total       : 0,
        }
    }

    public(friend) fun add_fees<T0, T1>(arg0: &mut FeeState<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>) {
        arg0.fees_meme_total = arg0.fees_meme_total + 0x2::coin::value<T1>(&arg1);
        arg0.fees_s_total = arg0.fees_s_total + 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T1>(&mut arg0.fees_meme, 0x2::coin::into_balance<T1>(arg1));
        0x2::balance::join<T0>(&mut arg0.fees_s, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun get_fees_to_withdraw<T0, T1>(arg0: &FeeState<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_withdrawals_x, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_withdrawals_x, v0)
        } else {
            0
        };
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_withdrawals_y, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_withdrawals_y, v0)
        } else {
            0
        };
        (get_max_withdraw(v1, arg0.fees_meme_total, arg1, arg0.stakes_total), get_max_withdraw(v2, arg0.fees_s_total, arg1, arg0.stakes_total))
    }

    fun get_max_withdraw(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256) * (arg2 as u256) / (arg3 as u256);
        assert!(v1 >= v0, 0);
        ((v1 - v0) as u64)
    }

    fun get_withdraw_diff(arg0: u64, arg1: u256) : u64 {
        (((arg0 as u256) * arg1 / 1000000000000000) as u64)
    }

    public(friend) fun withdraw_fees<T0, T1>(arg0: &mut FeeState<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, u64>(&arg0.user_withdrawals_x, v0)) {
            0x2::table::add<address, u64>(&mut arg0.user_withdrawals_x, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_withdrawals_x, v0);
        let v2 = get_max_withdraw(*v1, arg0.fees_meme_total, arg1, arg0.stakes_total);
        *v1 = ((*v1 + v2) as u64);
        if (!0x2::table::contains<address, u64>(&arg0.user_withdrawals_y, v0)) {
            0x2::table::add<address, u64>(&mut arg0.user_withdrawals_y, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_withdrawals_y, v0);
        let v4 = get_max_withdraw(*v3, arg0.fees_s_total, arg1, arg0.stakes_total);
        *v3 = ((*v3 + v4) as u64);
        (0x2::balance::split<T1>(&mut arg0.fees_meme, v2), 0x2::balance::split<T0>(&mut arg0.fees_s, v4))
    }

    public(friend) fun withdraw_fees_and_update_stake<T0, T1>(arg0: u64, arg1: u64, arg2: &mut FeeState<T0, T1>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = withdraw_fees<T0, T1>(arg2, arg0, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = (arg1 as u256) * 1000000000000000 / (arg0 as u256);
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_withdrawals_x, v2);
        *v4 = *v4 - get_withdraw_diff(*v4, v3);
        let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_withdrawals_y, v2);
        *v5 = *v5 - get_withdraw_diff(*v5, v3);
        arg2.stakes_total = arg2.stakes_total - arg1;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

