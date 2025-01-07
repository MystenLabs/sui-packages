module 0xe4eb4b839fc2befc771566e48ea866f0dd590e5f1693212c5787ae2816d19f00::myswap {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        llc_coin: 0x2::balance::Balance<T0>,
        llc_faucet_coin: 0x2::balance::Balance<T1>,
        owner: address,
    }

    public entry fun addLiquid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 1);
        0x2::coin::put<T0>(&mut arg0.llc_coin, 0x2::coin::split<T0>(&mut arg1, arg3, arg5));
        0x2::coin::put<T1>(&mut arg0.llc_faucet_coin, 0x2::coin::split<T1>(&mut arg2, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg5));
    }

    public entry fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id              : 0x2::object::new(arg0),
            llc_coin        : 0x2::balance::zero<T0>(),
            llc_faucet_coin : 0x2::balance::zero<T1>(),
            owner           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
    }

    public entry fun swap_llc_to_llfc<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.llc_coin, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.llc_faucet_coin, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_llfc_to_llc<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T1>(&mut arg0.llc_faucet_coin, 0x2::coin::split<T1>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.llc_coin, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

