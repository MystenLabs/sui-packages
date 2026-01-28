module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::permissionless {
    public fun commit_pyth_price(arg0: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof, arg4: &0x2::clock::Clock) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::commit_pyth_oracle_price(arg1, arg2, arg3, arg4);
    }

    public fun new_oracle_proof(arg0: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle) : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::new_proof(arg1)
    }

    public fun replenish<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::redeem_balance_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun replenish_receiving<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::receive_coin<T0>(arg0, arg1);
        replenish<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

