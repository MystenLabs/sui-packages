module 0x70071999007b74942a03cc615266cdb7f320212d5b91b4ff2003c0455fdd4723::myswap {
    struct BankDryan07<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        x: u64,
        y: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun a_to_b<T0, T1>(arg0: &mut BankDryan07<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, 0x2::coin::value<T0>(&arg1) * arg0.x / arg0.y), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun add_bank<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BankDryan07<T0, T1>{
            id     : 0x2::object::new(arg3),
            coin_a : 0x2::balance::zero<T0>(),
            coin_b : 0x2::balance::zero<T1>(),
            x      : arg1,
            y      : arg2,
        };
        0x2::transfer::share_object<BankDryan07<T0, T1>>(v0);
    }

    public fun add_coin_a<T0, T1>(arg0: &mut BankDryan07<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun add_coin_b<T0, T1>(arg0: &mut BankDryan07<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun b_to_a<T0, T1>(arg0: &mut BankDryan07<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, 0x2::coin::value<T1>(&arg1) * arg0.y / arg0.x), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_a<T0, T1>(arg0: &AdminCap, arg1: &mut BankDryan07<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun remove_b<T0, T1>(arg0: &AdminCap, arg1: &mut BankDryan07<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

