module 0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::BalanceBag,
    }

    public entry fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::contains<T0>(v0) == false) {
            0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::init_balance<T0>(v0);
        };
        0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    public entry fun withdraw_entry<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

