module 0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::deepbook_actions {
    struct DepositedToTradingAccountFromVaultEvent has copy, drop {
        vaultId: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        sender: address,
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
    }

    public entry fun get_market_price<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        0xdee9::clob_v2::get_market_price<T0, T1>(arg0)
    }

    public entry fun place_limit_order<T0, T1>(arg0: &0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::app::AdminCap, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: bool, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &0xdee9::custodian_v2::AccountCap, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v4 = LimitOrderPlacedEvent{
            poolId                   : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            price                    : arg3,
            quantity                 : arg4,
            self_matching_prevention : arg5,
            is_bid                   : arg6,
            expire_timestamp         : arg7,
            restriction              : arg8,
            sender                   : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<LimitOrderPlacedEvent>(v4);
    }

    public entry fun create_trading_account(arg0: &0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(0xdee9::clob_v2::create_account(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit_to_trading_account_from_vault<T0, T1>(arg0: &0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::app::AdminCap, arg1: &mut 0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0xdee9::custodian_v2::AccountCap, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::vault::withdraw_assets_for_trading_account<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg2, v0, arg5);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg2, v1, arg5);
        let v2 = DepositedToTradingAccountFromVaultEvent{
            vaultId      : 0x2::object::id<0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::vault::Vault<T0, T1>>(arg1),
            base_amount  : arg3,
            quote_amount : arg4,
            sender       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DepositedToTradingAccountFromVaultEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

