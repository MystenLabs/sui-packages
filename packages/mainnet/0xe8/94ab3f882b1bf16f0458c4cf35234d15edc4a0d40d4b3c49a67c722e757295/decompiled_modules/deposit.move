module 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::deposit {
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

    public fun deposit<T0, T1>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg1: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg2: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg1);
        assert!(!0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::has_circuit_break_triggered<T0>(arg1), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3) = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::handle_mint<T0, T1>(arg1, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg2), arg3, v0);
        let v4 = 0x1::type_name::get<T1>();
        track_referral(arg0, 0x2::tx_context::sender(arg7), v1, v4, arg4, arg5, arg6);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::borrow_liquidity_mining_mut<T0>(arg1), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::get_deposit_reward_type(), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg2), v3, arg6);
        let v5 = DepositEvent{
            minter              : 0x2::tx_context::sender(arg7),
            market              : 0x1::type_name::get<T0>(),
            obligation          : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg2),
            deposit_asset       : v4,
            deposit_amount      : v1,
            ctoken_amount       : v2,
            total_ctoken_amount : v3,
            time                : v0,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    fun track_referral(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        let v0 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::referral_mut(arg0);
        if (0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::referral::is_qualified_to_create_referral_code(v0, arg1)) {
            return
        };
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::referral::track_deposit_usd(v0, arg1, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::value::coin_value(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg5, arg3, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::usd(), arg6), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(arg2), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

