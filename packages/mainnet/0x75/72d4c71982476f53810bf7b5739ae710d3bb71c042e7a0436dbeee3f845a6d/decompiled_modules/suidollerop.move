module 0x7572d4c71982476f53810bf7b5739ae710d3bb71c042e7a0436dbeee3f845a6d::suidollerop {
    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    public fun check_allowed(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
    }

    public fun create_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg0);
        let v0 = Treasury<T0>{
            id          : 0x2::object::new(arg0),
            balance     : 0x2::balance::zero<T0>(),
            fee_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_fee_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance)
    }

    public fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawFees<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_allowed(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_balance, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    // decompiled from Move bytecode v6
}

