module 0x93c6feab4522f9f1fdcb2405e0e717f39b2fe27e2cb06d38675cb1d97a960c3c::hardstaking {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pending_transfer: 0x1::option::Option<PendingOwnershipTransfer>,
        admins: 0x2::vec_set::VecSet<address>,
        max_admins: u64,
    }

    struct PendingOwnershipTransfer has drop, store {
        new_owner: address,
        initiated_at: u64,
        expires_at: u64,
    }

    struct StakingConfig has key {
        id: 0x2::object::UID,
        version: u64,
        min_stake: u64,
        max_stake: u64,
        total_staked: u64,
        grace_period_end_timestamp_ms: u64,
        deployment_time: u64,
        active: bool,
        staking_active: bool,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        staker: address,
        amount: u64,
        stake_date: u64,
        lock_period_ms: u64,
        claimed: bool,
        stake_id: u64,
        is_admin_stake: bool,
    }

    struct UserStakeRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        user_stakes: 0x2::table::Table<address, 0x2::table::Table<u64, UserStake>>,
        user_stake_counts: 0x2::table::Table<address, u64>,
        total_user_stakes: u64,
        all_stakers: 0x2::table_vec::TableVec<address>,
    }

    struct StakingVault has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>,
        admin_locked: u64,
        user_locked: u64,
    }

    struct FunctionCallEvent has copy, drop {
        function_name: 0x1::ascii::String,
        caller: address,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct MigrationEvent has copy, drop {
        migrated_to_version: u64,
        migrated_by: address,
        timestamp: u64,
    }

    struct ContractPaused has copy, drop {
        paused_by: address,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct ContractUnpaused has copy, drop {
        unpaused_by: address,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        added_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct GracePeriodUpdated has copy, drop {
        old_grace_period_ms: u64,
        new_grace_period_ms: u64,
        updated_by: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct StakingConfigUpdated has copy, drop {
        min_stake: u64,
        max_stake: u64,
        updated_by: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct OwnershipTransferInitiated has copy, drop {
        current_owner: address,
        pending_owner: address,
        expires_at: u64,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct OwnershipTransferCancelled has copy, drop {
        current_owner: address,
        cancelled_pending_owner: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct OwnershipTransferExpired has copy, drop {
        current_owner: address,
        expired_pending_owner: address,
        expired_at: u64,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct UserStakeEvent has copy, drop {
        staker: address,
        amount: u64,
        stake_date: u64,
        lock_period_ms: u64,
        stake_id: u64,
        is_admin_stake: bool,
        timestamp: u64,
    }

    struct UserUnstakeEvent has copy, drop {
        staker: address,
        amount: u64,
        unstake_date: u64,
        stake_id: u64,
    }

    struct AdminStakeForUserEvent has copy, drop {
        admin: address,
        user: address,
        amount: u64,
        lock_period_ms: u64,
        stake_date: u64,
        stake_id: u64,
        timestamp: u64,
    }

    struct CapabilityDestroyed has copy, drop {
        capability_type: 0x1::ascii::String,
        destroyed_by: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct StakingStatusChanged has copy, drop {
        changed_by: address,
        staking_enabled: bool,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    entry fun accept_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_ownership_transfer", v0, arg1, arg2);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1300);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        assert!(v0 == v1.new_owner, 1302);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.expires_at, 1301);
        arg0.owner = v0;
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"escrowed_owner_cap"), 1009);
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), v0);
        let v2 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
            tx_digest      : *0x2::tx_context::digest(arg2),
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<OwnershipTransferred>(v2);
    }

    entry fun add_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"add_admin", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1401);
        assert!(arg2 != @0x0, 1200);
        assert!(arg2 != v0, 1404);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1102);
        assert!(0x2::vec_set::size<address>(&arg1.admins) < arg1.max_admins, 1100);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
        let v1 = AdminCap{id: 0x2::object::new(arg4)};
        0x2::transfer::transfer<AdminCap>(v1, arg2);
        let v2 = AdminAdded{
            admin_address      : arg2,
            added_by           : v0,
            total_admins_after : 0x2::vec_set::size<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminAdded>(v2);
    }

    entry fun admin_stake_for_user(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut UserStakeRegistry, arg3: &AdminRegistry, arg4: &mut StakingVault, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_version(arg3, arg1, arg2, arg4);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = 0x2::coin::value<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&arg9);
        emit_function_call(b"admin_stake_for_user", v0, arg10, arg11);
        ensure_not_paused(arg1);
        ensure_staking_active(arg1);
        assert!(is_admin(arg3, v0), 1000);
        assert!(arg5 != v0, 1402);
        assert!(get_user_role(arg3, arg5) == 0, 1403);
        assert!(arg5 != @0x0, 1200);
        assert!(arg6 > 0, 1004);
        assert!(arg6 <= v2, 1003);
        assert!(validate_lock_period(arg7), 1505);
        let v3 = if (arg8 == 0) {
            v1
        } else {
            arg8
        };
        validate_admin_stake_dates(arg1, v3, v1, arg7);
        assert!(arg6 >= arg1.min_stake, 1500);
        assert!(arg6 <= arg1.max_stake, 1501);
        let v4 = if (arg6 == v2) {
            0x2::coin::into_balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(arg9)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>>(0x2::coin::split<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&mut arg9, v2 - arg6, arg11), v0);
            0x2::coin::into_balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(arg9)
        };
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg2.user_stakes, arg5)) {
            0x2::table::add<address, 0x2::table::Table<u64, UserStake>>(&mut arg2.user_stakes, arg5, 0x2::table::new<u64, UserStake>(arg11));
            0x2::table::add<address, u64>(&mut arg2.user_stake_counts, arg5, 0);
            0x2::table_vec::push_back<address>(&mut arg2.all_stakers, arg5);
        };
        let v5 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, UserStake>>(&mut arg2.user_stakes, arg5);
        let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_stake_counts, arg5);
        assert!(*v6 < 18446744073709551615, 1509);
        *v6 = safe_add(*v6, 1);
        let v7 = *v6;
        let v8 = UserStake{
            id             : 0x2::object::new(arg11),
            staker         : arg5,
            amount         : arg6,
            stake_date     : v3,
            lock_period_ms : arg7,
            claimed        : false,
            stake_id       : v7,
            is_admin_stake : true,
        };
        0x2::table::add<u64, UserStake>(v5, v7, v8);
        arg1.total_staked = safe_add(arg1.total_staked, arg6);
        arg2.total_user_stakes = safe_add(arg2.total_user_stakes, 1);
        arg4.admin_locked = safe_add(arg4.admin_locked, arg6);
        0x2::balance::join<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&mut arg4.balance, v4);
        let v9 = AdminStakeForUserEvent{
            admin          : v0,
            user           : arg5,
            amount         : arg6,
            lock_period_ms : arg7,
            stake_date     : v3,
            stake_id       : v7,
            timestamp      : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<AdminStakeForUserEvent>(v9);
    }

    entry fun cancel_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"cancel_ownership_transfer", v0, arg1, arg2);
        assert!(is_owner(arg0, v0), 1401);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1300);
        assert!(0x2::clock::timestamp_ms(arg1) <= 0x1::option::borrow<PendingOwnershipTransfer>(&arg0.pending_transfer).expires_at, 1301);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), v0);
        let v2 = OwnershipTransferCancelled{
            current_owner           : v0,
            cancelled_pending_owner : v1.new_owner,
            tx_digest               : *0x2::tx_context::digest(arg2),
            timestamp               : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<OwnershipTransferCancelled>(v2);
    }

    fun check_version(arg0: &AdminRegistry, arg1: &StakingConfig, arg2: &UserStakeRegistry, arg3: &StakingVault) {
        assert!(arg0.version == 2, 2000);
        assert!(arg1.version == 2, 2000);
        assert!(arg2.version == 2, 2000);
        assert!(arg3.version == 2, 2000);
    }

    fun check_version_admin_config(arg0: &AdminRegistry, arg1: &StakingConfig) {
        assert!(arg0.version == 2, 2000);
        assert!(arg1.version == 2, 2000);
    }

    fun check_version_admin_registry(arg0: &AdminRegistry) {
        assert!(arg0.version == 2, 2000);
    }

    fun check_version_registry_vault(arg0: &UserStakeRegistry, arg1: &StakingVault, arg2: &StakingConfig) {
        assert!(arg0.version == 2, 2000);
        assert!(arg1.version == 2, 2000);
        assert!(arg2.version == 2, 2000);
    }

    entry fun cleanup_expired_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"cleanup_expired_transfer", v0, arg1, arg2);
        assert!(is_admin(arg0, v0) || is_owner(arg0, v0), 1400);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1300);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 > 0x1::option::borrow<PendingOwnershipTransfer>(&arg0.pending_transfer).expires_at, 1303);
        let v2 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), arg0.owner);
        let v3 = OwnershipTransferExpired{
            current_owner         : arg0.owner,
            expired_pending_owner : v2.new_owner,
            expired_at            : v1,
            tx_digest             : *0x2::tx_context::digest(arg2),
            timestamp             : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<OwnershipTransferExpired>(v3);
    }

    entry fun destroy_old_admin_cap(arg0: AdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_admin_cap", v0, arg2, arg3);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &v0), 1700);
        let AdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"AdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CapabilityDestroyed>(v2);
    }

    fun emit_function_call(arg0: vector<u8>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = FunctionCallEvent{
            function_name : 0x1::ascii::string(arg0),
            caller        : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
            tx_digest     : *0x2::tx_context::digest(arg3),
        };
        0x2::event::emit<FunctionCallEvent>(v0);
    }

    fun ensure_not_paused(arg0: &StakingConfig) {
        assert!(arg0.active, 1900);
    }

    fun ensure_paused(arg0: &StakingConfig) {
        assert!(!arg0.active, 1901);
    }

    fun ensure_staking_active(arg0: &StakingConfig) {
        assert!(arg0.staking_active, 1902);
    }

    public fun get_active_stakers_paginated(arg0: &UserStakeRegistry, arg1: u64, arg2: u64) : (vector<address>, bool) {
        assert!(arg2 > 0 && arg2 <= 100, 1006);
        let v0 = &arg0.all_stakers;
        let v1 = 0x2::table_vec::length<address>(v0);
        assert!(arg1 <= v1, 1005);
        let v2 = 0x1::vector::empty<address>();
        let v3 = false;
        let v4 = arg1;
        while (v4 < v1 && 0x1::vector::length<address>(&v2) < arg2) {
            let v5 = 0x2::table_vec::borrow<address>(v0, v4);
            if (0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, *v5)) {
                if (!0x2::table::contains<address, u64>(&arg0.user_stake_counts, *v5)) {
                    /* goto 32 */
                } else {
                    let v6 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, *v5);
                    let v7 = false;
                    let v8 = 1;
                    while (v8 <= *0x2::table::borrow<address, u64>(&arg0.user_stake_counts, *v5) && !v7) {
                        if (0x2::table::contains<u64, UserStake>(v6, v8)) {
                            if (!0x2::table::borrow<u64, UserStake>(v6, v8).claimed) {
                                v7 = true;
                            };
                        };
                        v8 = v8 + 1;
                    };
                    if (v7) {
                        0x1::vector::push_back<address>(&mut v2, *v5);
                    };
                };
            };
            v4 = v4 + 1;
            continue;
            /* label 32 */
            v4 = v4 + 1;
        };
        if (v4 < v1) {
            v3 = true;
        };
        (v2, v3)
    }

    public fun get_all_admins(arg0: &AdminRegistry) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.admins)
    }

    public fun get_all_stakers_paginated(arg0: &UserStakeRegistry, arg1: u64, arg2: u64) : (vector<address>, bool) {
        assert!(arg2 > 0 && arg2 <= 100, 1006);
        let v0 = &arg0.all_stakers;
        let v1 = 0x2::table_vec::length<address>(v0);
        assert!(arg1 <= v1, 1005);
        let v2 = 0x1::vector::empty<address>();
        let v3 = min(arg1 + arg2, v1);
        while (arg1 < v3) {
            0x1::vector::push_back<address>(&mut v2, *0x2::table_vec::borrow<address>(v0, arg1));
            arg1 = arg1 + 1;
        };
        (v2, v3 < v1)
    }

    public fun get_grace_period_end_time(arg0: &StakingConfig) : u64 {
        arg0.grace_period_end_timestamp_ms
    }

    public fun get_staking_config(arg0: &StakingConfig) : (u64, u64, u64, u64, u64, bool, bool) {
        (arg0.min_stake, arg0.max_stake, arg0.total_staked, arg0.grace_period_end_timestamp_ms, arg0.deployment_time, arg0.active, arg0.staking_active)
    }

    public fun get_total_admin_locked(arg0: &StakingVault) : u64 {
        arg0.admin_locked
    }

    public fun get_total_locked(arg0: &StakingVault) : u64 {
        safe_add(arg0.user_locked, arg0.admin_locked)
    }

    public fun get_total_stakers_count(arg0: &UserStakeRegistry) : u64 {
        0x2::table_vec::length<address>(&arg0.all_stakers)
    }

    public fun get_total_user_locked(arg0: &StakingVault) : u64 {
        arg0.user_locked
    }

    public fun get_total_user_stakes(arg0: &UserStakeRegistry) : u64 {
        arg0.total_user_stakes
    }

    public fun get_user_active_stakes_paginated(arg0: &UserStakeRegistry, arg1: address, arg2: u64, arg3: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        assert!(arg3 > 0 && arg3 <= 100, 1006);
        assert!(arg2 > 0, 1007);
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_stake_counts, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_stake_counts, arg1);
        if (arg2 > v1) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = 0x1::vector::empty<bool>();
        let v8 = arg2;
        let v9 = 0;
        while (v8 <= v1 && v9 < arg3) {
            if (0x2::table::contains<u64, UserStake>(v0, v8)) {
                let v10 = 0x2::table::borrow<u64, UserStake>(v0, v8);
                if (!v10.claimed) {
                    0x1::vector::push_back<u64>(&mut v2, v10.stake_id);
                    0x1::vector::push_back<u64>(&mut v3, v10.amount);
                    0x1::vector::push_back<u64>(&mut v4, v10.stake_date);
                    0x1::vector::push_back<u64>(&mut v5, v10.lock_period_ms);
                    0x1::vector::push_back<bool>(&mut v6, v10.claimed);
                    0x1::vector::push_back<bool>(&mut v7, v10.is_admin_stake);
                    v9 = v9 + 1;
                };
            };
            v8 = v8 + 1;
        };
        let v11 = if (v8 > v1) {
            0
        } else {
            v8
        };
        (v2, v3, v4, v5, v6, v7, v11)
    }

    fun get_user_role(arg0: &AdminRegistry, arg1: address) : u8 {
        if (is_owner(arg0, arg1)) {
            2
        } else if (is_admin(arg0, arg1)) {
            1
        } else {
            0
        }
    }

    public fun get_user_stake_by_index(arg0: &UserStakeRegistry, arg1: address, arg2: u64) : (u64, u64, u64, bool, bool) {
        assert!(arg2 > 0, 1007);
        assert!(0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1), 1502);
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1);
        assert!(0x2::table::contains<u64, UserStake>(v0, arg2), 1502);
        let v1 = 0x2::table::borrow<u64, UserStake>(v0, arg2);
        (v1.amount, v1.stake_date, v1.lock_period_ms, v1.claimed, v1.is_admin_stake)
    }

    public fun get_user_stakes(arg0: &UserStakeRegistry, arg1: address) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<bool>) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1) || !0x2::table::contains<address, u64>(&arg0.user_stake_counts, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>())
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = 1;
        while (v7 <= *0x2::table::borrow<address, u64>(&arg0.user_stake_counts, arg1)) {
            if (0x2::table::contains<u64, UserStake>(v0, v7)) {
                let v8 = 0x2::table::borrow<u64, UserStake>(v0, v7);
                0x1::vector::push_back<u64>(&mut v1, v8.stake_id);
                0x1::vector::push_back<u64>(&mut v2, v8.amount);
                0x1::vector::push_back<u64>(&mut v3, v8.stake_date);
                0x1::vector::push_back<u64>(&mut v4, v8.lock_period_ms);
                0x1::vector::push_back<bool>(&mut v5, v8.claimed);
                0x1::vector::push_back<bool>(&mut v6, v8.is_admin_stake);
            };
            v7 = v7 + 1;
        };
        (v1, v2, v3, v4, v5, v6)
    }

    public fun get_user_stakes_paginated(arg0: &UserStakeRegistry, arg1: address, arg2: u64, arg3: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        assert!(arg3 > 0 && arg3 <= 100, 1006);
        assert!(arg2 > 0, 1007);
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_stake_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_stake_counts, arg1)
        } else {
            0
        };
        if (arg2 > v1) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = 0x1::vector::empty<bool>();
        let v8 = arg2;
        let v9 = 0;
        while (v8 <= v1 && v9 < arg3) {
            if (0x2::table::contains<u64, UserStake>(v0, v8)) {
                let v10 = 0x2::table::borrow<u64, UserStake>(v0, v8);
                0x1::vector::push_back<u64>(&mut v2, v10.stake_id);
                0x1::vector::push_back<u64>(&mut v3, v10.amount);
                0x1::vector::push_back<u64>(&mut v4, v10.stake_date);
                0x1::vector::push_back<u64>(&mut v5, v10.lock_period_ms);
                0x1::vector::push_back<bool>(&mut v6, v10.claimed);
                0x1::vector::push_back<bool>(&mut v7, v10.is_admin_stake);
                v9 = v9 + 1;
            };
            v8 = v8 + 1;
        };
        let v11 = if (v8 > v1) {
            0
        } else {
            v8
        };
        (v2, v3, v4, v5, v6, v7, v11)
    }

    public fun get_user_stakes_summary(arg0: &UserStakeRegistry, arg1: address) : (u64, u64, u64, u64) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 18446744073709551615;
        let v5 = v4;
        let v6 = 1;
        while (v6 <= *0x2::table::borrow<address, u64>(&arg0.user_stake_counts, arg1)) {
            if (0x2::table::contains<u64, UserStake>(v0, v6)) {
                let v7 = 0x2::table::borrow<u64, UserStake>(v0, v6);
                v1 = v1 + 1;
                if (!v7.claimed) {
                    v2 = v2 + 1;
                    v3 = safe_add(v3, v7.amount);
                    let v8 = safe_add(v7.stake_date, v7.lock_period_ms);
                    if (v8 < v4) {
                        v5 = v8;
                    };
                };
            };
            v6 = v6 + 1;
        };
        if (v2 == 0) {
            v5 = 0;
        };
        (v1, v2, v3, v5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminRegistry{
            id               : 0x2::object::new(arg0),
            version          : 2,
            owner            : v0,
            pending_transfer : 0x1::option::none<PendingOwnershipTransfer>(),
            admins           : 0x2::vec_set::empty<address>(),
            max_admins       : 2,
        };
        let v2 = StakingConfig{
            id                            : 0x2::object::new(arg0),
            version                       : 2,
            min_stake                     : 1000000000000,
            max_stake                     : 10000000000000000,
            total_staked                  : 0,
            grace_period_end_timestamp_ms : 1758412799000,
            deployment_time               : 0x2::tx_context::epoch_timestamp_ms(arg0),
            active                        : true,
            staking_active                : true,
        };
        let v3 = UserStakeRegistry{
            id                : 0x2::object::new(arg0),
            version           : 2,
            user_stakes       : 0x2::table::new<address, 0x2::table::Table<u64, UserStake>>(arg0),
            user_stake_counts : 0x2::table::new<address, u64>(arg0),
            total_user_stakes : 0,
            all_stakers       : 0x2::table_vec::empty<address>(arg0),
        };
        let v4 = StakingVault{
            id           : 0x2::object::new(arg0),
            version      : 2,
            balance      : 0x2::balance::zero<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(),
            admin_locked : 0,
            user_locked  : 0,
        };
        let v5 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v5, v0);
        0x2::transfer::share_object<AdminRegistry>(v1);
        0x2::transfer::share_object<StakingConfig>(v2);
        0x2::transfer::share_object<UserStakeRegistry>(v3);
        0x2::transfer::share_object<StakingVault>(v4);
    }

    entry fun initiate_ownership_transfer(arg0: OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"initiate_ownership_transfer", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1401);
        assert!(arg2 != @0x0, 1200);
        assert!(arg2 != v0, 1001);
        assert!(!is_admin(arg1, arg2), 1010);
        assert!(0x1::option::is_none<PendingOwnershipTransfer>(&arg1.pending_transfer), 1303);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = PendingOwnershipTransfer{
            new_owner    : arg2,
            initiated_at : v1,
            expires_at   : safe_add(v1, 86400000),
        };
        arg1.pending_transfer = 0x1::option::some<PendingOwnershipTransfer>(v2);
        0x2::dynamic_field::add<vector<u8>, OwnerCap>(&mut arg1.id, b"escrowed_owner_cap", arg0);
        let v3 = OwnershipTransferInitiated{
            current_owner : v0,
            pending_owner : arg2,
            expires_at    : safe_add(v1, 86400000),
            tx_digest     : *0x2::tx_context::digest(arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OwnershipTransferInitiated>(v3);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_grace_period_active(arg0: &StakingConfig, arg1: &0x2::clock::Clock) : bool {
        is_in_grace_period(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun is_in_grace_period(arg0: &StakingConfig, arg1: u64) : bool {
        arg1 <= arg0.grace_period_end_timestamp_ms
    }

    public fun is_owner(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: &mut StakingConfig, arg3: &mut UserStakeRegistry, arg4: &mut StakingVault, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        emit_function_call(b"migrate", 0x2::tx_context::sender(arg6), arg5, arg6);
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg6)), 1401);
        arg1.version = 2;
        arg2.version = 2;
        arg3.version = 2;
        arg4.version = 2;
        let v0 = MigrationEvent{
            migrated_to_version : 2,
            migrated_by         : 0x2::tx_context::sender(arg6),
            timestamp           : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MigrationEvent>(v0);
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    entry fun pause_contract(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"pause_contract", v0, arg3, arg4);
        ensure_not_paused(arg1);
        assert!(is_owner(arg2, v0), 1401);
        arg1.active = false;
        let v1 = ContractPaused{
            paused_by : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
            tx_digest : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractPaused>(v1);
    }

    entry fun remove_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"remove_admin", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1401);
        assert!(arg2 != @0x0, 1200);
        assert!(0x2::vec_set::size<address>(&arg1.admins) > 0, 1101);
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1000);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
        let v1 = AdminRemoved{
            admin_address      : arg2,
            removed_by         : v0,
            total_admins_after : 0x2::vec_set::size<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminRemoved>(v1);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 1800);
        arg0 + arg1
    }

    fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1801);
        arg0 - arg1
    }

    entry fun set_staking_status(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"set_staking_status", v0, arg4, arg5);
        arg1.staking_active = arg3;
        let v1 = StakingStatusChanged{
            changed_by      : v0,
            staking_enabled : arg3,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
            tx_digest       : *0x2::tx_context::digest(arg5),
        };
        0x2::event::emit<StakingStatusChanged>(v1);
    }

    entry fun stake(arg0: &mut StakingConfig, arg1: &mut UserStakeRegistry, arg2: &mut StakingVault, arg3: &AdminRegistry, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg3, arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x2::coin::value<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&arg6);
        emit_function_call(b"stake", v0, arg7, arg8);
        ensure_not_paused(arg0);
        ensure_staking_active(arg0);
        assert!(arg5 > 0, 1004);
        assert!(arg5 <= v2, 1003);
        assert!(validate_lock_period(arg4), 1505);
        if (!is_in_grace_period(arg0, v1)) {
            assert!(arg4 == 0, 1505);
        };
        assert!(get_user_role(arg3, v0) == 0, 1402);
        assert!(arg5 >= arg0.min_stake, 1500);
        assert!(arg5 <= arg0.max_stake, 1501);
        let v3 = if (arg5 == v2) {
            0x2::coin::into_balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(arg6)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>>(0x2::coin::split<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&mut arg6, v2 - arg5, arg8), v0);
            0x2::coin::into_balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(arg6)
        };
        if (!0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg1.user_stakes, v0)) {
            0x2::table::add<address, 0x2::table::Table<u64, UserStake>>(&mut arg1.user_stakes, v0, 0x2::table::new<u64, UserStake>(arg8));
            0x2::table::add<address, u64>(&mut arg1.user_stake_counts, v0, 0);
            0x2::table_vec::push_back<address>(&mut arg1.all_stakers, v0);
        };
        let v4 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, UserStake>>(&mut arg1.user_stakes, v0);
        let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_stake_counts, v0);
        assert!(*v5 < 18446744073709551615, 1509);
        *v5 = safe_add(*v5, 1);
        let v6 = *v5;
        let v7 = UserStake{
            id             : 0x2::object::new(arg8),
            staker         : v0,
            amount         : arg5,
            stake_date     : v1,
            lock_period_ms : arg4,
            claimed        : false,
            stake_id       : v6,
            is_admin_stake : false,
        };
        0x2::table::add<u64, UserStake>(v4, v6, v7);
        arg0.total_staked = safe_add(arg0.total_staked, arg5);
        arg1.total_user_stakes = safe_add(arg1.total_user_stakes, 1);
        arg2.user_locked = safe_add(arg2.user_locked, arg5);
        0x2::balance::join<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&mut arg2.balance, v3);
        let v8 = UserStakeEvent{
            staker         : v0,
            amount         : arg5,
            stake_date     : v1,
            lock_period_ms : arg4,
            stake_id       : v6,
            is_admin_stake : false,
            timestamp      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UserStakeEvent>(v8);
    }

    entry fun unpause_contract(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"unpause_contract", v0, arg3, arg4);
        ensure_paused(arg1);
        assert!(is_owner(arg2, v0), 1401);
        arg1.active = true;
        let v1 = ContractUnpaused{
            unpaused_by : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            tx_digest   : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractUnpaused>(v1);
    }

    entry fun unstake(arg0: &mut UserStakeRegistry, arg1: &mut StakingVault, arg2: &mut StakingConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_registry_vault(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        emit_function_call(b"unstake", v0, arg4, arg5);
        ensure_not_paused(arg2);
        assert!(arg3 > 0, 1007);
        assert!(0x2::table::contains<address, 0x2::table::Table<u64, UserStake>>(&arg0.user_stakes, v0), 1502);
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, UserStake>>(&mut arg0.user_stakes, v0);
        assert!(0x2::table::contains<u64, UserStake>(v2, arg3), 1502);
        let v3 = 0x2::table::borrow_mut<u64, UserStake>(v2, arg3);
        assert!(!v3.claimed, 1504);
        assert!(v3.staker == v0, 1401);
        assert!(v1 >= safe_add(v3.lock_period_ms, v3.stake_date), 1503);
        let v4 = v3.amount;
        assert!(v4 > 0, 1004);
        assert!(0x2::balance::value<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&arg1.balance) >= v4, 1600);
        v3.claimed = true;
        arg2.total_staked = safe_sub(arg2.total_staked, v4);
        if (v3.is_admin_stake) {
            assert!(arg1.admin_locked >= v4, 1602);
            arg1.admin_locked = safe_sub(arg1.admin_locked, v4);
        } else {
            assert!(arg1.user_locked >= v4, 1601);
            arg1.user_locked = safe_sub(arg1.user_locked, v4);
        };
        let v5 = UserUnstakeEvent{
            staker       : v0,
            amount       : v4,
            unstake_date : v1,
            stake_id     : arg3,
        };
        0x2::event::emit<UserUnstakeEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>>(0x2::coin::from_balance<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(0x2::balance::split<0xf8f45cbf1c485a4608b30a1a9d7ff744777fcb2a8f2d643fe604b18e389a625f::bruno::BRUNO>(&mut arg1.balance, v4), arg5), v0);
    }

    fun update_grace_period(arg0: address, arg1: &mut StakingConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 >= 1755648000000 && arg2 <= 1761695999000, 1008);
        arg1.grace_period_end_timestamp_ms = arg2;
        let v0 = GracePeriodUpdated{
            old_grace_period_ms : arg1.grace_period_end_timestamp_ms,
            new_grace_period_ms : arg2,
            updated_by          : arg0,
            tx_digest           : *0x2::tx_context::digest(arg4),
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GracePeriodUpdated>(v0);
    }

    entry fun update_grace_period_by_admin(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"update_grace_period_by_admin", v0, arg4, arg5);
        assert!(is_admin(arg2, v0), 1000);
        update_grace_period(v0, arg1, arg3, arg4, arg5);
    }

    entry fun update_grace_period_by_owner(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"update_grace_period_by_owner", v0, arg4, arg5);
        assert!(is_owner(arg2, v0), 1401);
        update_grace_period(v0, arg1, arg3, arg4, arg5);
    }

    fun update_staking_limits(arg0: address, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1004);
        assert!(arg3 >= arg2, 1002);
        arg1.min_stake = arg2;
        arg1.max_stake = arg3;
        let v0 = StakingConfigUpdated{
            min_stake  : arg2,
            max_stake  : arg3,
            updated_by : arg0,
            tx_digest  : *0x2::tx_context::digest(arg5),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    entry fun update_staking_limits_by_admin(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"update_staking_limits_by_admin", v0, arg5, arg6);
        assert!(is_admin(arg2, v0), 1000);
        update_staking_limits(v0, arg1, arg3, arg4, arg5, arg6);
    }

    entry fun update_staking_limits_by_owner(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &AdminRegistry, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"update_staking_limits_by_owner", v0, arg5, arg6);
        assert!(is_owner(arg2, v0), 1401);
        update_staking_limits(v0, arg1, arg3, arg4, arg5, arg6);
    }

    fun validate_admin_stake_dates(arg0: &StakingConfig, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg2, 1506);
        assert!(arg1 >= arg0.deployment_time, 1506);
        let v0 = arg0.grace_period_end_timestamp_ms;
        assert!(arg1 <= v0, 1506);
        assert!(arg2 < safe_add(v0, 864000000), 1507);
        assert!(arg3 != 0, 1508);
    }

    fun validate_lock_period(arg0: u64) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 7862400000) {
            true
        } else if (arg0 == 15724800000) {
            true
        } else if (arg0 == 23673600000) {
            true
        } else {
            arg0 == 31536000000
        }
    }

    // decompiled from Move bytecode v6
}

