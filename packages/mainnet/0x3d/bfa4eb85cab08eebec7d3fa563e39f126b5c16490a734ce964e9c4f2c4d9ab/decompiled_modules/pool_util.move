module 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool_util {
    public fun single_collect_all_rewards<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::new_top_up_ticket<T1>(arg1);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::top_up<T0, T1>(arg0, arg1, &mut v0, arg3);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::collect_all_rewards<T0, T1>(arg1, arg2, v0)
    }

    public fun single_collect_all_rewards_and_transfer<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(single_collect_all_rewards<T0, T1>(arg0, arg1, arg2, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun single_deposit_shares<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) {
        let v0 = 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::new_top_up_ticket<T1>(arg1);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::top_up<T0, T1>(arg0, arg1, &mut v0, arg4);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::deposit_shares<T1>(arg1, arg2, arg3, v0);
    }

    public fun single_deposit_shares_coin<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock) {
        single_deposit_shares<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(arg3), arg4);
    }

    public fun single_deposit_shares_new<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1> {
        let v0 = 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::new_top_up_ticket<T1>(arg1);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::top_up<T0, T1>(arg0, arg1, &mut v0, arg3);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::deposit_shares_new<T1>(arg1, arg2, v0, arg4)
    }

    public fun single_deposit_shares_new_and_transfer<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = single_deposit_shares_new<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), arg3, arg4);
        0x2::transfer::public_transfer<0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun single_withdraw_shares<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: u64, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::new_top_up_ticket<T1>(arg1);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::top_up<T0, T1>(arg0, arg1, &mut v0, arg4);
        0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::withdraw_shares<T1>(arg1, arg2, arg3, v0)
    }

    public fun single_withdraw_shares_and_transfer<T0, T1>(arg0: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::farm::Farm<T0>, arg1: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Pool<T1>, arg2: &mut 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::pool::Stake<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(single_withdraw_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

