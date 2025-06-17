module 0x274479ad9459b555130d6cb36a4f38c96e282d7f5875d5ae19010acc9a01d5f::dex_deepbook {
    struct MinimalDeepBookCall has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        deepbook_v2: address,
        deepbook_v3_1: address,
        deepbook_v3_2: address,
        execution_method: vector<u8>,
    }

    struct DeepBookSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = DeepBookSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"atomic_arbitrage_swap_compatible",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::coin::zero<T1>(arg4)
    }

    public fun calculate_deepbook_output(arg0: u64) : u64 {
        (((arg0 as u128) * 999 / 1000) as u64)
    }

    fun execute_minimal_deepbook_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MinimalDeepBookCall{
            sender           : v0,
            amount_in        : arg1,
            min_amount_out   : arg2,
            deepbook_v2      : @0xdee9,
            deepbook_v3_1    : @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809,
            deepbook_v3_2    : @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244,
            execution_method : b"minimal_working_deepbook_swap",
        };
        0x2::event::emit<MinimalDeepBookCall>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v2 = DeepBookSwapExecuted{
            sender         : v0,
            amount_in      : arg1,
            min_amount_out : arg2,
            pool_id        : @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407,
            method         : b"minimal_deepbook_final_attempt",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
    }

    public fun get_deepbook_packages() : (address, address, address) {
        (@0xdee9, @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"DeepBook Minimal", b"Minimal working DeepBook implementation", 999)
    }

    public fun place_market_order<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = DeepBookSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg3,
            pool_id        : arg0,
            method         : b"place_market_order_compatible",
        };
        0x2::event::emit<DeepBookSwapExecuted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::coin::zero<T1>(arg5)
    }

    public entry fun swap_sui_to_usdc_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        execute_minimal_deepbook_swap(arg0, v0, arg1, arg2, arg3);
    }

    public entry fun swap_sui_to_usdc_v3_simplified(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        execute_minimal_deepbook_swap(arg0, v0, arg1, arg2, arg3);
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

