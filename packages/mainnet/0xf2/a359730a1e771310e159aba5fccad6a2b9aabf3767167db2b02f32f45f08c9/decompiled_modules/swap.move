module 0xf2a359730a1e771310e159aba5fccad6a2b9aabf3767167db2b02f32f45f08c9::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        cmdscz_coin: 0x2::balance::Balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>,
        cmdscz_faucet_coin: 0x2::balance::Balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>,
    }

    public entry fun deposit_cmdscz_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.cmdscz_coin, 0x2::balance::split<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>>(0x2::coin::from_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.cmdscz_coin, v1);
        };
    }

    public entry fun deposit_cmdscz_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.cmdscz_faucet_coin, 0x2::balance::split<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>>(0x2::coin::from_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.cmdscz_faucet_coin, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                 : 0x2::object::new(arg0),
            cmdscz_coin        : 0x2::balance::zero<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(),
            cmdscz_faucet_coin : 0x2::balance::zero<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_cmdscz_coin_to_cmdscz_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg1);
        let v2 = arg2 * 2000 / 1000;
        assert!(v1 >= arg2, 0);
        let v3 = 0x2::coin::into_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(arg1);
        assert!(0x2::balance::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg0.cmdscz_faucet_coin) >= v2, 1);
        if (v1 > arg2) {
            0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.cmdscz_coin, 0x2::balance::split<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut v3, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>>(0x2::coin::from_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(v3, arg3), v0);
        } else {
            0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.cmdscz_coin, v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>>(0x2::coin::from_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(0x2::balance::split<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.cmdscz_faucet_coin, v2), arg3), v0);
    }

    public entry fun swap_cmdscz_faucet_coin_to_cmdscz_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg1);
        let v2 = arg2 * 1000 / 2000;
        assert!(v1 >= arg2, 0);
        let v3 = 0x2::coin::into_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(arg1);
        assert!(0x2::balance::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg0.cmdscz_coin) >= v2, 1);
        if (v1 > arg2) {
            0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.cmdscz_faucet_coin, 0x2::balance::split<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut v3, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>>(0x2::coin::from_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(v3, arg3), v0);
        } else {
            0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.cmdscz_faucet_coin, v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>>(0x2::coin::from_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(0x2::balance::split<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.cmdscz_coin, v2), arg3), v0);
    }

    public entry fun withdraw_cmdscz_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>>(0x2::coin::from_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(0x2::balance::split<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg1.cmdscz_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_cmdscz_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>>(0x2::coin::from_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(0x2::balance::split<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg1.cmdscz_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

