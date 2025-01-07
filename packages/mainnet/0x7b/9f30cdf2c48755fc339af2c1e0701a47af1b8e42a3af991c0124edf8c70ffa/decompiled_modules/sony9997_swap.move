module 0x7b9f30cdf2c48755fc339af2c1e0701a47af1b8e42a3af991c0124edf8c70ffa::sony9997_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        rate: u64,
    }

    public entry fun add<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut Bank<T0, T1>) {
        0x2::balance::join<T0>(&mut arg2.coin_a, 0x2::coin::into_balance<T0>(arg0));
        0x2::balance::join<T1>(&mut arg2.coin_b, 0x2::coin::into_balance<T1>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id     : 0x2::object::new(arg4),
            coin_a : 0x2::balance::zero<T0>(),
            coin_b : 0x2::balance::zero<T1>(),
            rate   : arg3,
        };
        0x2::balance::join<T0>(&mut v0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut v0.coin_b, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    public fun set_rate<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rate = arg2;
    }

    public entry fun swap_a_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Bank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.coin_a, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.coin_b, 0x2::coin::value<T0>(&arg0) * arg1.rate, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut Bank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg1.coin_b, 0x2::coin::into_balance<T1>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coin_a, 0x2::coin::value<T1>(&arg0) / arg1.rate, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coin_a, 0x2::balance::value<T0>(&arg1.coin_a), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.coin_b, 0x2::balance::value<T1>(&arg1.coin_b), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

