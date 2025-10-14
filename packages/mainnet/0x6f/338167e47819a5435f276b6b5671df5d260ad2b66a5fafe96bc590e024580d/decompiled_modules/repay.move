module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_index: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        refund: u64,
        time: u64,
    }

    public fun repay<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::ObligationOwnerCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = repay_coin_refund<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
        };
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::ObligationOwnerCap, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::ensure_version_matches<T0>(arg1);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let (v1, v2) = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::handle_repay<T0, T1>(arg1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0), arg2, v0, arg4);
        let v3 = v1;
        let v4 = RepayEvent{
            repayer      : 0x2::tx_context::sender(arg4),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::obligation::id(arg0),
            asset        : 0x1::type_name::get<T1>(),
            amount       : 0x2::coin::value<T1>(&arg2),
            borrow_index : v2,
            refund       : 0x2::coin::value<T1>(&v3),
            time         : v0,
        };
        0x2::event::emit<RepayEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

