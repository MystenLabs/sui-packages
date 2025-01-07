module 0x2fe307f0802aa5e8e4bb6a35be25bb664e2ab7eecc74766669200e8f4e1e96a9::bluemove {
    struct BlueMoveSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x2fe307f0802aa5e8e4bb6a35be25bb664e2ab7eecc74766669200e8f4e1e96a9::config::Config, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v0, arg2, 0, arg1, arg3);
        let v2 = BlueMoveSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v1),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BlueMoveSwapEvent>(v2);
        let (v3, _) = 0x2fe307f0802aa5e8e4bb6a35be25bb664e2ab7eecc74766669200e8f4e1e96a9::config::pay_fee<T1>(arg0, v1, arg3);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2fe307f0802aa5e8e4bb6a35be25bb664e2ab7eecc74766669200e8f4e1e96a9::config::Config, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(v0, arg2, 0, arg1, arg3);
        let v2 = BlueMoveSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v1),
            a2b          : false,
            by_amount_in : false,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BlueMoveSwapEvent>(v2);
        let (v3, _) = 0x2fe307f0802aa5e8e4bb6a35be25bb664e2ab7eecc74766669200e8f4e1e96a9::config::pay_fee<T0>(arg0, v1, arg3);
        v3
    }

    // decompiled from Move bytecode v6
}

