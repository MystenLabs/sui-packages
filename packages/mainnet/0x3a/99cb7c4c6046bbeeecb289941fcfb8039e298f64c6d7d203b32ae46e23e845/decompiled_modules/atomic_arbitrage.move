module 0x3a99cb7c4c6046bbeeecb289941fcfb8039e298f64c6d7d203b32ae46e23e845::atomic_arbitrage {
    struct AtomicSwapState has key {
        id: 0x2::object::UID,
        initiator: address,
        input_amount: u64,
        intermediate_token: vector<u8>,
        final_amount: u64,
        state: u8,
        timestamp: u64,
        min_output: u64,
    }

    struct SwapInitiated has copy, drop {
        state_id: address,
        initiator: address,
        sui_amount: u64,
        timestamp: u64,
    }

    struct SwapCompleted has copy, drop {
        state_id: address,
        initiator: address,
        final_sui_amount: u64,
        profit_amount: u64,
        timestamp: u64,
    }

    public entry fun batch_initialize_arbitrage(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 3);
        assert!(v0 > 0, 3);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
            let v3 = AtomicSwapState{
                id                 : 0x2::object::new(arg3),
                initiator          : 0x2::tx_context::sender(arg3),
                input_amount       : 0x2::coin::value<0x2::sui::SUI>(&v2),
                intermediate_token : b"BATCH_PENDING",
                final_amount       : 0,
                state              : 0,
                timestamp          : 0x2::clock::timestamp_ms(arg2),
                min_output         : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::object::id_address<AtomicSwapState>(&v3));
            0x2::transfer::share_object<AtomicSwapState>(v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun calculate_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) * 10000 / arg0
    }

    public entry fun complete_atomic_arbitrage(arg0: &mut AtomicSwapState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.initiator, 6);
        assert!(arg0.state == 0, 5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.min_output, 2);
        let v2 = if (v1 > arg0.input_amount) {
            v1 - arg0.input_amount
        } else {
            0
        };
        arg0.final_amount = v1;
        arg0.state = 1;
        let v3 = SwapCompleted{
            state_id         : 0x2::object::id_address<AtomicSwapState>(arg0),
            initiator        : v0,
            final_sui_amount : v1,
            profit_amount    : v2,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapCompleted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
    }

    public entry fun emergency_abort(arg0: &mut AtomicSwapState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.initiator, 6);
        assert!(arg0.state == 0, 5);
        arg0.state = 2;
    }

    public fun get_swap_details(arg0: &AtomicSwapState) : (address, u64, u64, u8, u64) {
        (arg0.initiator, arg0.input_amount, arg0.final_amount, arg0.state, arg0.timestamp)
    }

    public entry fun initialize_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= 0x3a99cb7c4c6046bbeeecb289941fcfb8039e298f64c6d7d203b32ae46e23e845::constants::sui_input_amount(), 3);
        let v3 = AtomicSwapState{
            id                 : 0x2::object::new(arg3),
            initiator          : v0,
            input_amount       : v1,
            intermediate_token : b"PENDING_SDK",
            final_amount       : 0,
            state              : 0,
            timestamp          : v2,
            min_output         : arg1,
        };
        let v4 = 0x2::object::id_address<AtomicSwapState>(&v3);
        let v5 = SwapInitiated{
            state_id   : v4,
            initiator  : v0,
            sui_amount : v1,
            timestamp  : v2,
        };
        0x2::event::emit<SwapInitiated>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v4);
        0x2::transfer::share_object<AtomicSwapState>(v3);
    }

    public fun is_completed(arg0: &AtomicSwapState) : bool {
        arg0.state == 1
    }

    public fun is_pending(arg0: &AtomicSwapState) : bool {
        arg0.state == 0
    }

    public fun join_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0), 3);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun min_sui_amount() : u64 {
        0x3a99cb7c4c6046bbeeecb289941fcfb8039e298f64c6d7d203b32ae46e23e845::constants::sui_input_amount()
    }

    public fun split_coin_exact<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 3);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun validate_profit_threshold(arg0: u64, arg1: u64, arg2: u64) : bool {
        calculate_profit_bps(arg0, arg1) >= arg2
    }

    // decompiled from Move bytecode v6
}

