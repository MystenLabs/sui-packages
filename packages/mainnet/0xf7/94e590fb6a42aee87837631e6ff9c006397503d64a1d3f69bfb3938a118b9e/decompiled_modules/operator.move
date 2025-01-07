module 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::operator {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct InitializeDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CustodianDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeCollectorDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun assert_in_emergency(arg0: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool) {
        assert!(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::is_emergency(arg0), 1);
    }

    fun assert_not_emergency(arg0: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool) {
        assert!(!0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::is_emergency(arg0), 2);
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut 0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(arg0, v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(arg0);
    }

    public fun borrow_staked_token_custodian<T0>(arg0: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64) : &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::Custodian<T0> {
        let v0 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<CustodianDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::Custodian<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_pool_registry(arg0), arg1)), v0)
    }

    entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        create_pool_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun create_pool_internal<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::create_pool(arg1, arg3, arg4);
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(&mut v0), v1, 1);
        let v2 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::add<CustodianDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::Custodian<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(&mut v0), v2, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::new<T0>());
        let v3 = FeeCollectorDfKey{dummy_field: false};
        0x2::dynamic_field::add<FeeCollectorDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::FeeCollector<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(&mut v0), v3, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::new<T0>(arg2, arg4));
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::increase_alloc_point(arg0, arg1);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::register(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg0), v0);
    }

    fun decrease_for<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::decrease(arg1, arg2, arg3);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::decrease_staked_amount(arg0, arg2);
        let v0 = CustodianDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::withdraw<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::Custodian<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(arg0), v0), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun decrease_position<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: u64, arg3: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg4: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg5: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg6: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry_and_position_registry_and_minter(arg0);
        let v4 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(v0, arg1);
        let v5 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(v4);
        assert_version_and_upgrade(v5);
        assert_not_emergency(v4);
        let v6 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg8));
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::update_pool(v4, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::total_alloc_point(arg0), 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::ostr_per_ms(arg0), arg7);
        if (0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::value(v6) > 0) {
            distribute_pending_rewards(v4, v6, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::pearl_ratio(arg0), arg3, arg4, v2, arg5, arg6, v3, arg8);
        };
        if (arg2 > 0) {
            decrease_for<T0>(v4, v6, arg2, arg8);
        };
        recalc_reward_debts(v4, v6);
    }

    entry fun decrease_position_emergency<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _) = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry_and_position_registry_and_minter(arg0);
        let v4 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(v0, arg1);
        let v5 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(v4);
        assert_version_and_upgrade(v5);
        assert_in_emergency(v4);
        let v6 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg2));
        let v7 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::value(v6);
        if (v7 > 0) {
            decrease_for<T0>(v4, v6, v7, arg2);
        };
    }

    fun distribute_pending_rewards(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool, arg1: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::Position, arg2: u64, arg3: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg4: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg5: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg6: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg7: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg8: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::calc_pending_rewards(arg0, arg1);
        if (v1 > 0) {
            let v2 = v1 * arg2 / 100;
            let v3 = v1 - v2;
            if (v2 > 0) {
                0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::mint_and_transfer(arg6, arg7, arg8, v0, v2, arg9);
            };
            if (v3 > 0) {
                0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr::mint(arg3, arg4, arg5, v0, v3);
            };
        };
    }

    fun increase_for<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::increase(arg1, v0, arg3);
        let v1 = CustodianDfKey{dummy_field: false};
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::deposit<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::custodian::Custodian<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(arg0), v1), arg2);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::increase_staked_amount(arg0, v0);
    }

    entry fun increase_position<T0>(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg4: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg5: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg6: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2, v3, v4) = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry_and_position_registry_and_minter(arg0);
        let v5 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(v1, arg1);
        let v6 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(v5);
        assert_version_and_upgrade(v6);
        assert_not_emergency(v5);
        if (!0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::is_registerd(v2, arg1, v0)) {
            0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::register(v2, arg1, v0, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::new(arg1, arg8));
        };
        let v7 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::borrow_mut_position(v2, arg1, v0);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::update_pool(v5, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::total_alloc_point(arg0), 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::ostr_per_ms(arg0), arg7);
        if (0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::value(v7) > 0) {
            distribute_pending_rewards(v5, v7, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::pearl_ratio(arg0), arg3, arg4, v3, arg5, arg6, v4, arg8);
        };
        let v8 = 0x2::coin::value<T0>(&arg2);
        if (v8 > 0) {
            let v9 = FeeCollectorDfKey{dummy_field: false};
            let v10 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::fee_amount<T0>(0x2::dynamic_field::borrow<FeeCollectorDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::FeeCollector<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid(v5), v9), v8);
            if (v10 > 0) {
                let v11 = FeeCollectorDfKey{dummy_field: false};
                0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::deposit<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::FeeCollector<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(v5), v11), 0x2::coin::split<T0>(&mut arg2, v10, arg8));
            };
            increase_for<T0>(v5, v7, arg2, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        recalc_reward_debts(v5, v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mass_update_pool(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::num_pools(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_pool_registry(arg0))) {
            let v1 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg0), v0);
            let v2 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(v1);
            assert_version_and_upgrade(v2);
            0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::update_pool(v1, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::total_alloc_point(arg0), 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::ostr_per_ms(arg0), arg1);
            v0 = v0 + 1;
        };
    }

    fun recalc_reward_debts(arg0: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::Pool, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::Position) {
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::change_reward_debt(arg1, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::calc_rewards_for(arg0, arg1));
    }

    public entry fun set_alloc_point(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        set_alloc_point_interanl(arg1, arg2, arg3, arg4);
    }

    fun set_alloc_point_interanl(arg0: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg0), arg1);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::set_alloc_point(v0, arg2);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::decrease_alloc_point(arg0, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::alloc_point(v0));
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::increase_alloc_point(arg0, arg2);
    }

    entry fun set_fee_rate<T0>(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg2: u64, arg3: u64) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::change_fee<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::FeeCollector<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3);
    }

    entry fun set_ostr_per_ms(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg1, arg3);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::set_ostr_per_ms(arg1, arg2);
    }

    entry fun setup(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = InitializeDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<InitializeDfKey>(&arg0.id, v0), 1000);
        let v1 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::new(arg3);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::set_ostr_per_ms(&mut v1, arg1);
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::set_pearl_ratio(&mut v1, arg2);
        let v2 = InitializeDfKey{dummy_field: false};
        0x2::dynamic_field::add<InitializeDfKey, bool>(&mut arg0.id, v2, true);
        0x2::transfer::public_share_object<0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State>(v1);
    }

    public entry fun stop_reward(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State) {
        let v0 = 0;
        while (v0 < 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::num_pools(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_pool_registry(arg1))) {
            0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::set_emergency(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg1), v0));
            v0 = v0 + 1;
        };
        0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::set_ostr_per_ms(arg1, 0);
    }

    entry fun withdraw_fee<T0>(arg0: &AdminCap, arg1: &mut 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::withdraw<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fee_collector::FeeCollector<T0>>(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::uid_mut(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_mut_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

