module 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        sender: address,
        amount: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_bluefin_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9924 / 10000) as u64)
    }

    public fun calculate_bluefin_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9924 / 10000) as u64)
    }

    fun call_bluefin_gateway_swap_assets(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        let v1 = BluefinSwapExecuted{
            sender         : v0,
            amount         : arg6,
            min_amount_out : arg7,
            pool_id        : arg2,
            method         : b"gateway_swap_assets",
        };
        0x2::event::emit<BluefinSwapExecuted>(v1);
    }

    fun call_bluefin_multidex_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v1 = BluefinSwapExecuted{
            sender         : v0,
            amount         : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            min_amount_out : arg1,
            pool_id        : 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_sui_usdc_pool(),
            method         : b"multidex_swap",
        };
        0x2::event::emit<BluefinSwapExecuted>(v1);
    }

    public fun get_pool_config() : (address, address, u128) {
        (0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_sui_usdc_pool(), 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_global_config(), 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_sqrt_price_limit())
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"gateway_swap_assets", b"multidex_swap"]
    }

    public entry fun swap_sui_to_usdc_gateway(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3001);
        assert!(calculate_bluefin_output(v0) >= arg2, 3002);
        call_bluefin_gateway_swap_assets(arg0, 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_global_config(), 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_sui_usdc_pool(), arg1, true, true, v0, arg2, 0x9936823b96f820d0c85db8b5ea5f9cad75d90e286ed70b805eaa3a7d9757da45::constants::bluefin_sqrt_price_limit(), arg3);
    }

    public entry fun swap_sui_to_usdc_multidex(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3001);
        assert!(calculate_bluefin_output(v0) >= arg1, 3002);
        call_bluefin_multidex_swap(arg0, arg1, arg2, arg3);
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

