module 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::admin {
    public entry fun disable_buying<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_base<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_quote<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_selling<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_trading<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, false);
    }

    public entry fun enable_buying<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_base<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_quote<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_selling<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_trading<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, true);
    }

    public entry fun grant_liquidity_operator_cap<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::grant_liquidity_operator_cap<T0, T1>(arg1, arg2);
    }

    public entry fun grant_pool_admin_cap<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::assert_version(arg0);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::grant_pool_admin_cap<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_balance_limit<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_base_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_usd_price_age<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_base_usd_price_age<T0, T1>(arg1, arg2);
    }

    public entry fun set_k<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_liquidity_provider_fee_rate<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_liquidity_provider_fee_rate<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_maintainer<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: address) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_maintainer<T0, T1>(arg1, arg2);
    }

    public entry fun set_protocol_fee_rate<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_protocol_fee_rate<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_quote_balance_limit<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_quote_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_usd_price_age<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::set_quote_usd_price_age<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

