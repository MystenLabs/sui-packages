module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::Version, arg1: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg2: &mut 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::version::assert_current_version(arg0);
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::uid(arg2), 0x2::tx_context::sender(arg5)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::whitelist_error());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::accrue_all_interests(arg2, v0);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::accrue_interests(arg1, arg2);
        let (v2, _) = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::debt(arg1, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg3));
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::handle_repay<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v4, arg5)));
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::handle_inflow<T0>(arg2, v4, v0);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

