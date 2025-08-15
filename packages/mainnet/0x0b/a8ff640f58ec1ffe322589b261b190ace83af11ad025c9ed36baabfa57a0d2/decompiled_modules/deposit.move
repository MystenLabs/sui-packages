module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = DepositEvent{
            minter         : 0x2::tx_context::sender(arg4),
            market         : 0x1::type_name::get<T0>(),
            obligation     : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0),
            deposit_asset  : 0x1::type_name::get<T1>(),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            ctoken_amount  : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_mint<T0, T1>(arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0), arg2, v0),
            time           : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

