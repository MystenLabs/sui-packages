module 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::deepbook_actions {
    struct DepositsSettledEvent has copy, drop {
        vaultId: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        sender: address,
        deepbook_account_free_token_base: u64,
        deepbook_account_free_token_quote: u64,
        deepbook_account_locked_token_base: u64,
        deepbook_account_locked_token_quote: u64,
    }

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

    public entry fun get_market_price<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        0xdee9::clob_v2::get_market_price<T0, T1>(arg0)
    }

    public entry fun place_limit_order<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: bool, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &0xdee9::custodian_v2::AccountCap, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v4, v5, v6, v7) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, arg10);
        let v8 = LimitOrderPlacedEvent{
            poolId                              : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            price                               : arg3,
            quantity                            : arg4,
            self_matching_prevention            : arg5,
            is_bid                              : arg6,
            expire_timestamp                    : arg7,
            restriction                         : arg8,
            sender                              : 0x2::tx_context::sender(arg11),
            deepbook_account_free_token_base    : v4,
            deepbook_account_free_token_quote   : v6,
            deepbook_account_locked_token_base  : v5,
            deepbook_account_locked_token_quote : v7,
        };
        0x2::event::emit<LimitOrderPlacedEvent>(v8);
    }

    public entry fun create_trading_account(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(0xdee9::clob_v2::create_account(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit_to_trading_account_from_vault<T0, T1>(arg0: &0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::app::AdminCap, arg1: &mut 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0xdee9::custodian_v2::AccountCap, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::withdraw_assets_for_trading_account<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg2, v0, arg5);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg2, v1, arg5);
        let (v2, v3, v4, v5) = 0xdee9::clob_v2::account_balance<T0, T1>(arg2, arg5);
        let v6 = DepositsSettledEvent{
            vaultId                             : 0x2::object::id<0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::vault::Vault<T0, T1>>(arg1),
            base_amount                         : arg3,
            quote_amount                        : arg4,
            sender                              : 0x2::tx_context::sender(arg6),
            deepbook_account_free_token_base    : v2,
            deepbook_account_free_token_quote   : v4,
            deepbook_account_locked_token_base  : v3,
            deepbook_account_locked_token_quote : v5,
        };
        0x2::event::emit<DepositsSettledEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

