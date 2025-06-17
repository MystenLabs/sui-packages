module 0x22f736f7860e40379b2034ae2b01a16f5ee2b6b40f08cf2326cd98043412d0d9::dex_kriya {
    public fun calculate_kriya_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9975 / 10000) as u64)
    }

    public fun calculate_kriya_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9975 / 10000) as u64)
    }

    public fun get_package() : address {
        0x22f736f7860e40379b2034ae2b01a16f5ee2b6b40f08cf2326cd98043412d0d9::constants::kriya_package()
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3301);
        assert!(calculate_kriya_output(v0) >= arg2, 3302);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3301);
        assert!(calculate_kriya_usdc_to_sui_output(v0) >= arg2, 3302);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

