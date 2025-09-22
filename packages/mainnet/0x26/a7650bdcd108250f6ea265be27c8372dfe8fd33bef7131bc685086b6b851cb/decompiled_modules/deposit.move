module 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::ObligationOwnerCap, arg1: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::ensure_version_matches<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = DepositEvent{
            minter         : 0x2::tx_context::sender(arg4),
            market         : 0x1::type_name::get<T0>(),
            obligation     : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::id(arg0),
            deposit_asset  : 0x1::type_name::get<T1>(),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            ctoken_amount  : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::handle_mint<T0, T1>(arg1, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::obligation::id(arg0), arg2, v0),
            time           : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

