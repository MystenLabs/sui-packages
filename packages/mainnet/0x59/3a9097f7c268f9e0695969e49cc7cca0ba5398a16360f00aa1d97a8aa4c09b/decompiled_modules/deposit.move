module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::ObligationOwnerCap, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::ensure_version_matches<T0>(arg1);
        assert!(!0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::has_circuit_break_triggered<T0>(arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = DepositEvent{
            minter         : 0x2::tx_context::sender(arg4),
            market         : 0x1::type_name::get<T0>(),
            obligation     : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::id(arg0),
            deposit_asset  : 0x1::type_name::get<T1>(),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            ctoken_amount  : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::handle_mint<T0, T1>(arg1, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::id(arg0), arg2, v0),
            time           : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

