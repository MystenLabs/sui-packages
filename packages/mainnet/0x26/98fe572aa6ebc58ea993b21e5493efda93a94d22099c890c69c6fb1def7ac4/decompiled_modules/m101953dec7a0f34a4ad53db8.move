module 0x2698fe572aa6ebc58ea993b21e5493efda93a94d22099c890c69c6fb1def7ac4::m101953dec7a0f34a4ad53db8 {
    public fun f02d9451678e7544121533975<T0, T1>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::deposit_ptb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f0dc69aaca3e4a267ca5d2392<T0, T1>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::withdraw_ptb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f22d3b51c3c49909a254b2a8a<T0, T1, T2>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg6: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg7: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v3_ptb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun f36715ee6a12f71d218eb21f1<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg0, arg1)
    }

    public fun f7357f0ac7ddefca44d4e1d99<T0, T1>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg2: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun f8c6a677a5ba79dc6aca22c13<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_symbols_valuation<T0>(arg0, arg1)
    }

    public fun fde067d60696ccea3a04dfc38<T0, T1, T2>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg2: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_symbol_v2<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

