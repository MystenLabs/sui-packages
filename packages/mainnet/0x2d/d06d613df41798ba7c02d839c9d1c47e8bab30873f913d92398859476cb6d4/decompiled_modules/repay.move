module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::error::whitelist_error());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::accrue_all_interests(arg1, v0);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::accrue_interests(arg0, arg1);
        let (v2, _) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::debt(arg0, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg2));
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::handle_repay<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v4, arg4)));
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::handle_inflow<T0>(arg1, v4, v0);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::decrease_debt(arg0, v1, v4);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg4),
            obligation : 0x2::object::id<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::obligation::Obligation>(arg0),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

