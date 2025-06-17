module 0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(calculate_kriya_output(v0) >= arg2, 3302);
        let v2 = KriyaSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"atomic_arbitrage_compatible",
        };
        0x2::event::emit<KriyaSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
        0x2::coin::zero<T1>(arg4)
    }

    public fun calculate_kriya_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9975 / 10000) as u64)
    }

    public fun calculate_kriya_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9975 / 10000) as u64)
    }

    public fun get_package() : address {
        0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::constants::kriya_package()
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

