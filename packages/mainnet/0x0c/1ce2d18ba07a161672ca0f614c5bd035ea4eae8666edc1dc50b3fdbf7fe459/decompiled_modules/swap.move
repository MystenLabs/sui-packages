module 0xc1ce2d18ba07a161672ca0f614c5bd035ea4eae8666edc1dc50b3fdbf7fe459::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>,
        coin_b: 0x2::balance::Balance<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>,
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>, arg2: 0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&arg1) > 0 && 0x2::coin::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg2) > 0, 1);
        0x2::balance::join<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(arg1));
        0x2::balance::join<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(),
            coin_b : 0x2::balance::zero<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_A_to_B(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_B_to_A(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>>(0x2::coin::take<0x51b2d5f14320716b52dbce753a3d6ec0a1dcc6a53f11529351b73ce2afaf159d::my_coin::MY_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

