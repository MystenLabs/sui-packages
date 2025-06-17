module 0x5f8f754a37a9298d0a1fb8cd049fef2a9dd0a75e37e58afa84dba971196f228c::dex_flowx {
    struct FlowXSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        container: address,
        method: vector<u8>,
    }

    public fun calculate_flowx_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_flowx_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_flowx_factory_swap(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        let v1 = FlowXSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            container      : arg1,
            method         : b"factory_swap",
        };
        0x2::event::emit<FlowXSwapExecuted>(v1);
    }

    fun call_flowx_pair_swap(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = FlowXSwapExecuted{
            sender         : v0,
            amount_in      : arg2,
            min_amount_out : arg3,
            container      : get_flowx_container(),
            method         : b"pair_swap_exact_x_for_y",
        };
        0x2::event::emit<FlowXSwapExecuted>(v1);
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"FlowX Finance", b"0.30% fee AMM DEX with Factory/Container pattern", 9970)
    }

    public fun get_flowx_container() : address {
        0x5f8f754a37a9298d0a1fb8cd049fef2a9dd0a75e37e58afa84dba971196f228c::constants::flowx_container()
    }

    public fun get_flowx_package() : address {
        0x5f8f754a37a9298d0a1fb8cd049fef2a9dd0a75e37e58afa84dba971196f228c::constants::flowx_package()
    }

    public fun get_flowx_packages() : (address, address) {
        (0x5f8f754a37a9298d0a1fb8cd049fef2a9dd0a75e37e58afa84dba971196f228c::constants::flowx_package(), 0x5f8f754a37a9298d0a1fb8cd049fef2a9dd0a75e37e58afa84dba971196f228c::constants::flowx_container())
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"factory_swap", b"pair_swap_exact_x_for_y"]
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = FlowXSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            container      : get_flowx_container(),
            method         : b"legacy_compatibility_swap",
        };
        0x2::event::emit<FlowXSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg4)
    }

    public entry fun swap_sui_to_usdc_factory(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3701);
        assert!(calculate_flowx_output(v0) >= arg1, 3702);
        call_flowx_factory_swap(arg2, get_flowx_container(), arg0, v0, arg1, arg3);
    }

    public entry fun swap_sui_to_usdc_pair(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3701);
        assert!(calculate_flowx_output(v0) >= arg1, 3702);
        call_flowx_pair_swap(arg2, arg0, v0, arg1, arg3);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
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

