module 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::deepbook_actions {
    public entry fun get_market_price<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        0xdee9::clob_v2::get_market_price<T0, T1>(arg0)
    }

    public entry fun create_trading_account(arg0: &0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(0xdee9::clob_v2::create_account(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit_to_trading_account_from_vault<T0, T1>(arg0: &0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::app::AdminCap, arg1: &mut 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0xdee9::custodian_v2::AccountCap, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::withdraw_assets_for_trading_account<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg2, v0, arg5);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg2, v1, arg5);
    }

    // decompiled from Move bytecode v6
}

