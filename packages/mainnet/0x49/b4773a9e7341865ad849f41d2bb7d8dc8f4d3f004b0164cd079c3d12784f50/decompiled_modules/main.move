module 0x49b4773a9e7341865ad849f41d2bb7d8dc8f4d3f004b0164cd079c3d12784f50::main {
    struct GenericCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct SwapExecution has store, key {
        id: 0x2::object::UID,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun execute_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = SwapExecution{
            id            : 0x2::object::new(arg2),
            input_amount  : v0,
            output_amount : 0,
            profit        : 0,
            timestamp     : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<SwapExecution>(v1);
    }

    public fun get_execution_details(arg0: &SwapExecution) : (u64, u64, u64, u64) {
        (arg0.input_amount, arg0.output_amount, arg0.profit, arg0.timestamp)
    }

    public fun get_execution_id(arg0: &SwapExecution) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_profitable(arg0: &SwapExecution) : bool {
        arg0.output_amount > arg0.input_amount
    }

    public entry fun swap_sui_to_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(arg1 > 0, 1);
        let v1 = SwapExecution{
            id            : 0x2::object::new(arg2),
            input_amount  : v0,
            output_amount : 0,
            profit        : 0,
            timestamp     : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<SwapExecution>(v1);
    }

    public entry fun swap_token_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!(arg1 > 0, 1);
        let v1 = SwapExecution{
            id            : 0x2::object::new(arg2),
            input_amount  : v0,
            output_amount : 0,
            profit        : 0,
            timestamp     : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<SwapExecution>(v1);
    }

    public entry fun update_execution_results(arg0: &mut SwapExecution, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.output_amount = arg1;
        arg0.profit = arg2;
        arg0.timestamp = arg3;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

