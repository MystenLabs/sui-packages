module 0x63bb6aa08c7816540852d92126f70ad5fee9270ec65953b58df0f8f8b1eff985::move_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        faucet_coin: 0x2::balance::Balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>,
        my_coin: 0x2::balance::Balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>,
    }

    public entry fun deposit__faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.faucet_coin, v1);
        };
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg0.my_coin, 0x2::balance::split<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>>(0x2::coin::from_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg0.my_coin, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id          : 0x2::object::new(arg0),
            faucet_coin : 0x2::balance::zero<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(),
            my_coin     : 0x2::balance::zero<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&arg1);
        let v2 = arg2 * 1000 / 2000;
        assert!(v1 >= arg2, 0);
        let v3 = 0x2::coin::into_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(arg1);
        assert!(0x2::balance::value<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&arg0.my_coin) >= v2, 1);
        if (v1 > arg2) {
            0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut v3, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(v3, arg3), v0);
        } else {
            0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.faucet_coin, v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>>(0x2::coin::from_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(0x2::balance::split<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg0.my_coin, v2), arg3), v0);
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&arg1);
        let v2 = arg2 * 2000 / 1000;
        assert!(v1 >= arg2, 0);
        let v3 = 0x2::coin::into_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(arg1);
        assert!(0x2::balance::value<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&arg0.faucet_coin) >= v2, 1);
        if (v1 > arg2) {
            0x2::balance::join<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg0.my_coin, 0x2::balance::split<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut v3, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>>(0x2::coin::from_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(v3, arg3), v0);
        } else {
            0x2::balance::join<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg0.my_coin, v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.faucet_coin, v2), arg3), v0);
    }

    public entry fun withdraw_zzf222_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>>(0x2::coin::from_balance<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(0x2::balance::split<0x5a3a556c1b4cb0d9e20595fc0819bef617de4a6b16c258e58f49e7d1c27d4cf9::m2887_coin::M2887_COIN>(&mut arg1.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_zzf222_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

