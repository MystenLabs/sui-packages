module 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::cron_arb {
    struct ArbExecuted has copy, drop {
        keeper: address,
        direction: bool,
        input: u64,
        output: u64,
        keeper_reward: u64,
    }

    public fun arb_round_trip_a<T0, T1>(arg0: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::Pool<T0, T1>, arg1: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::hook::HookConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::join<T0>(&mut arg2, arg3);
        arg2
    }

    public fun settle_profit<T0>(arg0: &0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::hook::HookConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun swap_a_to_b_via_hook<T0, T1>(arg0: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::Pool<T0, T1>, arg1: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::hook::HookConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::swap_a_to_b_public<T0, T1>(arg0, arg2, arg3, arg4)
    }

    public fun swap_b_to_a_via_hook<T0, T1>(arg0: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::Pool<T0, T1>, arg1: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::hook::HookConfig, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::swap_b_to_a_public<T0, T1>(arg0, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

