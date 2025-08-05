module 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::admin {
    public entry fun disable_all<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, false);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, false);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, false);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, false);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_buying<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_base<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_quote<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_selling<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_trading<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, false);
    }

    public entry fun enable_all<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, true);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, true);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, true);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, true);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_buying<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_base<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_quote<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_selling<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_trading<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, true);
    }

    public entry fun grant_liquidity_operator_cap<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::grant_liquidity_operator_cap<T0, T1>(arg1, arg2);
    }

    public entry fun grant_pool_admin_cap<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::assert_version(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::grant_pool_admin_cap<T0, T1>(arg1, arg2);
    }

    public entry fun grant_robot_cap<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::grant_robot_cap<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_balance_limit<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_base_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_usd_price_age<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_base_usd_price_age<T0, T1>(arg1, arg2);
    }

    public entry fun set_k<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_k_for_robot<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::RobotCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_maintainer<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: address) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_maintainer<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_balance_limit<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_quote_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_usd_price<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::RobotCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_quote_usd_price<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

