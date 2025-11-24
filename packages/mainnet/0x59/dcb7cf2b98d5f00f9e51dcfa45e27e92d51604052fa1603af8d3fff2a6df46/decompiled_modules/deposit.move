module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        total_ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::ensure_version_matches<T0>(arg1);
        assert!(!0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::has_circuit_break_triggered<T0>(arg1), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3) = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::handle_mint<T0, T1>(arg1, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::obligation::id(arg2), arg3, v0);
        let v4 = 0x1::type_name::get<T1>();
        track_referral(arg0, 0x2::tx_context::sender(arg7), v1, v4, arg4, arg5, arg6);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::borrow_liquidity_mining_mut<T0>(arg1), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::liquidity_miner::get_deposit_reward_type(), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::obligation::id(arg2), v3, arg6);
        let v5 = DepositEvent{
            minter              : 0x2::tx_context::sender(arg7),
            market              : 0x1::type_name::get<T0>(),
            obligation          : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::obligation::id(arg2),
            deposit_asset       : v4,
            deposit_amount      : v1,
            ctoken_amount       : v2,
            total_ctoken_amount : v3,
            time                : v0,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    fun track_referral(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        let v0 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral_mut(arg0);
        if (0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::is_qualified_to_create_referral_code(v0, arg1)) {
            return
        };
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::track_deposit_usd(v0, arg1, 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::floor(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::value::coin_value(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::user_oracle::get_price(arg5, arg3, 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::usd(), arg6), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::from(arg2), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

