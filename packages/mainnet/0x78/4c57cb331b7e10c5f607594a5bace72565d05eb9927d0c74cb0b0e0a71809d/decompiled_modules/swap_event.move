module 0x784c57cb331b7e10c5f607594a5bace72565d05eb9927d0c74cb0b0e0a71809d::swap_event {
    struct SwapHotPotato {
        coin_in_amount: u64,
        aggregator_type: u8,
        coin_in_type: 0x1::type_name::TypeName,
        swap_fee_numerator: u64,
    }

    struct ScallopSwapEvent has copy, drop {
        sender: address,
        timestamp: u64,
        coin_in_amount: u64,
        coin_in_type: 0x1::type_name::TypeName,
        coin_out_amount: u64,
        coin_out_type: 0x1::type_name::TypeName,
        aggregator_type: u8,
        swap_fee_numerator: u64,
        swap_fee_denominator: u64,
    }

    struct ScallopToolsEvent has copy, drop {
        sender: address,
        timestamp: u64,
    }

    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun create_swap_hot_potato<T0>(arg0: u8, arg1: &0x2::coin::Coin<T0>, arg2: u64) : SwapHotPotato {
        is_aggregator_valid(arg0);
        assert!(arg2 < 1000000000, 103);
        SwapHotPotato{
            coin_in_amount     : 0x2::coin::value<T0>(arg1),
            aggregator_type    : arg0,
            coin_in_type       : 0x1::type_name::get<T0>(),
            swap_fee_numerator : arg2,
        }
    }

    public fun emit_swap_event<T0>(arg0: SwapHotPotato, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let SwapHotPotato {
            coin_in_amount     : v0,
            aggregator_type    : v1,
            coin_in_type       : v2,
            swap_fee_numerator : v3,
        } = arg0;
        assert!(0x1::type_name::get<T0>() != v2, 102);
        let v4 = ScallopSwapEvent{
            sender               : 0x2::tx_context::sender(arg3),
            timestamp            : 0x2::clock::timestamp_ms(arg2) / 1000,
            coin_in_amount       : v0,
            coin_in_type         : v2,
            coin_out_amount      : 0x2::coin::value<T0>(arg1),
            coin_out_type        : 0x1::type_name::get<T0>(),
            aggregator_type      : v1,
            swap_fee_numerator   : v3,
            swap_fee_denominator : 1000000000,
        };
        0x2::event::emit<ScallopSwapEvent>(v4);
    }

    public fun emit_tools_event(arg0: &0x2::clock::Clock, arg1: &0x2::tx_context::TxContext) {
        let v0 = ScallopToolsEvent{
            sender    : 0x2::tx_context::sender(arg1),
            timestamp : 0x2::clock::timestamp_ms(arg0) / 1000,
        };
        0x2::event::emit<ScallopToolsEvent>(v0);
    }

    public fun get_swap_fee_denominator() : u64 {
        1000000000
    }

    fun is_aggregator_valid(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1 || arg0 == 2, 101);
    }

    // decompiled from Move bytecode v6
}

