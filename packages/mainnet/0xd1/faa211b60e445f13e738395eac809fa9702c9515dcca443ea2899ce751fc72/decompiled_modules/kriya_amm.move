module 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::kriya_amm {
    struct KriyaAmmSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::Config, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg2, v0, 0, arg3);
        let (v2, v3) = 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::pay_fee<T1>(arg0, v1, arg3);
        let v4 = KriyaAmmSwapEvent{
            pool         : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v1) - v3,
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<KriyaAmmSwapEvent>(v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::Config, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg2, v0, 0, arg3);
        let (v2, v3) = 0xd1faa211b60e445f13e738395eac809fa9702c9515dcca443ea2899ce751fc72::setting::pay_fee<T0>(arg0, v1, arg3);
        let v4 = KriyaAmmSwapEvent{
            pool         : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v1) - v3,
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<KriyaAmmSwapEvent>(v4);
        v2
    }

    // decompiled from Move bytecode v6
}

