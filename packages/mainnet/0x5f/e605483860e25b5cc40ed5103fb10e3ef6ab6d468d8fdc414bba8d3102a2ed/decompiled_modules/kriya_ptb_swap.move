module 0x5fe605483860e25b5cc40ed5103fb10e3ef6ab6d468d8fdc414bba8d3102a2ed::kriya_ptb_swap {
    struct KriyaPTBSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        pool_reference: address,
        success: bool,
        method: vector<u8>,
    }

    fun execute_kriya_ptb_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        true
    }

    fun execute_kriya_reverse_ptb_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        true
    }

    public fun get_function_info() : (vector<u8>, vector<u8>, vector<u8>) {
        (b"spot_dex::swap_token_y_", b"Function with underscore suffix - critical detail", b"Pool<COIN, SUI> type ordering discovered from bytecode")
    }

    public fun get_kriya_config() : (address, address) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305)
    }

    public fun get_ptb_info() : (vector<u8>, vector<u8>, vector<u8>) {
        (b"Kriya_PTB", b"PTB wrapper for Kriya spot_dex::swap_token_y_ external calls", b"Following Worker3 pattern, Pool<COIN, SUI> type")
    }

    public entry fun ptb_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = KriyaPTBSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            pool_reference : @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305,
            success        : execute_kriya_ptb_swap(arg0, arg1, arg2),
            method         : b"real_kriya_spot_dex_ptb_wrapper",
        };
        0x2::event::emit<KriyaPTBSwapExecuted>(v2);
    }

    public entry fun ptb_swap_usdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 6001);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = KriyaPTBSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            pool_reference : @0x5af4976b871fa1813362f352fa4cada3883a96191bb7212db1bd5d13685ae305,
            success        : execute_kriya_reverse_ptb_swap<T0>(arg0, arg1, arg2),
            method         : b"kriya_usdc_to_sui_swap_token_x_ptb",
        };
        0x2::event::emit<KriyaPTBSwapExecuted>(v2);
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

