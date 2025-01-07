module 0x6557a96f0b57e2778091af60db012988e82f71238b94e88ee293874bc73fb72a::move_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        faucet_coin: 0x2::balance::Balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>,
        my_coin: 0x2::balance::Balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>,
    }

    public entry fun infuse(arg0: &mut 0x2::coin::TreasuryCap<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>, arg1: &mut 0x2::coin::TreasuryCap<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::mint(arg1, arg2, arg3, arg4);
        0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::mint(arg0, arg2, arg3, arg4);
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
        let v1 = v0 * 1000 / 2000;
        assert!(v0 >= arg2, 0);
        let v2 = 0x2::coin::into_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(arg1);
        assert!(0x2::balance::value<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&arg0.my_coin) >= v1, 1);
        if (v0 > arg2) {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut v2, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(v2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&arg1);
        let v1 = v0 * 2000 / 1000;
        assert!(v0 >= arg2, 0);
        let v2 = 0x2::coin::into_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(arg1);
        assert!(0x2::balance::value<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&arg0.faucet_coin) >= v1, 1);
        if (v0 > arg2) {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut v2, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(v2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::my_coin::MY_COIN>(&mut arg0.my_coin, v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

