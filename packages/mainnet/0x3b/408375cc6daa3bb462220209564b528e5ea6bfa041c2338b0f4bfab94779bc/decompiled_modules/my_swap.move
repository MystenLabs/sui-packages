module 0x3b408375cc6daa3bb462220209564b528e5ea6bfa041c2338b0f4bfab94779bc::my_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        wang000919_faucet_coin: 0x2::balance::Balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>,
        wang000919_coin: 0x2::balance::Balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&mut arg0.wang000919_faucet_coin, v1);
        } else {
            0x2::balance::join<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&mut arg0.wang000919_faucet_coin, 0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&mut arg0.wang000919_coin, v1);
        } else {
            0x2::balance::join<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&mut arg0.wang000919_coin, 0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                     : 0x2::object::new(arg0),
            wang000919_faucet_coin : 0x2::balance::zero<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(),
            wang000919_coin        : 0x2::balance::zero<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 1000 / 2000;
        assert!(0x2::balance::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&arg0.wang000919_coin) >= v0, 1001);
        deposit_faucet_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&mut arg0.wang000919_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2000 / 1000;
        assert!(0x2::balance::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&arg0.wang000919_faucet_coin) >= v0, 1001);
        deposit_my_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&mut arg0.wang000919_faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&arg1.wang000919_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_coin::WANG000919_COIN>(&mut arg1.wang000919_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&arg1.wang000919_faucet_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>>(0x2::coin::from_balance<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(0x2::balance::split<0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin::WANG000919_FAUCET_COIN>(&mut arg1.wang000919_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

