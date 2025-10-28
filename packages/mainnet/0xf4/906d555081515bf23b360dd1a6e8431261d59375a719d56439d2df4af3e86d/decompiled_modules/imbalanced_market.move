module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::imbalanced_market {
    struct ImbalancedMarket<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    struct ImbalancedMarketCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_balance1<T0, T1>(arg0: &mut ImbalancedMarket<T0, T1>, arg1: &ImbalancedMarketCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun add_balance2<T0, T1>(arg0: &mut ImbalancedMarket<T0, T1>, arg1: &ImbalancedMarketCap, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ImbalancedMarketCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ImbalancedMarketCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_market<T0, T1>(arg0: &ImbalancedMarketCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ImbalancedMarket<T0, T1>{
            id        : 0x2::object::new(arg1),
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<ImbalancedMarket<T0, T1>>(v0);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut ImbalancedMarket<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1) * 10000 / 10000;
        if (0x2::balance::value<T1>(&arg0.balance_b) < v0) {
            abort 0
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v0), arg2)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut ImbalancedMarket<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1) * 10300 / 10000;
        if (0x2::balance::value<T0>(&arg0.balance_a) < v0) {
            abort 1
        };
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

