module 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::admin {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_performance_fees<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T2>(0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::withdraw_performance_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::withdraw_withdrawal_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg12: &0x2::clock::Clock, arg13: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun set_deposit_limit<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::set_deposit_limit<T0, T1, T2>(arg1, arg2);
    }

    public fun set_deposits_enabled<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: bool) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::set_deposits_enabled<T0, T1, T2>(arg1, arg2);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u128, arg3: u128) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::set_slippage<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun update_performance_fees<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::update_performance_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::VaultCap, arg1: &mut 0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x6f021f1c021aa695053c576bc38e168f7ecfa83f19f1a7ac4816510d2c176cb0::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

