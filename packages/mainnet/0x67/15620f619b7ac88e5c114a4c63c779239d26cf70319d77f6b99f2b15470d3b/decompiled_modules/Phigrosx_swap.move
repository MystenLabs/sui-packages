module 0x6715620f619b7ac88e5c114a4c63c779239d26cf70319d77f6b99f2b15470d3b::Phigrosx_swap {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        phigrosx_coin: 0x2::balance::Balance<T0>,
        phigrosx_faucet_coin: 0x2::balance::Balance<T1>,
        owner: address,
    }

    public entry fun addCoins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 1);
        0x2::coin::put<T0>(&mut arg0.phigrosx_coin, 0x2::coin::split<T0>(&mut arg1, arg3, arg5));
        0x2::coin::put<T1>(&mut arg0.phigrosx_faucet_coin, 0x2::coin::split<T1>(&mut arg2, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg5));
    }

    public entry fun createPool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id                   : 0x2::object::new(arg0),
            phigrosx_coin        : 0x2::balance::zero<T0>(),
            phigrosx_faucet_coin : 0x2::balance::zero<T1>(),
            owner                : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
    }

    public entry fun swap_PhigrosX_Faucet_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.phigrosx_coin, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.phigrosx_faucet_coin, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_PhigrosX_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T1>(&mut arg0.phigrosx_faucet_coin, 0x2::coin::split<T1>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.phigrosx_coin, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

