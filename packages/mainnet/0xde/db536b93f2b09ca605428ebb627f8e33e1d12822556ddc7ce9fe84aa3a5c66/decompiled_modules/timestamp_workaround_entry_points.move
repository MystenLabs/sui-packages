module 0xdedb536b93f2b09ca605428ebb627f8e33e1d12822556ddc7ce9fe84aa3a5c66::timestamp_workaround_entry_points {
    struct UniversalSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        dex_id: u8,
        method: vector<u8>,
        epoch: u64,
    }

    public entry fun cetus_swap_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        universal_swap_sui_to_usdc_no_clock(arg0, arg1, arg2, 1, arg3);
    }

    public entry fun deepbook_swap_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        universal_swap_sui_to_usdc_no_clock(arg0, arg1, arg2, 4, arg3);
    }

    public entry fun emergency_swap_any_dex(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        abort 1001
    }

    public fun get_current_epoch(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::epoch(arg0)
    }

    public fun is_valid_dex_id(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 6
    }

    public entry fun kriya_swap_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        universal_swap_sui_to_usdc_no_clock(arg0, arg1, arg2, 2, arg3);
    }

    public entry fun test_entry_point_connectivity(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UniversalSwapExecuted{
            sender         : 0x2::tx_context::sender(arg0),
            amount_in      : 0,
            min_amount_out : 0,
            pool_id        : @0x0,
            dex_id         : 0,
            method         : b"connectivity_test",
            epoch          : 0x2::tx_context::epoch(arg0),
        };
        0x2::event::emit<UniversalSwapExecuted>(v0);
    }

    public entry fun turbos_swap_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        universal_swap_sui_to_usdc_no_clock(arg0, arg1, arg2, 3, arg3);
    }

    public entry fun universal_swap_sui_to_usdc_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1001);
        assert!(arg2 > 0, 1003);
        assert!(arg1 != @0x0, 1002);
        assert!(arg3 >= 1 && arg3 <= 6, 1004);
        let v1 = UniversalSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            dex_id         : arg3,
            method         : b"universal_no_clock_workaround",
            epoch          : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<UniversalSwapExecuted>(v1);
        abort 1001
    }

    // decompiled from Move bytecode v6
}

