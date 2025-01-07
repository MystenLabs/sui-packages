module 0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::BalanceBag,
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::contains<T0>(v0) == false) {
            0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::init_balance<T0>(v0);
        };
        0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x511367364ad849971786d2d23dcb95bceeeee16c8564369562fdb044f909639f::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

