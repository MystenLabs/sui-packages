module 0xdb5804b3ac41f8b1e9266cf2b70fade97114e24cd24886ad43a4ccd36fdae85b::fantasy_move_basketball {
    struct BasketThrowGame has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun deposit(arg0: &mut BasketThrowGame, arg1: 0x2::coin::Coin<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(&mut arg0.pool, 0x2::coin::into_balance<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BasketThrowGame{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(),
        };
        0x2::transfer::share_object<BasketThrowGame>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut BasketThrowGame, arg1: 0x2::coin::Coin<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(&arg1) != 1000000000, 0);
        deposit(arg0, arg1, arg3);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 99);
        let v2 = if (v1 <= 50) {
            500000000
        } else if (v1 <= 85) {
            1000000000
        } else {
            3000000000
        };
        let v3 = 0x2::tx_context::sender(arg3);
        withdraw(arg0, v2, v3, arg3);
    }

    public entry fun public_deposit(arg0: &mut BasketThrowGame, arg1: 0x2::coin::Coin<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit(arg0, arg1, arg2);
    }

    public entry fun public_withdraw(arg0: &AdminCap, arg1: &mut BasketThrowGame, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        withdraw(arg1, arg2, v0, arg3);
    }

    fun withdraw(arg0: &mut BasketThrowGame, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>>(0x2::coin::from_balance<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(0x2::balance::split<0x398797282df10e8b79f10cf4d2d8c1090c70be652b76e6efda5ed9cef6dd126c::fantasy_facuet_coin::FANTASY_FACUET_COIN>(&mut arg0.pool, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

