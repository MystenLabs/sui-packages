module 0x54312bd65ddad82d6def2e4e6fb78bc12f0b066b86377e7f982af6a7e44d558c::myswappool {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        my_faucet_coin: 0x2::balance::Balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>,
        my_coin: 0x2::balance::Balance<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.my_faucet_coin, v1);
        } else {
            0x2::balance::join<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.my_faucet_coin, 0x2::balance::split<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(0x2::coin::from_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&mut arg0.my_coin, v1);
        } else {
            0x2::balance::join<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&mut arg0.my_coin, 0x2::balance::split<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>>(0x2::coin::from_balance<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            my_faucet_coin : 0x2::balance::zero<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(),
            my_coin        : 0x2::balance::zero<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 10, 1000);
        let v0 = arg2 / 10;
        assert!(0x2::balance::value<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&arg0.my_coin) >= v0, 1001);
        deposit_faucet_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>>(0x2::coin::from_balance<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(0x2::balance::split<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&mut arg0.my_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 10;
        assert!(0x2::balance::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg0.my_faucet_coin) >= v0, 1001);
        deposit_my_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(0x2::coin::from_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(0x2::balance::split<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.my_faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&arg1.my_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>>(0x2::coin::from_balance<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(0x2::balance::split<0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin::COLLARALLOC_COIN>(&mut arg1.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg1.my_faucet_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(0x2::coin::from_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(0x2::balance::split<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg1.my_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

