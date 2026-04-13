module 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::admin {
    fun assert_valid_k_deviation_tiers(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1);
        assert!(v0 > 0, 2);
        let v1 = 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::get_one();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            assert!(v3 > 0 && v3 < v1, 3);
            let v4 = *0x1::vector::borrow<u64>(arg1, v2);
            assert!(v4 > 0 && v4 <= v1, 4);
            if (v2 > 0) {
                assert!(v4 > 0, 5);
            };
            v2 = v2 + 1;
        };
    }

    public entry fun disable_all<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, false);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, false);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, false);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, false);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_buying<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_base<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_deposit_quote<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_selling<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, false);
    }

    public entry fun disable_trading<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, false);
    }

    public entry fun enable_all<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, true);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, true);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, true);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, true);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_buying<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_buying_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_base<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_base_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_deposit_quote<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_deposit_quote_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_selling<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_selling_allowed<T0, T1>(arg1, true);
    }

    public entry fun enable_trading<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_trade_allowed<T0, T1>(arg1, true);
    }

    public entry fun grant_liquidity_operator_cap<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::grant_liquidity_operator_cap<T0, T1>(arg1, arg2);
    }

    public entry fun grant_pool_admin_cap<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::assert_version(arg0);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::grant_pool_admin_cap<T0, T1>(arg1, arg2);
    }

    public entry fun grant_robot_cap<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::grant_robot_cap<T0, T1>(arg1, arg2);
    }

    public entry fun remove_base_k_config<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::remove_base_k_config<T0, T1>(arg1, arg2);
    }

    public entry fun remove_base_k_config_for_robot<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::RobotCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::remove_base_k_config<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_balance_limit<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_base_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_base_k_config<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_base_k_config<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_base_k_config_for_robot<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::RobotCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_base_k_config<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_base_price_feed_id_pro<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_base_price_feed_id_pro<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_base_usd_price_age<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_base_usd_price_age<T0, T1>(arg1, arg2);
    }

    public entry fun set_k<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_k_deviation_tiers<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_k_deviation_tiers(&arg2, &arg3);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_k_tiers<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_k_deviation_tiers_for_robot<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::RobotCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: vector<u64>, arg3: vector<u64>) {
        assert_valid_k_deviation_tiers(&arg2, &arg3);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_k_tiers<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_k_for_robot<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::RobotCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_maintainer<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: address) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_maintainer<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_balance_limit<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_not_closed<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_quote_balance_limit<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_usd_price<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::RobotCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_quote_usd_price<T0, T1>(arg1, arg2);
    }

    public entry fun set_quote_usd_price_bounds<T0, T1>(arg0: &0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle_driven_pool::set_quote_usd_price_bounds<T0, T1>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

