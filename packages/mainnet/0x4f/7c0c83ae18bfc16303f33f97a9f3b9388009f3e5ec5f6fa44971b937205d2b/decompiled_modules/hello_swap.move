module 0x4f7c0c83ae18bfc16303f33f97a9f3b9388009f3e5ec5f6fa44971b937205d2b::hello_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    public entry fun creatBank<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<T0>(),
            coin_b : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    public entry fun deposit_a<T0>(arg0: &mut Bank<T0, 0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_b<T0>(arg0: &mut Bank<0x9ca86ce825f7edb7ecb299bc020402df76133eb516ef63963fc3094f21b73331::handsomepudding::HANDSOMEPUDDING, T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.coin_b, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, 0x2::coin::value<T0>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, 0x2::coin::value<T1>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_a<T0>(arg0: &AdminCap, arg1: &mut Bank<T0, 0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_b<T0>(arg0: &AdminCap, arg1: &mut Bank<0x9ca86ce825f7edb7ecb299bc020402df76133eb516ef63963fc3094f21b73331::handsomepudding::HANDSOMEPUDDING, T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

