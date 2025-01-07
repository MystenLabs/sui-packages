module 0x954e404cdd15b5859c18425b737d848d28f7f63ae6b74e9a2656784d1ae0683c::flow_x {
    struct FlowX has drop {
        dummy_field: bool,
    }

    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T1>(arg2) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T0, T1>(v1, arg2, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg3));
    }

    public fun swap_exact_output_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T1>(arg3) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T0, T1>(v1, arg3, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_direct<T0, T1>(arg0, arg1, arg2, arg4));
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T1>(arg2) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T0, T1>(v1, arg2, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, arg1, arg3));
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T1, T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T1, T0>(arg2) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T1, T0>(v1, arg2, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, arg1, arg3));
    }

    public fun swap_x_to_exact_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T1>(arg3) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T0, T1>(v1, arg3, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_x_to_exact_y_direct<T0, T1>(arg0, arg1, arg2, arg4));
    }

    public fun swap_y_to_exact_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T1, T0>(arg3) == v0, 1);
        let v1 = FlowX{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<FlowX, T1, T0>(v1, arg3, v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_y_to_exact_x_direct<T0, T1>(arg0, arg1, arg2, arg4));
    }

    // decompiled from Move bytecode v6
}

