module 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::interface {
    public fun add_yield<T0, T1>(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: 0x2::coin::Coin<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::add_yield<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun admin_cancel_twap_order<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::user_cancel_twap_order<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun admin_delete_stop_order_ticket<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::user_delete_stop_order_ticket<T0, T1>(arg0, arg2, arg3, arg4)
    }

    public fun admin_pause_vault<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_is_active_package_pause_guardian_cap(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::admin_pause_vault<T0, T1>(arg0);
    }

    public fun admin_pause_vault_for_force_withdraw<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0x2::clock::Clock, arg4: address) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_is_active_package_maintenance_cap(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::admin_pause_vault_for_force_withdraw<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_set_max_markets_in_vault<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::admin_set_max_markets_in_vault<T0, T1>(arg0, arg3);
    }

    public fun admin_start_force_withdraw_session_for_address<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_is_active_package_maintenance_cap(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_force_withdraw_session<T0, T1>(arg0, arg3, arg4, arg5, arg6)
    }

    public fun admin_unpause_vault<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_is_active_package_pause_guardian_cap(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::admin_unpause_vault<T0, T1>(arg0);
    }

    public fun allocate_collateral_to_position<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::allocate_collateral_to_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &vector<u128>, arg5: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::cancel_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun cancel_twap_order<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::cancel_twap_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun clip_force_withdraw_delay<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_force_withdraw_delay<T0, T1>(arg0, arg2);
    }

    public fun clip_lock_period<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_lock_period<T0, T1>(arg0, arg2);
    }

    public fun clip_max_markets_in_vault<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_max_markets_in_vault<T0, T1>(arg0, arg2);
    }

    public fun clip_max_pending_orders_per_position<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_max_pending_orders_per_position<T0, T1>(arg0, arg2);
    }

    public fun clip_min_owner_lock_usd<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_min_owner_lock_usd<T0, T1>(arg0, arg2);
    }

    public fun clip_owner_fee_rate<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::clip_owner_fee_rate<T0, T1>(arg0, arg2);
    }

    public fun close_position_at_settlement_prices<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &vector<u128>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::close_position_at_settlement_prices<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun create_market_position<T0, T1, T2>(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::create_market_position<T0, T1>(arg0, arg2, arg3);
    }

    public fun create_package_assistant_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::create_package_assistant_cap_(arg0, arg1, arg2)
    }

    public fun create_package_maintenance_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::create_package_maintenance_cap_(arg0, arg1, arg2)
    }

    public fun create_package_pause_guardian_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::create_package_pause_guardian_cap_(arg0, arg1, arg2)
    }

    public fun create_stop_order_ticket<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg4: vector<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::create_stop_order_ticket<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun create_twap_order_ticket<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: vector<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::create_twap_order_ticket<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_vault<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::coin_registry::CoinRegistry, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg7: u64, arg8: u256, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::option::Option<0x1::ascii::String>, arg14: 0x1::option::Option<0x1::ascii::String>, arg15: 0x1::option::Option<0x1::ascii::String>, arg16: 0x1::option::Option<vector<0x1::ascii::String>>, arg17: 0x1::option::Option<vector<0x1::ascii::String>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public fun create_withdraw_request<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::create_withdraw_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun deallocate_collateral_from_position<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::deallocate_collateral_from_position<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun delete_stop_order_ticket<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::delete_stop_order_ticket<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun edit_stop_order_ticket_details<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::edit_stop_order_ticket_details<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun edit_stop_order_ticket_executors<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::edit_stop_order_ticket_executors<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun edit_twap_order_ticket_details<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::edit_twap_order_ticket_details<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun edit_twap_order_ticket_executors<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::edit_twap_order_ticket_executors<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun end_deposit_session<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::DepositSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_deposit_session_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::end_deposit_session<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun end_perpetuals_session<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionHotPotato<T1>, arg4: bool, arg5: bool) : 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::end_perpetuals_session<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun end_withdraw_session<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_withdraw_session_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::end_withdraw_session<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_withdraw_session_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun execute_twap_order<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg7: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::twap_orders::TWAPOrderDetails, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::execute_twap_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun finalize_twap_order<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::twap_orders::TWAPOrderDetails, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::finalize_twap_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun join<T0>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::join_user_lp_coin<T0>(arg0, arg1, arg2);
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: &vector<u128>, arg8: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::liquidate<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun new_vault_assistant_cap<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::new_vault_assistant_cap<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun new_vault_treasury_cap<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::new_vault_treasury_cap<T0, T1>(arg0, arg1, arg2)
    }

    public fun pause_vault_for_force_withdraw<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::pause_vault_for_force_withdraw<T0, T1>(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun place_limit_order<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: bool, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg14: &0x2::clock::Clock, arg15: &0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, 0x1::option::Option<u128>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::place_limit_order<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun place_market_order<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: bool, arg7: u64, arg8: bool, arg9: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::place_market_order<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun place_stop_order_sltp<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: u8, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::place_stop_order_sltp<T0, T1>(arg0, arg1, arg2, arg3, arg17, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg18)
    }

    public fun place_stop_order_standalone<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: 0x2::object::ID, arg5: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: u8, arg9: u256, arg10: bool, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: vector<u8>, arg17: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::place_stop_order_standalone<T0, T1>(arg0, arg1, arg2, arg3, arg18, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg19)
    }

    public fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::DepositSession<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_deposit_session_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::process_clearing_house_for_deposit<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: &vector<u128>, arg6: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_withdraw_session_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::process_clearing_house_for_force_withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun process_clearing_house_for_withdraw<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_withdraw_session_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_withdraw_session_cap_has_authority<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::process_clearing_house_for_withdraw<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun reconcile_clearing_house<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::reconcile_clearing_house<T0, T1>(arg0, arg2, arg3);
    }

    public fun remove_withdraw_request<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::remove_withdraw_request<T0, T1>(arg0, arg1)
    }

    public fun resume_vault_for_force_withdraw<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::resume_vault_for_force_withdraw<T0, T1>(arg0, arg1);
    }

    public fun revoke_package_assistant_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::revoke_package_assistant_cap_(arg0, arg1, arg2);
    }

    public fun revoke_package_maintenance_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::revoke_package_maintenance_cap_(arg0, arg1, arg2);
    }

    public fun revoke_package_pause_guardian_cap(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::revoke_package_pause_guardian_cap_(arg0, arg1, arg2);
    }

    public fun revoke_vault_assistant_cap<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::revoke_vault_assistant_cap<T0, T1>(arg0, arg1, arg2);
    }

    public fun revoke_vault_treasury_cap<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::revoke_vault_treasury_cap<T0, T1>(arg0, arg1, arg2);
    }

    entry fun set_collateral_pfs_info<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_collateral_pfs_info<T0, T1>(arg0, arg3);
    }

    entry fun set_collateral_pfs_tolerance<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_collateral_pfs_tolerance<T0, T1>(arg0, arg3);
    }

    public fun set_curator_logo_url<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_curator_logo_url<T0>(arg0, arg4);
    }

    public fun set_curator_name<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_curator_name<T0>(arg0, arg4);
    }

    public fun set_curator_url<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_curator_url<T0>(arg0, arg4);
    }

    public fun set_deposit_session_sender<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::DepositSession<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: address) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_deposit_session_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_deposit_session_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_deposit_session_sender<T0, T1>(arg0, arg3);
    }

    public fun set_description<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_description<T0>(arg0, arg4);
    }

    public fun set_extra_field<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_extra_field<T0>(arg0, arg4, arg5);
    }

    public fun set_force_withdraw_delay<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_force_withdraw_delay<T0, T1>(arg0, arg2, arg3);
    }

    public fun set_lock_period<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_lock_period<T0, T1>(arg0, arg2, arg3);
    }

    entry fun set_max_force_withdraw_mr_tolerance<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u256) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_max_force_withdraw_mr_tolerance<T0, T1>(arg0, arg2, arg3);
    }

    public fun set_max_pending_orders_per_position<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_max_pending_orders_per_position<T0, T1>(arg0, arg2, arg3);
    }

    public fun set_max_total_deposited_collateral<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_max_total_deposited_collateral<T0, T1>(arg0, arg2);
    }

    entry fun set_min_force_withdraw_position_usd<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u256) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_min_force_withdraw_position_usd<T0, T1>(arg0, arg3);
    }

    entry fun set_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u64) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0, arg3);
    }

    public fun set_name<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::VaultMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg4: 0x1::ascii::String) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg3, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::metadata::set_name<T0>(arg0, arg4);
    }

    public fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_new_withdraw_request_slippage<T0, T1>(arg0, arg1, arg2);
    }

    public fun set_owner_fee_rate<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: u256) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg2);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::set_owner_fee_rate<T0, T1>(arg0, arg2, arg3);
    }

    public fun set_position_initial_margin_ratio<T0, T1, T2>(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: u256) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::set_position_initial_margin_ratio<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun split<T0>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0>, arg1: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::split_user_lp_coin<T0>(arg0, arg1, arg2, arg3)
    }

    public fun start_deposit_session<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::DepositSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_package_version(arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_deposit_session<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun start_force_withdraw_session<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_force_withdraw_session<T0, T1>(arg0, arg1, arg2, 0x2::tx_context::sender(arg4), arg3)
    }

    public fun start_owner_locked_withdraw_session<T0, T1>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(&arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_owner_locked_withdraw_session<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun start_owner_process_withdraw_request<T0, T1, T2>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: address, arg5: &0x2::clock::Clock) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(&arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_owner_process_withdraw_request<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun start_owner_withdraw_session<T0, T1, T2>(arg0: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::UserLpCoin<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::WithdrawSession<T0, T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(&arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(&arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::start_owner_withdraw_session<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun start_perpetuals_session<T0, T1, T2>(arg0: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionHotPotato<T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::start_perpetuals_session<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun try_cancel_orders<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, T2>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T1>, arg3: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T1>, arg4: &vector<u128>, arg5: &0x2::clock::Clock) : vector<bool> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_authority_cap_is_valid<T0, T1, T2>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::perpetuals_api::try_cancel_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    entry fun upgrade_vault_version<T0, T1, T2>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T2>, arg2: &0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::Config) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::assert_authority_cap_is_valid<T2>(arg2, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::upgrade_vault_version<T0, T1>(arg0);
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::Vault<T0, T1>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::VAULT<T0>, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::TREASURY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_package_version<T0, T1>(arg0);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::assert_vault_treasury_cap_is_valid<T0, T1>(arg0, arg1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::vault::withdraw_fees<T0, T1>(arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

