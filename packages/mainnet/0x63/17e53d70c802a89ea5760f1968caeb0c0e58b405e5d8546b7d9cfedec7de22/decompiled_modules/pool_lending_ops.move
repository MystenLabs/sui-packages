module 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool_lending_ops {
    entry fun admin_abandon_lending_position<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_registry_version(arg1);
        assert!(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::is_paused<T0, T1>(arg2), 417);
        let (v0, v1) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg2);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::abandon_position<T0, T1>(v0, v1, arg3, 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg2), arg4, 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::protocol_fee_recipient(arg1));
    }

    entry fun admin_claim_external_reward<T0, T1, T2>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_collect_allowed<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T2>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_pool_asset<T0, T1, T2>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_registry_version(arg1);
        let v0 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg2);
        let v1 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg2);
        if (!0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v1)) {
            0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::collect_external_reward<T2>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg2), arg3, v0, arg4, arg5);
        };
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<T2>(0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::claim_external_reward<T2>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg2), v0, arg5), 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::protocol_fee_recipient(arg1));
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_reserve_solvency<T0, T1>(arg2);
    }

    entry fun admin_claim_external_reward_sui<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_collect_allowed<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_pool_asset<T0, T1, 0x2::sui::SUI>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_registry_version(arg1);
        let v0 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg2);
        let v1 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg2);
        if (!0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v1)) {
            0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::collect_external_reward_sui(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg2), arg3, v0, arg4, arg5, arg6);
        };
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<0x2::sui::SUI>(0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::claim_external_reward<0x2::sui::SUI>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg2), v0, arg6), 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::protocol_fee_recipient(arg1));
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_reserve_solvency<T0, T1>(arg2);
    }

    entry fun admin_claim_protocol_yield<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_collect_allowed<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T0>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T1>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_registry_version(arg1);
        let v0 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::protocol_fee_recipient(arg1);
        let v1 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg2);
        let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg2);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v2, v3, arg3, v1, arg4);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg2);
        let (v4, v5) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg2);
        let (v6, v7) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::claim_protocol_yield<T0, T1>(v4, v5, arg3, v1, arg4, arg5);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<T0>(v6, v0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<T1>(v7, v0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_reserve_solvency<T0, T1>(arg2);
    }

    entry fun admin_claim_protocol_yield_x_sui<T0>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<0x2::sui::SUI, T0>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<0x2::sui::SUI, T0>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_collect_allowed<0x2::sui::SUI, T0>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T0>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_registry_version(arg1);
        let v0 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::protocol_fee_recipient(arg1);
        let v1 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<0x2::sui::SUI, T0>>(arg2);
        let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<0x2::sui::SUI, T0>(arg2);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<0x2::sui::SUI, T0>(v2, v3, arg3, v1, arg5);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<0x2::sui::SUI, T0>(arg2);
        let (v4, v5) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<0x2::sui::SUI, T0>(arg2);
        let (v6, v7) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::claim_protocol_yield_x_sui<T0>(v4, v5, arg3, v1, arg4, arg5, arg6);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<0x2::sui::SUI, T0>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<0x2::sui::SUI>(v6, v0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pay_recipient<T0>(v7, v0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_reserve_solvency<0x2::sui::SUI, T0>(arg2);
    }

    entry fun admin_configure_lending<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::PoolLendingConfig, arg4: &0x2::clock::Clock) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg1);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg1);
        let v0 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg1);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::assert_protocol(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_ref<T0, T1>(arg1), arg2);
        let (v1, v2) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg1);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v1, v2, arg2, v0, arg4);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::assert_enabled_markets_exist(arg2, &arg3);
        let (v3, v4) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg1);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::update_config<T0, T1>(v3, v4, v0, arg3);
    }

    entry fun admin_init_lending<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg1);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg1);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::init_lending(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg1), arg2, 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg1), 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::config_snapshot(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_ref<T0, T1>(arg1)), arg3);
    }

    entry fun admin_re_enable_lending_deploys<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg1);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg1);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::re_enable_deploys(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg1), 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg1));
    }

    public fun checkpoint_lending_value<T0, T1>(arg0: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg0);
        let v0 = if (0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::is_initialized(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_ref<T0, T1>(arg0))) {
            let v1 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg0);
            !0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v1)
        } else {
            false
        };
        if (v0) {
            let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg0);
            0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v2, v3, arg1, 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg0), arg2);
        };
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg0);
    }

    fun force_recall_internal<T0, T1>(arg0: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T0>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T1>();
        let (v0, v1) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::force_recall<T0, T1>(v0, v1, arg1, 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg0), arg2, arg3, arg4, arg5);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg0);
    }

    fun force_recall_x_sui_internal<T0>(arg0: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<0x2::sui::SUI, T0>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<0x2::sui::SUI, T0>(arg0);
        let (v0, v1) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<0x2::sui::SUI, T0>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::force_recall_x_sui<T0>(v0, v1, arg1, 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<0x2::sui::SUI, T0>>(arg0), arg2, arg3, arg4, arg5, arg6);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<0x2::sui::SUI, T0>(arg0);
    }

    entry fun keeper_deploy_lending<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg0, arg1);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg2);
        let v0 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg2);
        let v1 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg2);
        if (0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v1)) {
            return
        };
        let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg2);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v2, v3, arg3, v0, arg4);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg2);
        if (!0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::deploy_keeper_allowed<T0, T1>(arg2)) {
            return
        };
        let (v4, v5) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg2);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::auto_deploy_if_excess<T0, T1>(v4, v5, arg3, v0, arg4, arg5);
    }

    public fun lending_recall_needed<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (bool, bool) {
        (0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::is_recall_needed(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_ref<T0, T1>(arg0), 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::idle_x<T0, T1>(arg0), arg1, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deployed_x<T0, T1>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::custody_ref<T0, T1>(arg0))), 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::is_recall_needed(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_ref<T0, T1>(arg0), 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::idle_y<T0, T1>(arg0), arg2, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deployed_y<T0, T1>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::custody_ref<T0, T1>(arg0))))
    }

    entry fun operator_force_recall<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg0, arg1);
        force_recall_internal<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun operator_force_recall_x_sui<T0>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg2: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg0, arg1);
        force_recall_x_sui_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun poke<T0, T1, T2>(arg0: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_sui<T2>();
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_pool_asset<T0, T1, T2>();
        let v0 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg0);
        if (0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v0)) {
            return
        };
        let v1 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg0);
        let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v2, v3, arg1, v1, arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::collect_external_reward<T2>(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg0), arg1, v1, arg2, arg3);
    }

    entry fun poke_sui_reward<T0, T1>(arg0: &mut 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_version<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_flash_active<T0, T1>(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_not_pool_asset<T0, T1, 0x2::sui::SUI>();
        let v0 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::pool_permissions<T0, T1>(arg0);
        if (0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::perms_bypass_venue(&v0)) {
            return
        };
        let v1 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg0);
        let (v2, v3) = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_parts_mut<T0, T1>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::sync<T0, T1>(v2, v3, arg1, v1, arg3);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::maybe_distribute_lp_yield<T0, T1>(arg0);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::collect_external_reward_sui(0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::lending_mut<T0, T1>(arg0), arg1, v1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

