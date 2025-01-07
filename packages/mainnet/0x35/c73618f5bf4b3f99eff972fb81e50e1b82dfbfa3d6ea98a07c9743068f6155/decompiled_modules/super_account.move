module 0x35c73618f5bf4b3f99eff972fb81e50e1b82dfbfa3d6ea98a07c9743068f6155::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0x35c73618f5bf4b3f99eff972fb81e50e1b82dfbfa3d6ea98a07c9743068f6155::balance_bag::BalanceBag,
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        0x35c73618f5bf4b3f99eff972fb81e50e1b82dfbfa3d6ea98a07c9743068f6155::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x35c73618f5bf4b3f99eff972fb81e50e1b82dfbfa3d6ea98a07c9743068f6155::balance_bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x35c73618f5bf4b3f99eff972fb81e50e1b82dfbfa3d6ea98a07c9743068f6155::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

