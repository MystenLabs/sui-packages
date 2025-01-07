module 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bluemove {
    public fun blue_move_swap_buy<T0, T1>(arg0: &mut 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::KongBot<T0>, arg1: &mut 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::Banana<T0>, arg2: u64, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::transfer_bananas<T0>(arg0, arg1, arg5, arg6);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(v0, v1, arg3, arg4, arg6);
    }

    public fun blue_move_swap_sell<T0, T1>(arg0: &mut 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::KongBot<T1>, arg1: &mut 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::Banana<T1>, arg2: u64, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::transfer_bananas<T1>(arg0, arg1, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg2, arg5, arg3, arg4, arg6), arg6);
        0xf8c714664894611684ed9d196d0367261cd26be9e96eeef048d6163b8afd23f0::bot::transfer_or_destroy_coin<T1>(v1, arg6);
    }

    // decompiled from Move bytecode v6
}

