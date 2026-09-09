module 0xbaf8bbaffbe17cff2b2c490dda5bd8689298345fc3062542510c2f53bd349c7f::m1606eac506c04b7aa7865b14 {
    public fun f027d6918dfbf5229d9bb8169<T0, T1, T2>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg2: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_symbol_v2<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun f256a9647307855b54dccf7f0<T0, T1, T2>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg6: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg7: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v3_ptb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun f495085c0402fd3f0fba771e2<T0, T1>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg2: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun f73cb2007dbf2db5e9de1e54d<T0, T1>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::withdraw_ptb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun fe03eb632a30f3fed9443a76e<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_symbols_valuation<T0>(arg0, arg1)
    }

    public fun ffa3f80ae23d8c3d1e5258d0a<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

