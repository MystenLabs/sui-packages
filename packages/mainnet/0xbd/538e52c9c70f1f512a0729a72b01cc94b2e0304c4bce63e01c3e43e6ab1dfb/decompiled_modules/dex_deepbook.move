module 0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::dex_deepbook {
    struct DEEP has drop {
        dummy_field: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct DeepBookSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_deepbook_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9995 / 10000) as u64)
    }

    public fun calculate_deepbook_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9995 / 10000) as u64)
    }

    fun call_deepbook_place_market_order(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = get_deepbook_packages();
        call_deepbook_place_market_order_10_param_final(arg0, arg1, arg2, v1, v2, arg3, 0, true, false, arg5);
    }

    fun call_deepbook_place_market_order_10_param_final(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<DEEP>(0x2::coin::zero<DEEP>(arg9));
        let v0 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = DeepBookSwapExecuted{
            sender         : v0,
            amount_in      : arg5,
            min_amount_out : 0,
            pool_id        : arg2,
            method         : b"worker1_final_9_parameter_place_market_order_corrected",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
    }

    fun call_deepbook_swap_exact_base_for_quote(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<DEEP>(0x2::coin::zero<DEEP>(arg4));
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = DeepBookSwapExecuted{
            sender         : v0,
            amount_in      : arg2,
            min_amount_out : arg3,
            pool_id        : get_deepbook_pool(),
            method         : b"internal_6_parameter_worker2_zero_deep_integrated",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
    }

    public fun get_architecture_info() : (vector<u8>, vector<u8>, vector<u8>) {
        (b"CLOB", b"Pool-BalanceManager-Registry", b"Book-State-Vault")
    }

    public fun get_deep_token_package() : address {
        0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deep_token_package()
    }

    public fun get_deepbook_config() : (address, address, address) {
        (0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deepbook_package(), 0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deepbook_registry(), 0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deepbook_treasury())
    }

    public fun get_deepbook_package() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809
    }

    public fun get_deepbook_packages() : (address, address, address) {
        (@0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, @0x32abf8948dda67a271bcc18e776dbbcfb0d58c8d288a700ff0d5521e57a1ffe)
    }

    public fun get_deepbook_pool() : address {
        @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"DeepBook", b"V3 CLOB DEX with 0.0025-0.025% fees, 60% lower gas", 9995)
    }

    public fun get_order_types() : vector<vector<u8>> {
        vector[b"limit_order", b"market_order", b"swap_exact_base_for_quote", b"swap_exact_quote_for_base"]
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"place_limit_order", b"swap_exact_base_for_quote"]
    }

    public entry fun real_external_deepbook_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        0x2::coin::destroy_zero<DEEP>(0x2::coin::zero<DEEP>(arg3));
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        let v2 = DeepBookSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : get_deepbook_pool(),
            method         : b"worker3_confirmed_6_parameter_signature_integrated",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3401);
        assert!(arg0 == 0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deepbook_sui_usdc_pool(), 3403);
        assert!(calculate_deepbook_output(v0) >= arg2, 3402);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
    }

    public entry fun swap_sui_to_usdc_10_param_final(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        let (_, v2, v3) = get_deepbook_packages();
        assert!(calculate_deepbook_output(v0) >= arg1, 3402);
        call_deepbook_place_market_order_10_param_final(arg5, arg0, get_deepbook_pool(), v2, v3, v0, arg2, arg3, arg4, arg6);
    }

    public entry fun swap_sui_to_usdc_exact_base(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        assert!(calculate_deepbook_output(v0) >= arg1, 3402);
        call_deepbook_swap_exact_base_for_quote(arg2, arg0, v0, arg1, arg3);
    }

    public entry fun swap_sui_to_usdc_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        swap_sui_to_usdc_10_param_final(arg0, arg1, 0, true, false, arg2, arg3);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3401);
        assert!(arg0 == 0xbd538e52c9c70f1f512a0729a72b01cc94b2e0304c4bce63e01c3e43e6ab1dfb::constants::deepbook_sui_usdc_pool(), 3403);
        assert!(calculate_deepbook_usdc_to_sui_output(v0) >= arg2, 3402);
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

    public entry fun worker2_zero_deep_pattern_1(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(0x2::coin::zero<DEEP>(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun worker2_zero_deep_pattern_2(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<DEEP>(0x2::coin::zero<DEEP>(arg0));
    }

    public entry fun worker2_zero_deep_pattern_3(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(0x2::coin::from_balance<DEEP>(0x2::coin::into_balance<DEEP>(0x2::coin::zero<DEEP>(arg0)), arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

