module 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::bluemove {
    struct BlueMoveSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::Config, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v0, arg2, 0, arg1, arg3);
        let (v2, v3) = 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::pay_fee<T1>(arg0, v1, arg3);
        let v4 = BlueMoveSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v1) - v3,
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BlueMoveSwapEvent>(v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::Config, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(v0, arg2, 0, arg1, arg3);
        let (v2, v3) = 0xf2b20c10afe911aab3cb1f7067835a50c539870e3c0b61f8b501000a1c4e4d68::config::pay_fee<T0>(arg0, v1, arg3);
        let v4 = BlueMoveSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v1) - v3,
            a2b          : false,
            by_amount_in : false,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BlueMoveSwapEvent>(v4);
        v2
    }

    // decompiled from Move bytecode v6
}

