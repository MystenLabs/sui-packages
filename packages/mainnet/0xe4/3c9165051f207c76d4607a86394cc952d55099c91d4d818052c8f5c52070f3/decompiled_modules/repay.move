module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::Version, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg2: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::assert_current_version(arg0);
        assert!(0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::is_address_allowed(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg2), 0x2::tx_context::sender(arg5)), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::whitelist_error());
        assert!(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::repay_locked(arg1) == false, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::accrue_all_interests(arg2, v0);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::debt(arg1, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg3));
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::handle_repay<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v4, arg5)));
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::handle_inflow<T0>(arg2, v4, v0);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

