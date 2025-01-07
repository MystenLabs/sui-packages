module 0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::vault {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::BalanceBag,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::contains<T0>(v0) == false) {
            0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::init_balance<T0>(v0);
        };
        0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::new(arg0),
        };
        let v1 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw<T0>(arg0: &TreasuryCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd27696967920bec3975d137d66cfd1b5574ab1ca9afaaf080ca3763b2cfa1ad1::balance_bag::split<T0>(&mut arg1.balance_bag, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

