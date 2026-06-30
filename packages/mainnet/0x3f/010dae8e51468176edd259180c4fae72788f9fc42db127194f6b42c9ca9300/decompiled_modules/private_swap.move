module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::private_swap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapState has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        coin_coin_fee_bps: u64,
        max_fee_bps: u64,
        fee_denominator: u64,
        total_swapped: u64,
    }

    struct PrivateSwap has copy, drop {
        swap_id: address,
        timestamp_ms: u64,
    }

    public fun coin_coin_fee_bps(arg0: &SwapState) : u64 {
        arg0.coin_coin_fee_bps
    }

    fun compute_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / arg2
    }

    public fun fee_bps(arg0: &SwapState) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapState{
            id                : 0x2::object::new(arg0),
            fee_bps           : 5,
            coin_coin_fee_bps : 0,
            max_fee_bps       : 100,
            fee_denominator   : 10000,
            total_swapped     : 0,
        };
        0x2::transfer::share_object<SwapState>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_fee_bps(arg0: &SwapState) : u64 {
        arg0.max_fee_bps
    }

    public(friend) entry fun private_swap_coin_for_coin<T0>(arg0: &mut SwapState, arg1: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter::FeeSplitter, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 1);
        assert!(arg3 != @0x0, 2);
        arg0.total_swapped = arg0.total_swapped + 0x2::coin::value<T0>(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
        let v0 = 0x2::object::new(arg5);
        0x2::object::delete(v0);
        let v1 = PrivateSwap{
            swap_id      : 0x2::object::uid_to_address(&v0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PrivateSwap>(v1);
    }

    public(friend) entry fun private_swap_coin_for_sui(arg0: &mut SwapState, arg1: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter::FeeSplitter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg3 != @0x0, 2);
        let v1 = compute_fee(v0, arg0.fee_bps, arg0.fee_denominator);
        if (v1 > 0) {
            0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter::deposit(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg5));
        };
        arg0.total_swapped = arg0.total_swapped + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg3);
        let v2 = 0x2::object::new(arg5);
        0x2::object::delete(v2);
        let v3 = PrivateSwap{
            swap_id      : 0x2::object::uid_to_address(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PrivateSwap>(v3);
    }

    public(friend) entry fun private_swap_sui_for_coin(arg0: &mut SwapState, arg1: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter::FeeSplitter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg3 != @0x0, 2);
        let v1 = compute_fee(v0, arg0.fee_bps, arg0.fee_denominator);
        if (v1 > 0) {
            0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter::deposit(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg5));
        };
        arg0.total_swapped = arg0.total_swapped + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg3);
        let v2 = 0x2::object::new(arg5);
        0x2::object::delete(v2);
        let v3 = PrivateSwap{
            swap_id      : 0x2::object::uid_to_address(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PrivateSwap>(v3);
    }

    public(friend) entry fun set_coin_coin_fee_bps(arg0: &AdminCap, arg1: &mut SwapState, arg2: u64) {
        assert!(arg2 <= arg1.max_fee_bps, 3);
        arg1.coin_coin_fee_bps = arg2;
    }

    public(friend) entry fun set_fee_bps(arg0: &AdminCap, arg1: &mut SwapState, arg2: u64) {
        assert!(arg2 <= arg1.max_fee_bps, 3);
        arg1.fee_bps = arg2;
    }

    public fun total_swapped(arg0: &SwapState) : u64 {
        arg0.total_swapped
    }

    // decompiled from Move bytecode v7
}

