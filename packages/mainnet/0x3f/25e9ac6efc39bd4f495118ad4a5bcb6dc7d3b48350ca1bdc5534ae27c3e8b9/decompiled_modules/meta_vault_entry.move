module 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_entry {
    public entry fun set_min_rebalance_interval<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_allocator_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_allocator::set_min_rebalance_interval(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun create<T0, T1>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: address, arg4: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg5: u8, arg6: u128, arg7: 0x2::coin::TreasuryCap<T1>, arg8: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg8);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::ensure_owner(arg4, v0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::create<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun deposit<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun set_vault_name<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::set_vault_name<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun withdraw<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        let v3 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), v2);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
    }

    public entry fun accept_management_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::accrue_fees_internal<T0, T1>(arg0, arg1, arg2, arg3);
        let (v1, v2) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_fees_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v1, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_fees::apply_management_fee(v2, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::accept_management_fee(v1, 0x2::clock::timestamp_ms(arg2), v0, arg3), v0, arg3);
    }

    public entry fun accept_performance_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::accrue_fees_internal<T0, T1>(arg0, arg1, arg2, arg3);
        let (v1, v2) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_fees_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v1, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_fees::apply_performance_fee(v2, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::accept_performance_fee(v1, 0x2::clock::timestamp_ms(arg2), v0, arg3), v0, arg3);
    }

    public entry fun accept_remove_market<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0);
        let (v1, v2) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v1, 0x2::tx_context::sender(arg3));
        let v3 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::accept_market_removal(v1, 0x2::clock::timestamp_ms(arg2), v0, arg3);
        assert!(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::user_position_supply_assets(arg1, v3, v0) == 0, 14);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::remove_market(v2, v3, v0, false, arg3);
    }

    public entry fun accept_supply_cap<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0);
        let (v1, v2) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v1, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::apply_supply_cap(v2, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::accept_supply_cap(v1, 0x2::clock::timestamp_ms(arg1), v0, arg2), v0, arg2);
    }

    public entry fun accept_timelock<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::accept_timelock(v0, 0x2::clock::timestamp_ms(arg1), 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun cancel_pending_management_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::cancel_pending_management_fee(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun cancel_pending_performance_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::cancel_pending_performance_fee(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun cancel_pending_supply_cap<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::cancel_pending_supply_cap(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun collect_fees<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0), 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::accrue_fees_internal<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun compensate_lost_assets<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_lost_reserve_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg2));
        let v3 = (0x2::coin::value<T0>(&arg1) as u128);
        assert!(v3 <= *v1, 11);
        *v1 = *v1 - v3;
        0x2::balance::join<T0>(v2, 0x2::coin::into_balance<T0>(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_compensate_lost_assets(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), v3, *v1, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2);
    }

    public entry fun deposit_with_farming<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::Farming, arg3: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::Pool<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::stake<T1>(arg2, arg3, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::deposit<T0, T1>(arg0, arg1, arg4, arg5, arg6), arg5, arg6);
    }

    public entry fun emergency_remove_market<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0);
        let v1 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::user_position_supply_assets(arg1, arg2, v0);
        let (v2, v3, v4) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_strategy_lost_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v2, 0x2::tx_context::sender(arg3));
        if (v1 > 0) {
            *v4 = *v4 + v1;
        };
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::remove_market(v3, arg2, v0, true, arg3);
    }

    public entry fun pause_deposits<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::pause_deposits(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun pause_withdrawals<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::pause_withdrawals(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun revoke_pending_management_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::revoke_pending_management_fee(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun revoke_pending_market_removal<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::revoke_pending_market_removal(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun revoke_pending_performance_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::revoke_pending_performance_fee(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun revoke_pending_supply_cap<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::revoke_pending_supply_cap(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun revoke_pending_timelock<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner_or_guardian(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::revoke_pending_timelock(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun set_allocation<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: u128, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg4));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_allocation(v1, v0, arg1, arg2, arg3, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg4);
    }

    public entry fun set_allocator<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::set_allocator(v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_curator<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::set_curator(v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::accrue_fees_internal<T0, T1>(arg0, arg1, arg3, arg4);
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_fees_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_fees::set_fee_recipient(v1, v0, arg2, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg4);
    }

    public entry fun set_guardian<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::set_guardian(v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_max_deposit<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_max_deposit(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_min_deposit<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_min_deposit(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_owner<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::set_owner(v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_supply_queue<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_supply_queue(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_withdraw_cooldown<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_withdraw_cooldown(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun set_withdraw_queue<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg2));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::set_withdraw_queue(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2);
    }

    public entry fun submit_management_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_fees_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_fees::submit_management_fee(v1, v0, arg1, 0x2::clock::timestamp_ms(arg2), 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg3);
    }

    public entry fun submit_performance_fee<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_fees_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_fees::submit_performance_fee(v1, v0, arg1, 0x2::clock::timestamp_ms(arg2), 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg3);
    }

    public entry fun submit_remove_market<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg4));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::submit_remove_market(v1, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg2, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public entry fun submit_supply_cap<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_and_strategy_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_curator(v0, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_strategy::submit_supply_cap(v1, v0, arg1, 0x2::clock::timestamp_ms(arg2), 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg3);
    }

    public entry fun submit_timelock<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg3));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::submit_timelock(v0, arg1, 0x2::clock::timestamp_ms(arg2), 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg3);
    }

    public entry fun unpause_deposits<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::unpause_deposits(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun unpause_withdrawals<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::governance_mut<T0, T1>(arg0);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::ensure_owner(v0, 0x2::tx_context::sender(arg1));
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance::unpause_withdrawals(v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::vault_id<T0, T1>(arg0), arg1);
    }

    public entry fun withdraw_with_farming<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::Farming, arg3: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::Pool<T1>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::preview_withdraw<T0, T1>(arg0, arg1, arg5);
        let v1 = (0x2::coin::value<T1>(&arg4) as u128);
        let v2 = 0x2::coin::into_balance<T1>(arg4);
        if (v1 < v0) {
            0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::farming_core::unstake<T1>(arg2, arg3, v0 - v1, arg6, arg7)));
        };
        let (v3, v4) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::withdraw<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T1>(v2, arg7), arg5, arg6, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v5);
        let v6 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v6), v5);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v6);
    }

    // decompiled from Move bytecode v6
}

