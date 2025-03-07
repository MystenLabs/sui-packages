module 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_manager {
    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sui: u64,
        tokens: u64,
        fee_amount: u64,
        ghost_sui: u64,
        sui_in_pool: u64,
        tokens_in_pool: u64,
        event_type: vector<u8>,
        message: vector<u8>,
        timestamp: u64,
    }

    public(friend) fun swap_a_to_b<T0>(arg0: u64, arg1: u64, arg2: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_logic::calculate_fee(v0, arg0, 10000, arg1);
        let v2 = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_logic::calculate_amount_out(v0 - v1, 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg2) + 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_ghost_reserves<T0>(arg2), 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_b<T0>(arg2));
        0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::deposit_a<T0>(arg2, arg3);
        0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::set_last_trade<T0>(arg2, arg5);
        let v3 = SwapEvent{
            pool_id        : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_pool_id<T0>(arg2),
            sui            : v0,
            tokens         : v2,
            fee_amount     : v1,
            ghost_sui      : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_ghost_reserves<T0>(arg2),
            sui_in_pool    : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg2),
            tokens_in_pool : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_b<T0>(arg2),
            event_type     : b"buy",
            message        : arg4,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<SwapEvent>(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::borrow_mut_coin_b<T0>(arg2), v2), arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg5))
    }

    public(friend) fun swap_b_to_a<T0>(arg0: u64, arg1: u64, arg2: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_logic::calculate_amount_out(v0, 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_b<T0>(arg2), 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg2) + 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_ghost_reserves<T0>(arg2));
        0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::deposit_b<T0>(arg2, arg3);
        0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::set_last_trade<T0>(arg2, arg4);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::borrow_mut_coin_a<T0>(arg2), v1), arg4);
        let v3 = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_logic::calculate_fee(0x2::coin::value<0x2::sui::SUI>(&v2), arg0, 10000, arg1);
        let v4 = SwapEvent{
            pool_id        : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_pool_id<T0>(arg2),
            sui            : v1 - v3,
            tokens         : v0,
            fee_amount     : v3,
            ghost_sui      : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_ghost_reserves<T0>(arg2),
            sui_in_pool    : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg2),
            tokens_in_pool : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_b<T0>(arg2),
            event_type     : b"sell",
            message        : b"",
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<SwapEvent>(v4);
        (v2, 0x2::coin::split<0x2::sui::SUI>(&mut v2, v3, arg4))
    }

    // decompiled from Move bytecode v6
}

