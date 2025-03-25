module 0x8521af7f80382965251b85030fdab2772fb09fbe691dc67f96b10b012ae5dfe8::task4 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut GamePool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>>(0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::balance::withdraw_all<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg1.amount), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GamePool{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(),
        };
        0x2::transfer::share_object<GamePool>(v1);
    }

    public entry fun play(arg0: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>, arg1: u64, arg2: &mut GamePool, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 5000000000, 10);
        assert!(arg1 <= 0x2::balance::value<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&arg2.amount), 11);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg3) {
            0x2::coin::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(arg0, 0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::balance::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg2.amount, arg1), arg5));
        } else {
            0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg2.amount, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(arg0, arg1, arg5)));
        };
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>, arg2: u64, arg3: &mut GamePool, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg3.amount, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(arg1, arg2, arg4)));
    }

    // decompiled from Move bytecode v6
}

