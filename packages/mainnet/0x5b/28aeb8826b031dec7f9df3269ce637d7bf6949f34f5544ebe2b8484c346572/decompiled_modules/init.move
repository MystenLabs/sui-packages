module 0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::init {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::VaultCap, arg1: &mut 0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::Vault<T0, T1, T2>, arg2: vector<0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::bag_value::Value>) {
        0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::VaultCap, arg1: &mut 0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::withdraw_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg10: &0x2::clock::Clock, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::VaultCap, arg1: &mut 0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x5b28aeb8826b031dec7f9df3269ce637d7bf6949f34f5544ebe2b8484c346572::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

