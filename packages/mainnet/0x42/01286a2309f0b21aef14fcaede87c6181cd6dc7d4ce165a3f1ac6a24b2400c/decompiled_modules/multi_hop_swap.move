module 0x4201286a2309f0b21aef14fcaede87c6181cd6dc7d4ce165a3f1ac6a24b2400c::multi_hop_swap {
    struct MultiHopSwapExecuted has copy, drop {
        trader: address,
        path: vector<address>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    struct PathValidated has copy, drop {
        validator: address,
        path_id: address,
        is_profitable: bool,
        expected_profit: u64,
        timestamp: u64,
    }

    struct SwapManager has key {
        id: 0x2::object::UID,
        swaps_executed: u64,
        total_volume: u64,
        total_profit: u64,
        paused: bool,
        admin: address,
        max_loan_amount: u64,
        whitelisted_paths: vector<SwapPath>,
    }

    struct SwapPath has copy, drop, store {
        pools: vector<address>,
        directions: vector<bool>,
        min_profit_bps: u64,
        last_validated: u64,
        times_used: u64,
    }

    struct PoolPair has store {
        pool_address: address,
        base_type: vector<u8>,
        quote_type: vector<u8>,
        fee_bps: u64,
        liquidity: u64,
    }

    struct SwapCommitment has key {
        id: 0x2::object::UID,
        committer: address,
        commitment_hash: vector<u8>,
        amount: u64,
        timestamp: u64,
        revealed: bool,
    }

    public entry fun add_whitelisted_path(arg0: &mut SwapManager, arg1: vector<address>, arg2: vector<bool>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 4);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<bool>(&arg2), 2);
        assert!(0x1::vector::length<address>(&arg1) <= 5, 6);
        let v0 = SwapPath{
            pools          : arg1,
            directions     : arg2,
            min_profit_bps : arg3,
            last_validated : 0x2::clock::timestamp_ms(arg4),
            times_used     : 0,
        };
        0x1::vector::push_back<SwapPath>(&mut arg0.whitelisted_paths, v0);
    }

    public fun calculate_multi_hop_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = v0 * (10000 - arg2);
            v0 = v2 / 10000;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun commit_swap(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapCommitment{
            id              : 0x2::object::new(arg3),
            committer       : 0x2::tx_context::sender(arg3),
            commitment_hash : arg0,
            amount          : arg1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
            revealed        : false,
        };
        0x2::transfer::transfer<SwapCommitment>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapManager{
            id                : 0x2::object::new(arg0),
            swaps_executed    : 0,
            total_volume      : 0,
            total_profit      : 0,
            paused            : false,
            admin             : 0x2::tx_context::sender(arg0),
            max_loan_amount   : 10000000000000,
            whitelisted_paths : 0x1::vector::empty<SwapPath>(),
        };
        0x2::transfer::share_object<SwapManager>(v0);
    }

    public entry fun execute_multi_hop_flash_swap_demo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut SwapManager, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.paused, 3);
        assert!(arg2 <= arg4.max_loan_amount, 7);
        assert!(arg1 <= 5, 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg2, arg7);
        let v3 = v1;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = calculate_multi_hop_output(v4, arg1, 50);
        let v6 = v5 + v5 * (100 + arg1 * 50) / 10000;
        assert!(v6 >= arg3, 5);
        let v7 = v4 + v4 * 9 / 10000;
        assert!(v6 >= v7, 1);
        let v8 = v6 - v7;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg6, v0);
        arg4.swaps_executed = arg4.swaps_executed + 1;
        arg4.total_volume = arg4.total_volume + v4;
        arg4.total_profit = arg4.total_profit + v8;
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0));
        let v10 = MultiHopSwapExecuted{
            trader        : v0,
            path          : v9,
            input_amount  : v4,
            output_amount : v6,
            profit        : v8,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MultiHopSwapExecuted>(v10);
    }

    public entry fun execute_path_swap<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut SwapManager, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 3);
        assert!(arg1 < 0x1::vector::length<SwapPath>(&arg3.whitelisted_paths), 2);
        let v0 = 0x1::vector::borrow_mut<SwapPath>(&mut arg3.whitelisted_paths, arg1);
        v0.times_used = v0.times_used + 1;
        execute_multi_hop_flash_swap_demo<T0, T1>(arg0, 0x1::vector::length<address>(&v0.pools), arg2, arg2 + arg2 * v0.min_profit_bps / 10000, arg3, arg4, arg5, arg6);
    }

    public fun get_swaps_executed(arg0: &SwapManager) : u64 {
        arg0.swaps_executed
    }

    public fun get_total_profit(arg0: &SwapManager) : u64 {
        arg0.total_profit
    }

    public fun get_total_volume(arg0: &SwapManager) : u64 {
        arg0.total_volume
    }

    public fun get_whitelisted_paths_count(arg0: &SwapManager) : u64 {
        0x1::vector::length<SwapPath>(&arg0.whitelisted_paths)
    }

    public fun is_path_whitelisted(arg0: &SwapManager, arg1: &vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SwapPath>(&arg0.whitelisted_paths)) {
            if (&0x1::vector::borrow<SwapPath>(&arg0.whitelisted_paths, v0).pools == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun reveal_and_execute_swap<T0, T1>(arg0: &mut SwapCommitment, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut SwapManager, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.revealed, 4);
        assert!(0x2::tx_context::sender(arg7) == arg0.committer, 4);
        arg0.revealed = true;
        execute_multi_hop_flash_swap_demo<T0, T1>(arg1, arg2, arg0.amount, arg0.amount, arg4, arg5, arg6, arg7);
    }

    public entry fun set_pause_status(arg0: &mut SwapManager, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

