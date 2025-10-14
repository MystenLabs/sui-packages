module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::ObligationOwnerCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::ensure_version_matches<T0>(arg1);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = DepositEvent{
            minter         : 0x2::tx_context::sender(arg4),
            market         : 0x1::type_name::get<T0>(),
            obligation     : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0),
            deposit_asset  : 0x1::type_name::get<T1>(),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            ctoken_amount  : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::handle_mint<T0, T1>(arg1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0), arg2, v0),
            time           : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

