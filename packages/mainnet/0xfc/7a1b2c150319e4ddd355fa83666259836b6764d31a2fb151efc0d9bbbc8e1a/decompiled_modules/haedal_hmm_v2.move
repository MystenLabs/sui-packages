module 0xfc7a1b2c150319e4ddd355fa83666259836b6764d31a2fb151efc0d9bbbc8e1a::haedal_hmm_v2 {
    struct HaedalHmmV2SwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_base_coin<T0, T1>(arg0, arg3, arg1, &mut arg2, v0, 0, arg4);
        0xfc7a1b2c150319e4ddd355fa83666259836b6764d31a2fb151efc0d9bbbc8e1a::utils::transfer_or_destroy_coin<T0>(arg2, arg4);
        let v2 = HaedalHmmV2SwapEvent{
            pool         : 0x2::object::id<0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>>(arg0),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v1),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<HaedalHmmV2SwapEvent>(v2);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_quote_coin<T0, T1>(arg0, arg3, arg1, &mut arg2, v0, 0, arg4);
        0xfc7a1b2c150319e4ddd355fa83666259836b6764d31a2fb151efc0d9bbbc8e1a::utils::transfer_or_destroy_coin<T1>(arg2, arg4);
        let v2 = HaedalHmmV2SwapEvent{
            pool         : 0x2::object::id<0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>>(arg0),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v1),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<HaedalHmmV2SwapEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

