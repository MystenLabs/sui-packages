module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_index: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::ObligationOwnerCap, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::ensure_version_matches<T0>(arg1);
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::handle_borrow<T0, T1>(arg1, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::id(arg0), arg3, arg2, arg4, arg5, v0);
        let v3 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg6),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::id(arg0),
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

