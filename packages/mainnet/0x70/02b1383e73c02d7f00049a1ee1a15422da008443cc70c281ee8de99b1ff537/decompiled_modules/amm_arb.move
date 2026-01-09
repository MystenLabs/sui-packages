module 0x7002b1383e73c02d7f00049a1ee1a15422da008443cc70c281ee8de99b1ff537::amm_arb {
    public fun flowx_swap_x_to_y_internal<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, arg1, arg2)
    }

    public fun flowx_swap_y_to_x_internal<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, arg1, arg2)
    }

    public fun kriya_swap_x_to_y_internal<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg1), 1, arg2)
    }

    public fun kriya_swap_y_to_x_internal<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, arg1, 0x2::coin::value<T1>(&arg1), 1, arg2)
    }

    public fun tx_1<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = kriya_swap_x_to_y_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = flowx_swap_y_to_x_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T0>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_1_f<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = kriya_swap_x_to_y_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = flowx_swap_x_to_y_internal<T1, T0>(arg1, v0, arg4);
        assert!(0x2::coin::value<T0>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_2<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = flowx_swap_x_to_y_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = kriya_swap_y_to_x_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T0>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_2_f<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = flowx_swap_y_to_x_internal<T1, T0>(arg0, arg2, arg4);
        let v1 = kriya_swap_y_to_x_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T0>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_3<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = kriya_swap_y_to_x_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = flowx_swap_x_to_y_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T1>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_3_f<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = kriya_swap_y_to_x_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = flowx_swap_y_to_x_internal<T1, T0>(arg1, v0, arg4);
        assert!(0x2::coin::value<T1>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_4<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = flowx_swap_y_to_x_internal<T0, T1>(arg0, arg2, arg4);
        let v1 = kriya_swap_x_to_y_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T1>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun tx_4_f<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = flowx_swap_x_to_y_internal<T1, T0>(arg0, arg2, arg4);
        let v1 = kriya_swap_x_to_y_internal<T0, T1>(arg1, v0, arg4);
        assert!(0x2::coin::value<T1>(&v1) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

