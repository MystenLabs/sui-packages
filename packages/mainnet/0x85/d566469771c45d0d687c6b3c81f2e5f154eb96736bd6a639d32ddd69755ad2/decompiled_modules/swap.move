module 0x85d566469771c45d0d687c6b3c81f2e5f154eb96736bd6a639d32ddd69755ad2::swap {
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

    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun add_coin_in_amount<T0>(arg0: &mut SwapHotPotato, arg1: &0x2::coin::Coin<T0>) {
        assert!(0x1::type_name::get<T0>() == arg0.coin_in_type, 103);
        arg0.coin_in_amount = arg0.coin_in_amount + 0x2::coin::value<T0>(arg1);
    }

    public fun create_swap_hot_potato<T0>(arg0: u8, arg1: &0x2::coin::Coin<T0>, arg2: u64) : SwapHotPotato {
        assert!(arg2 < 1000000000, 104);
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

    public fun get_swap_fee_denominator() : u64 {
        1000000000
    }

    public fun take_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 1000000000, 104);
        assert!(arg1 > 0, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg1 / 1000000000, arg2), @0x1226a80ef40bd2e70c6a285b045b9b5d29915a2c5a2d57a2d3032cbdd89a8d5c);
    }

    // decompiled from Move bytecode v6
}

