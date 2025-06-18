module 0xeed490c9ff4c669608610878d7e3eb72e00480eb08e025879927150237c1d86d::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_turbos_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_turbos_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Turbos", b"0.30% fee concentrated liquidity DEX", 9970)
    }

    public fun get_pool_config() : address {
        0xeed490c9ff4c669608610878d7e3eb72e00480eb08e025879927150237c1d86d::constants::turbos_sui_usdc_pool()
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"swap_sui_to_usdc", b"swap_usdc_to_sui", b"swap_entry"]
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_packages() : (address, address) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0xeed490c9ff4c669608610878d7e3eb72e00480eb08e025879927150237c1d86d::constants::turbos_sui_usdc_pool())
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3201);
        assert!(arg0 != @0x0, 3203);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(calculate_turbos_output(v0) >= arg2, 3202);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"swap_sui_to_usdc",
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
        0x2::coin::zero<T1>(arg5)
    }

    public entry fun swap_sui_to_usdc_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3201);
        assert!(calculate_turbos_output(v0) >= arg1, 3202);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : get_pool_config(),
            method         : b"swap_entry",
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3201);
        assert!(arg0 != @0x0, 3203);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(calculate_turbos_usdc_to_sui_output(v0) >= arg2, 3202);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"swap_usdc_to_sui",
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
        0x2::coin::zero<T1>(arg5)
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

