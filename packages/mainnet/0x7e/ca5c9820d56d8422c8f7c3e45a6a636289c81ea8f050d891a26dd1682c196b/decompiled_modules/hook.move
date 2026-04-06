module 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::hook {
    struct HookWitness has drop {
        dummy_field: bool,
    }

    struct HookConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        total_arb_profit: u64,
        total_keeper_paid: u64,
        total_swaps_routed: u64,
    }

    struct ArbProfit has copy, drop {
        pool_id: 0x2::object::ID,
        keeper: address,
        treasury: address,
        gross_profit: u64,
        keeper_cut: u64,
        treasury_cut: u64,
    }

    public fun create_hook_config(arg0: &mut 0x2::tx_context::TxContext) : HookConfig {
        HookConfig{
            id                 : 0x2::object::new(arg0),
            treasury           : 0x2::tx_context::sender(arg0),
            total_arb_profit   : 0,
            total_keeper_paid  : 0,
            total_swaps_routed : 0,
        }
    }

    public fun hook_stats(arg0: &HookConfig) : (u64, u64, u64) {
        (arg0.total_arb_profit, arg0.total_keeper_paid, arg0.total_swaps_routed)
    }

    public fun init_hook(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<HookConfig>(create_hook_config(arg0));
    }

    public fun settle_arb_profit<T0>(arg0: &mut HookConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 10);
        let v1 = v0 * 5000 / 10000;
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1), arg3), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), arg0.treasury);
        arg0.total_arb_profit = arg0.total_arb_profit + v0;
        arg0.total_keeper_paid = arg0.total_keeper_paid + v1;
        let v4 = ArbProfit{
            pool_id      : 0x2::object::id<HookConfig>(arg0),
            keeper       : v3,
            treasury     : arg0.treasury,
            gross_profit : v0,
            keeper_cut   : v1,
            treasury_cut : v0 - v1,
        };
        0x2::event::emit<ArbProfit>(v4);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::Pool<T0, T1>, arg1: &mut HookConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg1.total_swaps_routed = arg1.total_swaps_routed + 1;
        let v0 = HookWitness{dummy_field: false};
        0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::swap_a_to_b<T0, T1, HookWitness>(arg0, v0, arg2, arg3, arg4)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::Pool<T0, T1>, arg1: &mut HookConfig, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg1.total_swaps_routed = arg1.total_swaps_routed + 1;
        let v0 = HookWitness{dummy_field: false};
        0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool::swap_b_to_a<T0, T1, HookWitness>(arg0, v0, arg2, arg3, arg4)
    }

    public fun treasury(arg0: &HookConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

