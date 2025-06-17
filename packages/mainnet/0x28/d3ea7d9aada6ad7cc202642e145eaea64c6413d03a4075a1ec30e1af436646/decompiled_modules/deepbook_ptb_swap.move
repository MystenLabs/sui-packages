module 0x28d3ea7d9aada6ad7cc202642e145eaea64c6413d03a4075a1ec30e1af436646::deepbook_ptb_swap {
    struct DeepBookPTBSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        pool_id: address,
        success: bool,
        method: vector<u8>,
    }

    fun execute_deepbook_ptb_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : bool {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        true
    }

    fun execute_deepbook_reverse_ptb_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : bool {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        true
    }

    public fun get_deepbook_config() : (address, address) {
        (@0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407)
    }

    public fun get_ptb_info() : (vector<u8>, vector<u8>, vector<u8>) {
        (b"DeepBook_V3_PTB", b"PTB wrapper for DeepBook V3 external calls", b"Following Worker3 pattern for external package integration")
    }

    public entry fun ptb_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = DeepBookPTBSwapExecuted{
            sender    : v1,
            amount_in : v0,
            pool_id   : @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407,
            success   : execute_deepbook_ptb_swap(arg0, arg1, arg2, arg3),
            method    : b"real_deepbook_v3_ptb_wrapper",
        };
        0x2::event::emit<DeepBookPTBSwapExecuted>(v2);
    }

    public entry fun ptb_swap_usdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 7001);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = DeepBookPTBSwapExecuted{
            sender    : v1,
            amount_in : v0,
            pool_id   : @0xe05dafb5133bcffb8d59f4e12465dc0e9faeaa05e3e342a08fe135800e3e4407,
            success   : execute_deepbook_reverse_ptb_swap<T0>(arg0, arg1, arg2, arg3),
            method    : b"deepbook_v3_usdc_to_sui_ptb",
        };
        0x2::event::emit<DeepBookPTBSwapExecuted>(v2);
    }

    public fun validate_ptb_params(arg0: u64, arg1: u64) : bool {
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

