module 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::admin {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_performance_fees<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T2>(0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::withdraw_performance_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::withdraw_withdrawal_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u8, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun set_deposit_limit<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::set_deposit_limit<T0, T1, T2>(arg1, arg2);
    }

    public fun set_deposits_enabled<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: bool) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::set_deposits_enabled<T0, T1, T2>(arg1, arg2);
    }

    public fun set_harvest_whitelisted_address<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg1: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg2: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::HarvestCap, arg3: address) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg0, arg1);
        assert!(0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::harvest_cap_vault_id(arg2) == 0x2::object::id<0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>>(arg0), 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::error::invalid_harvest_cap());
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::set_harvest_whitelisted_address(arg2, arg3);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u128, arg3: u128) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::set_slippage<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun update_performance_fees<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::update_performance_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::VaultCap, arg1: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

