module 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::deposit {
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

    public fun deposit<T0, T1>(arg0: &mut 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::ProtocolApp, arg1: &mut 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::Market<T0>, arg2: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::ensure_version_matches(arg0);
        assert!(!0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::has_circuit_break_triggered<T0>(arg1), 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3) = 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::handle_mint<T0, T1>(arg1, 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::obligation::id(arg2), arg3, v0);
        let v4 = 0x1::type_name::get<T1>();
        track_referral(arg0, 0x2::tx_context::sender(arg7), v1, v4, arg4, arg5, arg6);
        0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::borrow_liquidity_mining_mut<T0>(arg1), 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::liquidity_miner::get_deposit_reward_type(), 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::obligation::id(arg2), v3, arg6);
        let v5 = DepositEvent{
            minter              : 0x2::tx_context::sender(arg7),
            market              : 0x1::type_name::get<T0>(),
            obligation          : 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::obligation::id(arg2),
            deposit_asset       : v4,
            deposit_amount      : v1,
            ctoken_amount       : v2,
            total_ctoken_amount : v3,
            time                : v0,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    fun track_referral(arg0: &mut 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::ProtocolApp, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        let v0 = 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::referral_mut(arg0);
        if (0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::referral::is_qualified_to_create_referral_code(v0, arg1)) {
            return
        };
        0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::referral::track_deposit_usd(v0, arg1, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::value::coin_value(0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::user_oracle::get_price(arg5, arg3, 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::usd(), arg6), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from(arg2), 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

