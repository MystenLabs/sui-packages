module 0xe5ea9e0fff276d6e3749058f3de672cc0cca5425e6dd8459cf92ad2fa35c2da6::chee_game_dice {
    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
    }

    public entry fun add_coin<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 0x2::coin::value<T0>(&arg1), 275);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(&mut v0, arg2));
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun create_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Game<T0>>(v0);
    }

    fun is_big_or_small(arg0: u8) : bool {
        arg0 >= 3
    }

    entry fun play<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 && arg4 <= 0x2::coin::value<T0>(&arg3), 273);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg4 * 10, 274);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (arg2 == is_big_or_small(0x2::random::generate_u8_in_range(&mut v0, 1, 6))) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg4), arg5), 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            let v1 = 0x2::coin::into_balance<T0>(arg3);
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(&mut v1, arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg5), 0x2::tx_context::sender(arg5));
        };
    }

    entry fun remove_coin<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 274);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

