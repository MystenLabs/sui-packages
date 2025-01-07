module 0xf85b9ecd6a1891e905f9554a8d2572b86497c81379b02bdb31c16d2799502ce4::my_game {
    struct Game has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amt: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun add(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.amt, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"fengfengxiong123"),
            amt  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    entry fun play(arg0: bool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Game, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) < 0x2::balance::value<0x2::sui::SUI>(&arg2.amt) / 10, 17);
        if (arg0 == 0x2::random::generate_bool(&mut v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.amt, 0x2::coin::value<0x2::sui::SUI>(&arg1)), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.amt, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
    }

    public entry fun remove(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.amt, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

