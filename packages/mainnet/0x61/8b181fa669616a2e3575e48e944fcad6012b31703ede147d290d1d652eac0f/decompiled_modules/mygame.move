module 0x618b181fa669616a2e3575e48e944fcad6012b31703ede147d290d1d652eac0f::mygame {
    struct Game_dryan07<phantom T0> has key {
        id: 0x2::object::UID,
        poolBal: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun addPool<T0>(arg0: &mut Game_dryan07<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.poolBal, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun creat_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game_dryan07<T0>{
            id      : 0x2::object::new(arg0),
            poolBal : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Game_dryan07<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: &mut Game_dryan07<T0>, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(0x2::balance::value<T0>(&arg0.poolBal) >= v0 * 10, 2449);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.poolBal, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<T0>(&mut arg0.poolBal, 0x2::coin::into_balance<T0>(arg3));
        };
    }

    public entry fun removePool<T0>(arg0: &AdminCap, arg1: &mut Game_dryan07<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.poolBal, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

