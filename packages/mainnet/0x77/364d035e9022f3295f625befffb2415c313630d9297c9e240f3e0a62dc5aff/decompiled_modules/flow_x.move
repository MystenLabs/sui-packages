module 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::flow_x {
    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T1>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::value<T0>(&v3);
        let v4 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, v3, arg4);
        assert!(0x2::coin::value<T1>(&v4) >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T1>(&v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T1>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T1>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::value<T0>(&v3);
        let v4 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, v3, arg4);
        assert!(0x2::coin::value<T1>(&v4) >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T1>(&v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T1>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T1, T0>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::value<T1>(&v3);
        let v4 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, v3, arg4);
        assert!(0x2::coin::value<T0>(&v4) >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T1, T0>(&v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T1, T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T1, T0>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

