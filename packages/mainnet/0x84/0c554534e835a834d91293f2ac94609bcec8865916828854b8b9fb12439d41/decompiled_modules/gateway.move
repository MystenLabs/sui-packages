module 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::gateway {
    entry fun increase_supported_package_version(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::increase_supported_package_version(arg0, arg1);
    }

    entry fun pause_non_admin_operations(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: bool) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::pause_non_admin_operations(arg0, arg1, arg2);
    }

    entry fun update_default_rate(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_default_rate(arg0, arg1, arg2);
    }

    entry fun update_max_fee_percentage(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_max_fee_percentage(arg0, arg1, arg2);
    }

    entry fun update_max_rate(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_max_rate(arg0, arg1, arg2);
    }

    entry fun update_max_rate_interval(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_max_rate_interval(arg0, arg1, arg2);
    }

    entry fun update_min_rate(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_min_rate(arg0, arg1, arg2);
    }

    entry fun update_min_rate_interval(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: u64) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_min_rate_interval(arg0, arg1, arg2);
    }

    entry fun update_platform_fee_recipient(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg2: address) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::update_platform_fee_recipient(arg0, arg1, arg2);
    }

    entry fun cancel_pending_withdrawal_request<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::cancel_pending_withdrawal_request<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_admin<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg3: address) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::change_vault_admin<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_operator<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::change_vault_operator<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun change_vault_rate_update_interval<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::change_vault_rate_update_interval<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun charge_platform_fee<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::charge_platform_fee<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun collect_platform_fee<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::collect_platform_fee<T0, T1>(arg0, arg1, arg2);
    }

    entry fun create_vault<T0, T1>(arg0: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::share_vault<T0, T1>(0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    entry fun deposit_asset<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::deposit_asset<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun deposit_to_vault_without_minting_shares<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::deposit_to_vault_without_minting_shares<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), arg2, arg4);
    }

    entry fun mint_shares<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg5)
        };
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::mint_shares<T0, T1>(arg0, arg1, &mut v0, arg3, arg5), v1);
    }

    entry fun process_withdrawal_requests<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::process_withdrawal_requests<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun process_withdrawal_requests_up_to_timestamp<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::process_withdrawal_requests_up_to_timestamp<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun redeem_shares<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg2: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            *0x1::option::borrow<address>(&arg4)
        } else {
            0x2::tx_context::sender(arg5)
        };
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::redeem_shares<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(arg3), v0, arg0, arg5);
    }

    entry fun set_blacklisted_account<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::set_blacklisted_account<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_min_withdrawal_shares<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::set_min_withdrawal_shares<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun set_sub_account<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::set_sub_account<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun set_vault_paused_status<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::set_vault_paused_status<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_fee_percentage<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::update_vault_fee_percentage<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_max_tvl<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::update_vault_max_tvl<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_rate<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::update_vault_rate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun withdraw_from_vault_without_redeeming_shares<T0, T1>(arg0: &mut 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault::withdraw_from_vault_without_redeeming_shares<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

