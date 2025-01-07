module 0xbce4d4ae01a013e40000a2e82fd158529e16c88f52416b0f8b0d2fb3cedba22e::my_game {
    struct Reward_pool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    public entry fun Deposit(arg0: &mut Reward_pool, arg1: &mut 0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>, arg2: u64) {
        assert!(0x2::coin::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.balance, 0x2::balance::split<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(0x2::coin::balance_mut<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1), arg2));
    }

    entry fun Withdraw(arg0: &mut Reward_pool, arg1: u64, arg2: &mut Owner, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&arg0.balance) >= arg1, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>>(0x2::coin::take<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.balance, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun game(arg0: &mut Reward_pool, arg1: &mut 0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>, arg2: u64, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1) >= arg2, 1000);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 1) == 1 == arg3) {
            0x2::coin::join<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1, 0x2::coin::take<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.balance, arg2, arg5));
        } else {
            Deposit(arg0, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward_pool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(),
        };
        0x2::transfer::share_object<Reward_pool>(v0);
        let v1 = Owner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Owner>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

