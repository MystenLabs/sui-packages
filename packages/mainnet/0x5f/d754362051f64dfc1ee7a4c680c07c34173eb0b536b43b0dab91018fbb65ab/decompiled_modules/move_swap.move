module 0x5fd754362051f64dfc1ee7a4c680c07c34173eb0b536b43b0dab91018fbb65ab::move_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        faucet_coin: 0x2::balance::Balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>,
        my_coin: 0x2::balance::Balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id          : 0x2::object::new(arg0),
            faucet_coin : 0x2::balance::zero<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(),
            my_coin     : 0x2::balance::zero<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, v0 * 1000 / 2000), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, v0 * 2000 / 1000), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

