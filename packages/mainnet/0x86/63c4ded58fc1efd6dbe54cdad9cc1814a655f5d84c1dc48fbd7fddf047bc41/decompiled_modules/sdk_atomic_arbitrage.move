module 0x8663c4ded58fc1efd6dbe54cdad9cc1814a655f5d84c1dc48fbd7fddf047bc41::sdk_atomic_arbitrage {
    struct SwapReceipt has key {
        id: 0x2::object::UID,
        input_amount: u64,
        intermediate_token: vector<u8>,
        final_amount: u64,
        timestamp: u64,
    }

    public entry fun sdk_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 0x8663c4ded58fc1efd6dbe54cdad9cc1814a655f5d84c1dc48fbd7fddf047bc41::constants::sui_input_amount(), 3);
        let v2 = execute_sdk_swap_sui_to_token<T0>(arg0, v1, arg2, arg3);
        let v3 = execute_sdk_swap_token_to_sui<T0>(v2, 0x2::coin::value<T0>(&v2), arg2, arg3);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg1, 2);
        let v5 = SwapReceipt{
            id                 : 0x2::object::new(arg3),
            input_amount       : v1,
            intermediate_token : b"WUSDC",
            final_amount       : v4,
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<SwapReceipt>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
    }

    public fun cleanup_zero_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg0)) {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            if (0x2::coin::value<T0>(&v1) == 0) {
                0x2::coin::destroy_zero<T0>(v1);
            } else {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
    }

    public fun execute_sdk_swap_sui_to_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 >= 0x8663c4ded58fc1efd6dbe54cdad9cc1814a655f5d84c1dc48fbd7fddf047bc41::constants::sui_input_amount(), 3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::zero<T0>(arg3)
    }

    public fun execute_sdk_swap_token_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1 > 0, 3);
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    public fun get_receipt_details(arg0: &SwapReceipt) : (u64, vector<u8>, u64, u64) {
        (arg0.input_amount, arg0.intermediate_token, arg0.final_amount, arg0.timestamp)
    }

    public fun join_coin_vector<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun split_coin_exact<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public entry fun test_sdk_integration(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun verify_atomic_completion(arg0: &SwapReceipt, arg1: u64) : bool {
        let v0 = if (arg0.final_amount > arg0.input_amount) {
            arg0.final_amount - arg0.input_amount
        } else {
            0
        };
        v0 * 10000 / arg0.input_amount >= arg1
    }

    // decompiled from Move bytecode v6
}

