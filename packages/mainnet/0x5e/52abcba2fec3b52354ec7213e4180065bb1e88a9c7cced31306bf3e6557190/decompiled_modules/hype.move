module 0x5e52abcba2fec3b52354ec7213e4180065bb1e88a9c7cced31306bf3e6557190::hype {
    struct Counter<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        chop: 0x2::balance::Balance<T0>,
        value: u64,
        min_chop_amount: u64,
        min_sui_amount: u64,
    }

    public fun chop_balance<T0>(arg0: &Counter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.chop)
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter<T0>{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            chop            : 0x2::balance::zero<T0>(),
            value           : 0,
            min_chop_amount : 20000000000000,
            min_sui_amount  : 1000000000,
        };
        0x2::transfer::share_object<Counter<T0>>(v0);
    }

    public fun incrementCHOP<T0>(arg0: &mut Counter<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) >= arg0.min_chop_amount, 1);
        arg0.value = arg0.value + 1;
        0x2::balance::join<T0>(&mut arg0.chop, v0);
    }

    public fun incrementSUI<T0>(arg0: &mut Counter<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) >= arg0.min_sui_amount, 1);
        arg0.value = arg0.value + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0);
    }

    public fun set_min_chop_amount<T0>(arg0: &mut Counter<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.min_chop_amount = arg1;
    }

    public fun set_min_sui_amount<T0>(arg0: &mut Counter<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.min_sui_amount = arg1;
    }

    public fun set_owner<T0>(arg0: &mut Counter<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    public fun set_value<T0>(arg0: &mut Counter<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.value = arg1;
    }

    public fun sui_balance<T0>(arg0: &Counter<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun withdraw<T0>(arg0: &mut Counter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, sui_balance<T0>(arg0), arg1), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.chop, chop_balance<T0>(arg0), arg1), arg0.owner);
        arg0.value = 0;
    }

    // decompiled from Move bytecode v6
}

