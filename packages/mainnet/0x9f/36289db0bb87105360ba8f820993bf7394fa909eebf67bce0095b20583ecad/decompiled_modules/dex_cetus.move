module 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        sender: address,
        amount: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_cetus_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_cetus_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_cetus_pool_script_swap_b2a(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        let v1 = CetusSwapExecuted{
            sender         : v0,
            amount         : arg5,
            min_amount_out : arg6,
            pool_id        : arg2,
            method         : b"pool_script_swap_b2a",
        };
        0x2::event::emit<CetusSwapExecuted>(v1);
    }

    fun call_cetus_verified_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v1 = CetusSwapExecuted{
            sender         : v0,
            amount         : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            min_amount_out : arg1,
            pool_id        : @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3,
            method         : b"verified_swap",
        };
        0x2::event::emit<CetusSwapExecuted>(v1);
    }

    public fun get_cetus_packages() : (address, address) {
        (@0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3, @0xbb3ad29d65cefa2d9a9381f4170b33cb9fb267f6119443524dc7f85a1ad3a0d6)
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Cetus", b"0.30% fee concentrated liquidity DEX", 9970)
    }

    public fun get_pool_config() : (address, address, u128) {
        (@0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, 4295048016)
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"pool_script_swap_b2a", b"verified_swap"]
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = CetusSwapExecuted{
            sender         : v0,
            amount         : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"legacy_compatibility_swap",
        };
        0x2::event::emit<CetusSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg5)
    }

    public entry fun swap_sui_to_usdc_cetus(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3101);
        assert!(calculate_cetus_output(v0) >= arg2, 3102);
        call_cetus_pool_script_swap_b2a(arg0, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3, arg1, true, v0, arg2, 4295048016, arg3);
    }

    public entry fun swap_sui_to_usdc_verified(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3101);
        assert!(calculate_cetus_output(v0) >= arg1, 3102);
        call_cetus_verified_swap(arg0, arg1, arg2, arg3);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
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

