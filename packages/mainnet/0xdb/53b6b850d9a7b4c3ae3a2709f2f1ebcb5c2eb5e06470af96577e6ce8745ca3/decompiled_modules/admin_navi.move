module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin_navi {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        vt_type: 0x1::type_name::TypeName,
    }

    public fun add_swap_route<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        abort 1000
    }

    public fun new_vault<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        abort 1000
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>) {
        abort 1000
    }

    public fun set_deposit_limit<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: u64) {
        abort 1000
    }

    public fun set_deposits_enabled<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: bool) {
        abort 1000
    }

    public fun set_performance_fees<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: u64) {
        abort 1000
    }

    public fun set_withdrawal_fees<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: u64) {
        abort 1000
    }

    public fun withdraw_performance_fees<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        abort 1000
    }

    public fun withdraw_withdrawal_fees<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::AdminCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        abort 1000
    }

    // decompiled from Move bytecode v7
}

