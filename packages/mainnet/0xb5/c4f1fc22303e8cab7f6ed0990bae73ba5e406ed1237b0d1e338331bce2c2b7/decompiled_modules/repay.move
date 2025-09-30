module 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::version::Version, arg1: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::Obligation, arg2: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::version::assert_current_version(arg0);
        assert!(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::whitelist::is_address_allowed(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::uid(arg2), 0x2::tx_context::sender(arg5)), 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::error::whitelist_error());
        assert!(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::repay_locked(arg1) == false, 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::accrue_all_interests(arg2, v0);
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::debt(arg1, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg3));
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::handle_repay<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v4, arg5)));
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::handle_inflow<T0>(arg2, v4, v0);
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

