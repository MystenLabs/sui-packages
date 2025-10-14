module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_index: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::ObligationOwnerCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::ensure_version_matches<T0>(arg1);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::handle_borrow<T0, T1>(arg1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0), arg3, arg2, arg4, arg5, v0);
        let v3 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg6),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0),
            asset        : 0x1::type_name::get<T1>(),
            amount       : arg3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v3);
        0x2::coin::from_balance<T1>(v1, arg6)
    }

    // decompiled from Move bytecode v6
}

