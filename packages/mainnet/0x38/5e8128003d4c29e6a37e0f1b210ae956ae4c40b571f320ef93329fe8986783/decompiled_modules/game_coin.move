module 0x385e8128003d4c29e6a37e0f1b210ae956ae4c40b571f320ef93329fe8986783::game_coin {
    struct Game has store, key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>,
    }

    struct ADMIN has key {
        id: 0x2::object::UID,
    }

    public entry fun Deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>, arg2: u64) {
        assert!(0x2::coin::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1) >= arg2, 1);
        0x2::balance::join<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg0.amt, 0x2::balance::split<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(0x2::coin::balance_mut<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1), arg2));
    }

    public entry fun Withdraw(arg0: &mut ADMIN, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&arg1.amt) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>>(0x2::coin::take<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg1.amt, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun game(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>, arg2: u64, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1) >= arg2, 3);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 1) == 1 == arg3) {
            0x2::coin::join<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(arg1, 0x2::coin::take<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(&mut arg0.amt, arg2, arg5));
        } else {
            Deposit(arg0, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0x4518f1d464f260f71a122248737d52ffcab1ccfd52542d0e79e28a6fc22e09f1::yunfaucet::YUNFAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = ADMIN{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ADMIN>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

