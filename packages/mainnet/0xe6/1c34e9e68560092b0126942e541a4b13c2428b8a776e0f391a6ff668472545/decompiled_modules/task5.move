module 0xe61c34e9e68560092b0126942e541a4b13c2428b8a776e0f391a6ff668472545::task5 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>,
        faucet_coin: 0x2::balance::Balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>>(0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(0x2::balance::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>>(0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::balance::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(),
            faucet_coin : 0x2::balance::zero<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>, arg3: u64, arg4: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&mut arg1.coin, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(arg4, arg5, arg6)));
        };
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2;
        assert!(0x2::balance::value<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&arg0.faucet_coin) >= v0, 9223372264488042495);
        0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&mut arg0.coin, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>>(0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::balance::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg0.faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 2;
        assert!(0x2::balance::value<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&arg0.coin) >= v0, 9223372311732682751);
        0x2::balance::join<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(0x2::coin::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::faucet_yj9957::FAUCET_YJ9957>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>>(0x2::coin::from_balance<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(0x2::balance::split<0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957::YJ9957>(&mut arg0.coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

