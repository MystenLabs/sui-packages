module 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::deepbook_actions {
    struct LimitOrderPlacedEvent has copy, drop {
        poolId: 0x2::object::ID,
        price: u64,
        quantity: u64,
        self_matching_prevention: u8,
        is_bid: bool,
        expire_timestamp: u64,
        restriction: u8,
        sender: address,
        deepbook_account_free_token_base: u64,
        deepbook_account_free_token_quote: u64,
        deepbook_account_locked_token_base: u64,
        deepbook_account_locked_token_quote: u64,
    }

    public entry fun cancel_all_orders<T0, T1>(arg0: &0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::Vault<T0, T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>) {
        0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg1, 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::get_account_cap<T0, T1>(arg0));
    }

    public entry fun list_open_orders<T0, T1>(arg0: &0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : vector<0xdee9::clob_v2::Order> {
        0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::get_account_cap<T0, T1>(arg0))
    }

    public entry fun place_limit_order<T0, T1>(arg0: &mut 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::Vault<T0, T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: bool, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::is_address_whitelisted_for_trading<T0, T1>(arg0, 0x2::tx_context::sender(arg10)), 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::error::address_not_whitelisted());
        let v0 = 0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::get_account_cap<T0, T1>(arg0);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10);
        let (v5, v6, v7, v8) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, v0);
        let v9 = LimitOrderPlacedEvent{
            poolId                              : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            price                               : arg3,
            quantity                            : arg4,
            self_matching_prevention            : arg5,
            is_bid                              : arg6,
            expire_timestamp                    : arg7,
            restriction                         : arg8,
            sender                              : 0x2::tx_context::sender(arg10),
            deepbook_account_free_token_base    : v5,
            deepbook_account_free_token_quote   : v7,
            deepbook_account_locked_token_base  : v6,
            deepbook_account_locked_token_quote : v8,
        };
        0x2::event::emit<LimitOrderPlacedEvent>(v9);
    }

    public entry fun get_account_assets<T0, T1>(arg0: &0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0x233c75468318d22f41d22a4e9b92068a3bd46f8cbd2d0b7072cfce165512556d::vault::get_deepbook_account_assets<T0, T1>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

