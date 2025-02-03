module 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::Version, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg2: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::assert_current_version(arg0);
        assert!(0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::is_address_allowed(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg2), 0x2::tx_context::sender(arg5)), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::error::whitelist_error());
        assert!(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::repay_locked(arg1) == false, 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::accrue_all_interests(arg2, v0);
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::debt(arg1, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg3));
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::handle_repay<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v4, arg5)));
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::handle_inflow<T0>(arg2, v4, v0);
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

