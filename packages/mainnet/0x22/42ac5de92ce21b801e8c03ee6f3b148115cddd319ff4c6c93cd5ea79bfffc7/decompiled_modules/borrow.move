module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::ObligationOwnerCap, arg1: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg2: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg6),
            market     : 0x1::type_name::get<T0>(),
            obligation : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::id(arg0),
            asset      : 0x1::type_name::get<T1>(),
            amount     : arg3,
            time       : v0,
        };
        0x2::event::emit<BorrowEvent>(v1);
        0x2::coin::from_balance<T1>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::handle_borrow<T0, T1>(arg1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::obligation::id(arg0), arg3, arg2, arg4, arg5, v0), arg6)
    }

    // decompiled from Move bytecode v6
}

