module 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_kriya {
    public fun calculate_minimum_output(arg0: u64, arg1: u64) : u64 {
        arg0 * 997 / 1000 * (10000 - arg1) / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_min_trade_amount() : u64 {
        1000
    }

    public fun get_sui_wusdc_pool() : address {
        @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
    }

    public fun get_swap_function_name() : vector<u8> {
        b"swap_token_y"
    }

    public fun supports_wusdc() : bool {
        true
    }

    public fun swap_sui_to_wusdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(validate_pool(0x2::object::id_to_address(&arg1)), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::zero<T0>(arg2)
    }

    public fun swap_wusdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(validate_pool(0x2::object::id_to_address(&arg1)), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::zero<0x2::sui::SUI>(arg2)
    }

    public fun validate_amount_constraints(arg0: u64, arg1: u64) : bool {
        if (arg0 >= get_min_trade_amount()) {
            if (arg1 > 0) {
                arg1 <= arg0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_pool(arg0: address) : bool {
        arg0 == @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305
    }

    public fun validate_swap_params<T0, T1>(arg0: &0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (0x2::coin::value<T0>(arg0) > 0) {
            if (arg2 > 0) {
                0x2::object::id_to_address(&arg1) != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

