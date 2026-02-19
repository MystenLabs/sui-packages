module 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::vault {
    public fun add_extension<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::add_extension<T0, T1, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, arg1, arg3, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key(), 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::new(arg4), true);
    }

    public fun remove_extension<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::destroy(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::remove_extension<T0, T1, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, arg1, arg3, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()));
    }

    public fun convert_staked_sui_to_fungible_staked_sui_for_pool_id<T0>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg1);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg2);
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::convert_staked_sui_to_fungible_staked_sui_for_pool_id(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg3, arg4, arg5);
    }

    public fun deposit_into_extension_validator_preference<T0>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>) : address {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::deposit_into_extension_validator_preference(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()))
    }

    public fun disable_deposits<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::disable_deposits(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()));
    }

    public fun enable_deposits<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::enable_deposits(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()));
    }

    public fun set_deposit_into_extension_validator_preference<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: address) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::set_deposit_into_extension_validator_preference(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg4, arg5);
    }

    public fun take_profit<T0>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::add_profit<T0, 0x2::sui::SUI>(arg0, arg2, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::take_profit(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg3, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::active_liquidity_of_type_in_extension<T0, 0x2::sui::SUI>(arg0, &v0), arg5), arg4);
    }

    public fun total_active_liquidity<T0>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : u64 {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::total_active_liquidity(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg1, arg2)
    }

    public fun admin_deposit_into_extension<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::deposit_into_extension(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, v0), arg4, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::admin_withdraw<T0, T1, 0x2::sui::SUI, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>(arg0, arg1, arg3, v0, arg5, arg7), arg6, arg7);
    }

    public fun admin_rebalance_stake<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::rebalance_stake(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg4, arg5, arg6);
    }

    public(friend) fun admin_stake_idle_liquidity<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::stake_idle_liquidity(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg4, arg5, arg6, arg7);
    }

    public fun admin_withdraw_from_extension<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key();
        let v1 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::withdraw_from_extension(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, v0), arg4, arg5, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) == arg5, 13835059893528166401);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::admin_deposit<T0, T1, 0x2::sui::SUI, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>(arg0, arg1, arg3, v0, v1);
    }

    public fun admin_withdraw_profit<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x1::type_name::with_defining_ids<0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>();
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::take_profit(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key()), arg4, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::active_liquidity_of_type_in_extension<T0, 0x2::sui::SUI>(arg0, &v0), arg5)
    }

    public fun convert_staked_sui_to_fungible_staked_sui<T0>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg1);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg2);
        let v0 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key());
        let v1 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::pool_ids(v0);
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::convert_staked_sui_to_fungible_staked_sui_for_pool_id(v0, arg3, 0x1::vector::pop_back<0x2::object::ID>(&mut v1), arg4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
    }

    // decompiled from Move bytecode v6
}

