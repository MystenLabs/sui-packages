module 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_deepbook {
    struct DeepBookSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        deepbook_package: address,
        method: vector<u8>,
    }

    public fun calculate_deepbook_output(arg0: u64) : u64 {
        (((arg0 as u128) * 999 / 1000) as u64)
    }

    public fun calculate_deepbook_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 999 / 1000) as u64)
    }

    public fun get_deepbook_packages() : (address, address, address) {
        (@0xdee9, @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_deepbook_v2_package() : address {
        @0xdee9
    }

    public fun get_deepbook_v3_package() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"DeepBook", b"0.1% fee central limit order book DEX", 999)
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = DeepBookSwapExecuted{
            sender           : v0,
            amount_in        : 0x2::coin::value<T0>(&arg1),
            min_amount_out   : arg2,
            deepbook_package : arg0,
            method           : b"legacy_compatibility_swap_sui_usdc",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        abort 0
    }

    public entry fun swap_sui_to_usdc_real(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        assert!(calculate_deepbook_output(v0) >= arg1, 3402);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        let v2 = DeepBookSwapExecuted{
            sender           : v1,
            amount_in        : v0,
            min_amount_out   : arg1,
            deepbook_package : get_deepbook_v2_package(),
            method           : b"real_sui_usdc_swap",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
    }

    public entry fun swap_sui_to_usdc_v3(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        assert!(calculate_deepbook_output(v0) >= arg1, 3402);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        let v2 = DeepBookSwapExecuted{
            sender           : v1,
            amount_in        : v0,
            min_amount_out   : arg1,
            deepbook_package : get_deepbook_v3_package(),
            method           : b"v3_sui_usdc_swap",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = DeepBookSwapExecuted{
            sender           : v0,
            amount_in        : 0x2::coin::value<T0>(&arg1),
            min_amount_out   : arg2,
            deepbook_package : arg0,
            method           : b"legacy_compatibility_swap_usdc_sui",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        abort 0
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

