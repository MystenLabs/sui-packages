module 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        borrow_index: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::obligation::ObligationOwnerCap, arg1: &mut 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::market::Market<T0>, arg2: &0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::market::ensure_version_matches<T0>(arg1);
        assert!(!0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::market::has_circuit_break_triggered<T0>(arg1), 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2, v3) = 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::market::handle_borrow<T0, T1>(arg1, 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::obligation::id(arg0), arg3, arg2, arg4, arg5, v0);
        0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::market::borrow_liquidity_mining_mut<T0>(arg1), 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::liquidity_miner::get_borrow_reward_type(), 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::obligation::id(arg0), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(v3), arg5);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg6),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0x3436082c5f5ea26d56262cfc1da15b94b3ba2cbb2c409323ad4d6c049af9b6c3::obligation::id(arg0),
            asset        : 0x1::type_name::get<T1>(),
            amount       : arg3,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg6)
    }

    // decompiled from Move bytecode v6
}

