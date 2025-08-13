module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::ObligationOwnerCap, arg1: &mut 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::Market<T0>, arg2: &0x15afa87bdbd8f62f6523e369f23983ad97a07630c16a71b942c0023396813d87::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg6),
            market     : 0x1::type_name::get<T0>(),
            obligation : 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::id(arg0),
            asset      : 0x1::type_name::get<T1>(),
            amount     : arg3,
            time       : v0,
        };
        0x2::event::emit<BorrowEvent>(v1);
        0x2::coin::from_balance<T1>(0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::market::handle_borrow<T0, T1>(arg1, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::obligation::id(arg0), arg3, arg2, arg4, arg5, v0), arg6)
    }

    // decompiled from Move bytecode v6
}

