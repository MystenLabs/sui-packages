module 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_governance {
    struct Governance has store {
        owner: address,
        curator: address,
        allocator: address,
        guardian: address,
        timelock: u64,
        pending_timelock: 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::PendingAmount,
        pending_supply_cap: 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::PendingAmount,
        pending_performance_fee: 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::PendingAmount,
        pending_management_fee: 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::PendingAmount,
        pending_market_removal: 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::PendingAmount,
        is_deposit_paused: bool,
        is_withdraw_paused: bool,
    }

    public(friend) fun accept_management_fee(arg0: &mut Governance, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::take_pending_amount(&mut arg0.pending_management_fee, arg1);
        assert!(v0 <= 18446744073709551615, 4);
        let v1 = (v0 as u64);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_management_fee(arg2, v1, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg3);
        v1
    }

    public(friend) fun accept_market_removal(arg0: &mut Governance, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::take_pending_amount(&mut arg0.pending_market_removal, arg1);
        assert!(v0 <= 18446744073709551615, 4);
        let v1 = (v0 as u64);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_market_removal(arg2, v1, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg3);
        v1
    }

    public(friend) fun accept_performance_fee(arg0: &mut Governance, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::take_pending_amount(&mut arg0.pending_performance_fee, arg1);
        assert!(v0 <= 18446744073709551615, 4);
        let v1 = (v0 as u64);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_performance_fee(arg2, v1, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg3);
        v1
    }

    public(friend) fun accept_supply_cap(arg0: &mut Governance, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) : u128 {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::take_pending_amount(&mut arg0.pending_supply_cap, arg1);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_supply_cap(arg2, v0, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg3);
        v0
    }

    public(friend) fun accept_timelock(arg0: &mut Governance, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::take_pending_amount(&mut arg0.pending_timelock, arg1);
        assert!(v0 <= 18446744073709551615, 4);
        let v1 = (v0 as u64);
        arg0.timelock = v1;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_timelock(arg2, v1, arg1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg3);
        v1
    }

    public(friend) fun cancel_pending_management_fee(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_management_fee);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_management_fee(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_cancel(), arg2);
    }

    public(friend) fun cancel_pending_performance_fee(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_performance_fee);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_performance_fee(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_cancel(), arg2);
    }

    public(friend) fun cancel_pending_supply_cap(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_supply_cap);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_supply_cap(arg1, v0, v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_cancel(), arg2);
    }

    public fun ensure_allocator(arg0: &Governance, arg1: address) {
        assert!(arg1 == arg0.allocator || arg1 == arg0.owner, 3);
    }

    public fun ensure_curator(arg0: &Governance, arg1: address) {
        assert!(arg1 == arg0.curator || arg1 == arg0.owner, 1);
    }

    public fun ensure_curator_or_guardian(arg0: &Governance, arg1: address) {
        let v0 = if (arg1 == arg0.curator) {
            true
        } else if (arg1 == arg0.guardian) {
            true
        } else {
            arg1 == arg0.owner
        };
        assert!(v0, 1);
    }

    public fun ensure_owner(arg0: &Governance, arg1: address) {
        assert!(arg1 == arg0.owner, 0);
    }

    public fun ensure_owner_or_guardian(arg0: &Governance, arg1: address) {
        assert!(arg1 == arg0.owner || arg1 == arg0.guardian, 2);
    }

    public fun get_addresses(arg0: &Governance) : (address, address, address, address) {
        (arg0.owner, arg0.curator, arg0.allocator, arg0.guardian)
    }

    public fun get_allocator(arg0: &Governance) : address {
        arg0.allocator
    }

    public fun get_curator(arg0: &Governance) : address {
        arg0.curator
    }

    public fun get_guardian(arg0: &Governance) : address {
        arg0.guardian
    }

    public fun get_owner(arg0: &Governance) : address {
        arg0.owner
    }

    public fun get_timelock(arg0: &Governance) : u64 {
        arg0.timelock
    }

    public fun get_timelock_ms(arg0: &Governance) : u64 {
        arg0.timelock * 60000
    }

    public fun is_deposit_paused(arg0: &Governance) : bool {
        arg0.is_deposit_paused
    }

    public fun is_withdraw_paused(arg0: &Governance) : bool {
        arg0.is_withdraw_paused
    }

    public fun new(arg0: address, arg1: address, arg2: address, arg3: address) : Governance {
        Governance{
            owner                   : arg0,
            curator                 : arg1,
            allocator               : arg2,
            guardian                : arg3,
            timelock                : 0,
            pending_timelock        : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::empty_pending_amount(),
            pending_supply_cap      : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::empty_pending_amount(),
            pending_performance_fee : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::empty_pending_amount(),
            pending_management_fee  : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::empty_pending_amount(),
            pending_market_removal  : 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::empty_pending_amount(),
            is_deposit_paused       : false,
            is_withdraw_paused      : false,
        }
    }

    public(friend) fun pause_deposits(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_deposit_paused = true;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::events::emit_set_vault_deposit_pause(arg1, true);
    }

    public(friend) fun pause_withdrawals(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_withdraw_paused = true;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::events::emit_set_vault_withdraw_pause(arg1, true);
    }

    public(friend) fun revoke_pending_management_fee(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_management_fee);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_management_fee(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_revoke(), arg2);
    }

    public(friend) fun revoke_pending_market_removal(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_market_removal);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_market_removal(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_revoke(), arg2);
    }

    public(friend) fun revoke_pending_performance_fee(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_performance_fee);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_performance_fee(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_revoke(), arg2);
    }

    public(friend) fun revoke_pending_supply_cap(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_curator_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_supply_cap);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_supply_cap(arg1, v0, v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_revoke(), arg2);
    }

    public(friend) fun revoke_pending_timelock(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_owner_or_guardian(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::revoke_pending(&mut arg0.pending_timelock);
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_timelock(arg1, (v0 as u64), v1, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_revoke(), arg2);
    }

    public(friend) fun set_allocator(arg0: &mut Governance, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        arg0.allocator = arg1;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_set_allocator(arg2, arg0.allocator, arg1, arg3);
    }

    public(friend) fun set_curator(arg0: &mut Governance, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        arg0.curator = arg1;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_set_curator(arg2, arg0.curator, arg1, arg3);
    }

    public(friend) fun set_guardian(arg0: &mut Governance, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        arg0.guardian = arg1;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_set_guardian(arg2, arg0.guardian, arg1, arg3);
    }

    public(friend) fun set_owner(arg0: &mut Governance, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        arg0.owner = arg1;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_set_owner(arg2, arg0.owner, arg1, arg3);
    }

    public(friend) fun submit_pending_management_fee(arg0: &mut Governance, arg1: u64, arg2: u64) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::set_pending_amount(&mut arg0.pending_management_fee, (arg1 as u128), arg2);
    }

    public(friend) fun submit_pending_market_removal(arg0: &mut Governance, arg1: u64, arg2: u64) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::set_pending_amount(&mut arg0.pending_market_removal, (arg1 as u128), arg2);
    }

    public(friend) fun submit_pending_performance_fee(arg0: &mut Governance, arg1: u64, arg2: u64) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::set_pending_amount(&mut arg0.pending_performance_fee, (arg1 as u128), arg2);
    }

    public(friend) fun submit_pending_supply_cap(arg0: &mut Governance, arg1: u128, arg2: u64) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::set_pending_amount(&mut arg0.pending_supply_cap, arg1, arg2);
    }

    public(friend) fun submit_timelock(arg0: &mut Governance, arg1: u64, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1 != arg0.timelock, 24);
        if (arg1 != 0) {
            assert!(arg1 >= 1 && arg1 <= 43200, 22);
        };
        if (arg1 > arg0.timelock) {
            arg0.timelock = arg1;
            0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_timelock(arg3, arg1, arg2, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_accept(), arg4);
        } else {
            let v0 = arg2 + (((arg0.timelock as u128) * (60000 as u128)) as u64);
            0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::pending::set_pending_amount(&mut arg0.pending_timelock, (arg1 as u128), v0);
            0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::emit_submit_timelock(arg3, arg1, v0, 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_events::event_type_submit(), arg4);
        };
    }

    public(friend) fun unpause_deposits(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_deposit_paused = false;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::events::emit_set_vault_deposit_pause(arg1, false);
    }

    public(friend) fun unpause_withdrawals(arg0: &mut Governance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_withdraw_paused = false;
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::events::emit_set_vault_withdraw_pause(arg1, false);
    }

    // decompiled from Move bytecode v6
}

