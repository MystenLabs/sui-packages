module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::gateway {
    entry fun guardian_pause_non_admin_operations(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::guardian_pause_non_admin_operations(arg0, arg1, arg2);
    }

    entry fun increase_supported_package_version(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::increase_supported_package_version(arg0, arg1);
    }

    entry fun pause_non_admin_operations(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: bool) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::pause_non_admin_operations(arg0, arg1, arg2);
    }

    entry fun set_guardian(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: address) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::set_guardian(arg0, arg1, arg2);
    }

    entry fun update_default_rate(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_default_rate(arg0, arg1, arg2);
    }

    entry fun update_max_fee_percentage(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_max_fee_percentage(arg0, arg1, arg2);
    }

    entry fun update_max_rate(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_max_rate(arg0, arg1, arg2);
    }

    entry fun update_max_rate_interval(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_max_rate_interval(arg0, arg1, arg2);
    }

    entry fun update_min_rate(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_min_rate(arg0, arg1, arg2);
    }

    entry fun update_min_rate_interval(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: u64) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_min_rate_interval(arg0, arg1, arg2);
    }

    entry fun update_platform_fee_recipient(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: address) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::update_platform_fee_recipient(arg0, arg1, arg2);
    }

    entry fun cancel_pending_withdrawal_request<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::cancel_pending_withdrawal_request<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_admin<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg3: address) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::change_vault_admin<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_operator<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::change_vault_operator<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_rate_update_interval<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::change_vault_rate_update_interval<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun collect_platform_fee<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        abort 5000
    }

    entry fun guardian_set_blacklisted_account<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::guardian_set_blacklisted_account<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun process_withdrawal_requests<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::process_withdrawal_requests<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun process_withdrawal_requests_up_to_timestamp<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::process_withdrawal_requests_up_to_timestamp<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun redeem_shares<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg5)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(arg3), v0, arg0, arg5);
    }

    entry fun set_blacklisted_account<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_blacklisted_account<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_deposit_user_list<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_deposit_user_list<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_fee_exemption_list<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_fee_exemption_list<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_min_withdrawal_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_min_withdrawal_shares<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun set_permanent_fee_percentage<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_permanent_fee_percentage<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun set_sub_account<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_sub_account<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_time_based_fee_percentage<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_time_based_fee_percentage<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun set_time_based_fee_threshold<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_time_based_fee_threshold<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_fee_percentage<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 5000
    }

    entry fun update_vault_max_rate_change_per_update<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_max_rate_change_per_update<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_max_tvl<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_max_tvl<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_name<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_name<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_rate<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_rate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_cancel_pending_withdrawal_request<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::cancel_pending_withdrawal_request<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_change_vault_admin<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg3: address) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::change_vault_admin<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_change_vault_operator<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::change_vault_operator<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_change_vault_rate_update_interval<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::change_vault_rate_update_interval<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_claim_received_collateral<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::claim_received_collateral<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_claim_returned_ember_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::claim_returned_ember_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_claim_suilend_strategy_reward<T0, T1, T2, T3>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::claim_suilend_strategy_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun atomic_collect_platform_fee<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::collect_platform_fee<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_deposit<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg6)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::deposit<T0>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
    }

    entry fun atomic_deposit_from_sub_account<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::deposit_from_sub_account<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_deposit_from_sub_account_v2<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::deposit_from_sub_account_v2<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_guardian_set_blacklisted_account<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::guardian_set_blacklisted_account<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_guardian_set_pause_status<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: vector<u8>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::guardian_set_pause_status<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_instant_withdraw<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg3)) {
            *0x1::option::borrow<address>(&arg3)
        } else {
            0x2::tx_context::sender(arg5)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::instant_withdraw<T0>(arg0, arg1, arg2, v0, arg4, arg5);
    }

    entry fun atomic_instant_withdraw_with_suilend<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg6)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::instant_withdraw_with_suilend<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
    }

    entry fun atomic_instant_withdraw_with_suilend_sui<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::instant_withdraw_with_suilend_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun atomic_open_suilend_obligation<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::open_suilend_obligation<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_process_withdrawal_requests<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::process_withdrawal_requests<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_process_withdrawal_requests_up_to_timestamp<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::process_withdrawal_requests_up_to_timestamp<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_redeem_collected_ember_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::redeem_collected_ember_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_redeem_shares<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg3)) {
            *0x1::option::borrow<address>(&arg3)
        } else {
            0x2::tx_context::sender(arg5)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::redeem_shares<T0>(arg0, arg1, arg2, v0, arg4, arg5);
    }

    entry fun atomic_release_users_holdback<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::release_users_holdback<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun atomic_remove_ember_share_fee_multiplier_tier<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::remove_ember_share_fee_multiplier_tier<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_blacklisted_account<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_blacklisted_account<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_deposit_user_list<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_deposit_user_list<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_ember_share_fee_multiplier_tier<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_ember_share_fee_multiplier_tier<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_set_ember_share_max_utilization<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_ember_share_max_utilization<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_ember_share_whitelist<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_ember_share_whitelist<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun atomic_set_fee_exemption_list<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_fee_exemption_list<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_instant_withdraw_fee_percentage<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_instant_withdraw_fee_percentage<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_set_max_instant_withdraw_shares<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_max_instant_withdraw_shares<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_set_min_withdrawal_shares<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_min_withdrawal_shares<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_set_pause_status<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: vector<u8>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_pause_status<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_permanent_fee_percentage<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_permanent_fee_percentage<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_set_strategy_none_from_suilend<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_strategy_none_from_suilend<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_strategy_none_from_suilend_sui<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_strategy_none_from_suilend_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_set_strategy_suilend<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_strategy_suilend<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_sub_account<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_sub_account<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_set_swap_waiver<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_swap_waiver<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_set_time_based_fee_percentage<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_time_based_fee_percentage<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_set_time_based_fee_threshold<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::set_time_based_fee_threshold<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_supply_to_sub_account<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::supply_to_sub_account<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_supply_to_suilend_strategy<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::supply_to_suilend_strategy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_swap_ember_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg7)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::swap_ember_shares<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7);
    }

    entry fun atomic_swap_ember_shares_with_suilend<T0, T1, T2>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg5)) {
            *0x1::option::borrow<address>(&arg5)
        } else {
            0x2::tx_context::sender(arg8)
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::swap_ember_shares_with_suilend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7, arg8);
    }

    entry fun atomic_swap_ember_shares_with_suilend_sui<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0x2::sui::SUI, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::swap_ember_shares_with_suilend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun atomic_update_vault_fee_percentage<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_fee_percentage<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_update_vault_max_rate_change_per_update<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_max_rate_change_per_update<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_update_vault_max_tvl<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_max_tvl<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_update_vault_name<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_name<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_update_vault_rate<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_rate<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun atomic_update_vault_rate_manager<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::update_vault_rate_manager<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun atomic_withdraw_from_suilend_strategy<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::withdraw_from_suilend_strategy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_withdraw_from_suilend_strategy_sui<T0>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<0x2::sui::SUI>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::withdraw_from_suilend_strategy_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun atomic_withdraw_suilend_secondary_collateral<T0, T1, T2>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::withdraw_suilend_secondary_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun atomic_withdraw_suilend_secondary_collateral_sui<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::AtomicLiquidityVault<T0>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::withdraw_suilend_secondary_collateral_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun change_vault_rate_manager<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_rate_manager<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun charge_platform_fee<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::charge_platform_fee<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun collect_platform_fee_v2<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::collect_platform_fee_v2<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun create_atomic_vault<T0>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::create_atomic_liquidity_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::atomic_liquidity_vault::share_atomic_vault<T0>(v0, v1);
    }

    entry fun create_vault<T0, T1>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::AdminCap, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::share_vault<T0, T1>(0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    entry fun deposit_asset<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 5000
    }

    entry fun deposit_asset_v2<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg6)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg5, arg6), v0);
    }

    entry fun deposit_to_vault_without_minting_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_to_vault_without_minting_shares<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), arg2, arg4);
    }

    entry fun deposit_to_vault_without_minting_shares_v2<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_to_vault_without_minting_shares_v2<T0, T1>(arg0, arg1, arg3, arg2, arg4);
    }

    entry fun deposit_to_vault_without_minting_shares_v3<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_to_vault_without_minting_shares_v3<T0, T1>(arg0, arg1, arg3, arg2, arg4);
    }

    entry fun guardian_set_vault_paused_status<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::guardian_set_vault_paused_status<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun mint_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 5000
    }

    entry fun mint_shares_v2<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = if (0x1::option::is_some<address>(&arg5)) {
            *0x1::option::borrow<address>(&arg5)
        } else {
            0x2::tx_context::sender(arg7)
        };
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::mint_shares_v2<T0, T1>(arg0, arg1, &mut v0, arg3, arg4, arg6, arg7), v1);
    }

    entry fun set_vault_paused_status<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::set_vault_paused_status<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_fee_percentage_v2<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::update_vault_fee_percentage_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun withdraw_from_vault_without_redeeming_shares<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::withdraw_from_vault_without_redeeming_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

