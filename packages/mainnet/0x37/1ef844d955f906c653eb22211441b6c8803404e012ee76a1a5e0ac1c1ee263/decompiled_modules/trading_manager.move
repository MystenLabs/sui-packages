module 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::trading_manager {
    struct LimitOrderPlacedEvent has copy, drop {
        vaultId: 0x2::object::ID,
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

    public entry fun batch_cancel_order<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: vector<u64>, arg4: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg4);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xdee9::clob_v2::batch_cancel_order<T0, T1>(arg2, arg3, 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_account_cap<T0, T1, T2>(arg1));
    }

    public entry fun cancel_all_orders<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg3);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg2, 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_account_cap<T0, T1, T2>(arg1));
    }

    public entry fun cancel_order<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg4);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xdee9::clob_v2::cancel_order<T0, T1>(arg2, arg3, 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_account_cap<T0, T1, T2>(arg1));
    }

    public fun list_open_orders<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : vector<0xdee9::clob_v2::Order> {
        0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_account_cap<T0, T1, T2>(arg0))
    }

    public entry fun place_limit_order<T0, T1, T2>(arg0: &mut 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg8);
        assert!(0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::is_address_whitelisted_for_trading<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg10)), 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::error::address_not_whitelisted());
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::assert_vault_state_is_active<T0, T1, T2>(arg0);
        let v0 = 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_account_cap<T0, T1, T2>(arg0);
        let (v1, v2, v3, v4) = 0xdee9::clob_v2::account_balance<T0, T1>(arg1, v0);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg1, 69420, arg2, arg3, arg4, arg5, arg6, arg7, arg9, v0, arg10);
        let v9 = LimitOrderPlacedEvent{
            vaultId                             : 0x2::object::id<0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>>(arg0),
            poolId                              : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            price                               : arg2,
            quantity                            : arg3,
            self_matching_prevention            : arg4,
            is_bid                              : arg5,
            expire_timestamp                    : arg6,
            restriction                         : arg7,
            sender                              : 0x2::tx_context::sender(arg10),
            deepbook_account_free_token_base    : v1,
            deepbook_account_free_token_quote   : v3,
            deepbook_account_locked_token_base  : v2,
            deepbook_account_locked_token_quote : v4,
        };
        0x2::event::emit<LimitOrderPlacedEvent>(v9);
    }

    public fun get_account_assets<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::get_deepbook_account_assets<T0, T1, T2>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

