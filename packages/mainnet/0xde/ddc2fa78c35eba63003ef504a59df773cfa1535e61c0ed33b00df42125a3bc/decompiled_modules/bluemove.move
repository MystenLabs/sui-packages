module 0xdeddc2fa78c35eba63003ef504a59df773cfa1535e61c0ed33b00df42125a3bc::bluemove {
    struct BluemoveSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v0, arg1, 0, arg0, arg2);
        let v2 = BluemoveSwapEvent{
            pool_id      : 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg0),
            a2b          : true,
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v1),
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BluemoveSwapEvent>(v2);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(v0, arg1, 0, arg0, arg2);
        let v2 = BluemoveSwapEvent{
            pool_id      : 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg0),
            a2b          : false,
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v1),
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BluemoveSwapEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

