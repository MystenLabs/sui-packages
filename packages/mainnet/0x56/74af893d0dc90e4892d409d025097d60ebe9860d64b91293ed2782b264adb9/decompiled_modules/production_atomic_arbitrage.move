module 0x5674af893d0dc90e4892d409d025097d60ebe9860d64b91293ed2782b264adb9::production_atomic_arbitrage {
    struct AtomicArbitrageState has key {
        id: 0x2::object::UID,
        initiator: address,
        initial_sui_amount: u64,
        current_stage: u8,
        timestamp: u64,
        min_final_output: u64,
        dex_route: vector<0x1::string::String>,
        intermediate_amounts: 0x2::bag::Bag,
    }

    struct ArbitrageInitiated has copy, drop {
        state_id: address,
        initiator: address,
        initial_amount: u64,
        timestamp: u64,
        dex_route: vector<0x1::string::String>,
    }

    struct FirstSwapCompleted has copy, drop {
        state_id: address,
        initiator: address,
        intermediate_amount: u64,
        timestamp: u64,
    }

    struct ArbitrageCompleted has copy, drop {
        state_id: address,
        initiator: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun batch_arbitrage_initialize(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: vector<u64>, arg2: vector<vector<0x1::string::String>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0);
        let v1 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == v1 && v1 == 0x1::vector::length<vector<0x1::string::String>>(&arg2), 3);
        assert!(v0 > 0, 3);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
            let v4 = AtomicArbitrageState{
                id                   : 0x2::object::new(arg4),
                initiator            : 0x2::tx_context::sender(arg4),
                initial_sui_amount   : 0x2::coin::value<0x2::sui::SUI>(&v3),
                current_stage        : 0,
                timestamp            : 0x2::clock::timestamp_ms(arg3),
                min_final_output     : *0x1::vector::borrow<u64>(&arg1, v2),
                dex_route            : *0x1::vector::borrow<vector<0x1::string::String>>(&arg2, v2),
                intermediate_amounts : 0x2::bag::new(arg4),
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::object::id_address<AtomicArbitrageState>(&v4));
            0x2::transfer::share_object<AtomicArbitrageState>(v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public fun calculate_arbitrage_efficiency(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg0 + arg2) {
            return 0
        };
        (arg1 - arg0 - arg2) * 10000 / arg0
    }

    public entry fun complete_atomic_arbitrage(arg0: &mut AtomicArbitrageState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.initiator, 6);
        assert!(arg0.current_stage == 1, 5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.min_final_output, 2);
        let v2 = if (v1 > arg0.initial_sui_amount) {
            v1 - arg0.initial_sui_amount
        } else {
            0
        };
        arg0.current_stage = 2;
        let v3 = ArbitrageCompleted{
            state_id       : 0x2::object::id_address<AtomicArbitrageState>(arg0),
            initiator      : v0,
            initial_amount : arg0.initial_sui_amount,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageCompleted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
    }

    public fun create_dex_route(arg0: 0x1::string::String, arg1: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg1);
        v0
    }

    public fun default_efficiency_threshold_bps() : u64 {
        50
    }

    public entry fun emergency_abort_arbitrage(arg0: &mut AtomicArbitrageState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.initiator, 6);
        assert!(arg0.current_stage < 2, 5);
        arg0.current_stage = 99;
    }

    public fun get_arbitrage_details(arg0: &AtomicArbitrageState) : (address, u64, u8, u64, vector<0x1::string::String>) {
        (arg0.initiator, arg0.initial_sui_amount, arg0.current_stage, arg0.timestamp, arg0.dex_route)
    }

    public fun get_intermediate_amount(arg0: &AtomicArbitrageState) : u64 {
        if (0x2::bag::contains<vector<u8>>(&arg0.intermediate_amounts, b"intermediate")) {
            *0x2::bag::borrow<vector<u8>, u64>(&arg0.intermediate_amounts, b"intermediate")
        } else {
            0
        }
    }

    public entry fun initialize_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= 0x5674af893d0dc90e4892d409d025097d60ebe9860d64b91293ed2782b264adb9::constants::sui_input_amount(), 3);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v3, arg3);
        let v4 = AtomicArbitrageState{
            id                   : 0x2::object::new(arg5),
            initiator            : v0,
            initial_sui_amount   : v1,
            current_stage        : 0,
            timestamp            : v2,
            min_final_output     : arg1,
            dex_route            : v3,
            intermediate_amounts : 0x2::bag::new(arg5),
        };
        let v5 = 0x2::object::id_address<AtomicArbitrageState>(&v4);
        let v6 = ArbitrageInitiated{
            state_id       : v5,
            initiator      : v0,
            initial_amount : v1,
            timestamp      : v2,
            dex_route      : v3,
        };
        0x2::event::emit<ArbitrageInitiated>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v5);
        0x2::transfer::share_object<AtomicArbitrageState>(v4);
    }

    public fun is_arbitrage_completed(arg0: &AtomicArbitrageState) : bool {
        arg0.current_stage == 2
    }

    public fun is_arbitrage_in_progress(arg0: &AtomicArbitrageState) : bool {
        arg0.current_stage < 2 && arg0.current_stage != 99
    }

    public entry fun mark_first_swap_complete<T0>(arg0: &mut AtomicArbitrageState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.initiator, 6);
        assert!(arg0.current_stage == 0, 5);
        assert!(arg1 > 0, 3);
        arg0.current_stage = 1;
        0x2::bag::add<vector<u8>, u64>(&mut arg0.intermediate_amounts, b"intermediate", arg1);
        let v1 = FirstSwapCompleted{
            state_id            : 0x2::object::id_address<AtomicArbitrageState>(arg0),
            initiator           : v0,
            intermediate_amount : arg1,
            timestamp           : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FirstSwapCompleted>(v1);
    }

    public fun max_slippage_bps() : u64 {
        300
    }

    public fun merge_sui_outputs(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0), 3);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        v0
    }

    public fun min_arbitrage_amount() : u64 {
        0x5674af893d0dc90e4892d409d025097d60ebe9860d64b91293ed2782b264adb9::constants::sui_input_amount()
    }

    public fun prepare_sui_for_routing(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 3);
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public fun validate_arbitrage_threshold(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        calculate_arbitrage_efficiency(arg0, arg1, arg2) >= arg3
    }

    public fun validate_dex_route(arg0: &vector<0x1::string::String>) : bool {
        let v0 = 0x1::vector::length<0x1::string::String>(arg0);
        v0 >= 2 && v0 <= 4
    }

    // decompiled from Move bytecode v6
}

