module 0x5f4cae1f41f5f4021413f26c0e9f0fc48c9235e20bbb8a27b831d7d54124d4f5::merkle_rewards {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct MerkleAdminCap has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pending_transfer: 0x1::option::Option<PendingOwnershipTransfer>,
        admins: 0x2::vec_set::VecSet<address>,
        max_admins: u64,
        merkle_admin: address,
    }

    struct PendingOwnershipTransfer has drop, store {
        new_owner: address,
        initiated_at: u64,
        expires_at: u64,
    }

    struct RewardsConfig has key {
        id: 0x2::object::UID,
        version: u64,
        merkle_root: vector<u8>,
        current_epoch: u64,
        active: bool,
        total_distributed: u64,
        total_claims: u64,
    }

    struct ClaimRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        user_claims: 0x2::table::Table<address, 0x2::table::Table<u64, u64>>,
        all_users_with_claims: 0x2::table_vec::TableVec<address>,
        user_stake_ids: 0x2::table::Table<address, 0x2::table_vec::TableVec<u64>>,
        total_users_count: u64,
    }

    struct RewardsVault has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>,
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

    struct CapabilityMigrated has copy, drop {
        capability_type: 0x1::ascii::String,
        migrated_by: address,
        new_version: u64,
        tx_digest: vector<u8>,
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

    struct MerkleAdminAdded has copy, drop {
        merkle_admin_address: address,
        added_by: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct MerkleRootUpdated has copy, drop {
        old_epoch: u64,
        new_epoch: u64,
        old_root: vector<u8>,
        new_root: vector<u8>,
        updated_by: address,
        timestamp: u64,
        rewards_date: u64,
        tx_digest: vector<u8>,
    }

    struct RewardClaimed has copy, drop {
        user: address,
        stake_id: u64,
        amount_claimed: u64,
        cumulative_entitled: u64,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct CapabilityDestroyed has copy, drop {
        capability_type: 0x1::ascii::String,
        destroyed_by: address,
        tx_digest: vector<u8>,
        timestamp: u64,
    }

    struct VaultDeposit has copy, drop {
        deposited_by: address,
        amount: u64,
        new_balance: u64,
        rewards_date: u64,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct VaultTopup has copy, drop {
        topped_up_by: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct VaultWithdrawal has copy, drop {
        withdrawn_by: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    entry fun accept_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1700);
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_ownership_transfer", v0, arg1, arg2);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1200);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        assert!(v0 == v1.new_owner, 1202);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.expires_at, 1201);
        arg0.owner = v0;
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"escrowed_owner_cap"), 1005);
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
        check_owner_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"add_admin", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1300);
        assert!(arg2 != @0x0, 1004);
        assert!(arg2 != v0, 1301);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1103);
        assert!(!is_merkle_admin(arg1, arg2), 1103);
        assert!(0x2::vec_set::length<address>(&arg1.admins) < arg1.max_admins, 1101);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
        let v1 = AdminCap{
            id      : 0x2::object::new(arg4),
            version : 1,
        };
        0x2::transfer::transfer<AdminCap>(v1, arg2);
        let v2 = AdminAdded{
            admin_address      : arg2,
            added_by           : v0,
            total_admins_after : 0x2::vec_set::length<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminAdded>(v2);
    }

    entry fun cancel_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1700);
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"cancel_ownership_transfer", v0, arg1, arg2);
        assert!(is_owner(arg0, v0), 1300);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1200);
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

    entry fun change_merkle_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        check_owner_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"change_merkle_admin", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1300);
        assert!(arg2 != v0, 1301);
        assert!(!is_admin(arg1, arg2), 1103);
        assert!(!is_merkle_admin(arg1, arg2), 1104);
        arg1.merkle_admin = arg2;
        if (arg2 != @0x0) {
            let v1 = MerkleAdminCap{
                id      : 0x2::object::new(arg4),
                version : 1,
            };
            0x2::transfer::transfer<MerkleAdminCap>(v1, arg2);
        };
        let v2 = MerkleAdminAdded{
            merkle_admin_address : arg2,
            added_by             : v0,
            tx_digest            : *0x2::tx_context::digest(arg4),
            timestamp            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MerkleAdminAdded>(v2);
    }

    fun check_admin_cap_version(arg0: &AdminCap) {
        assert!(arg0.version == 1, 1700);
    }

    fun check_merkle_admin_cap_version(arg0: &MerkleAdminCap) {
        assert!(arg0.version == 1, 1700);
    }

    fun check_owner_cap_version(arg0: &OwnerCap) {
        assert!(arg0.version == 1, 1700);
    }

    fun check_version_admin_config(arg0: &AdminRegistry, arg1: &RewardsConfig) {
        assert!(arg0.version == 1, 1700);
        assert!(arg1.version == 1, 1700);
    }

    fun check_version_admin_registry(arg0: &AdminRegistry) {
        assert!(arg0.version == 1, 1700);
    }

    fun check_version_claim_operations(arg0: &RewardsConfig, arg1: &ClaimRegistry, arg2: &RewardsVault) {
        assert!(arg0.version == 1, 1700);
        assert!(arg1.version == 1, 1700);
        assert!(arg2.version == 1, 1700);
    }

    fun check_version_vault_operations(arg0: &AdminRegistry, arg1: &RewardsVault) {
        assert!(arg0.version == 1, 1700);
        assert!(arg1.version == 1, 1700);
    }

    entry fun claim_rewards(arg0: &mut RewardsConfig, arg1: &mut ClaimRegistry, arg2: &mut RewardsVault, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version_claim_operations(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg8);
        emit_function_call(b"claim_rewards", v0, arg7, arg8);
        ensure_not_paused(arg0);
        assert!(arg6 == arg0.current_epoch, 1701);
        assert!(arg3 > 0, 1403);
        assert!(arg4 > 0, 1003);
        let v1 = get_claimed_amount(arg1, v0, arg3);
        assert!(arg4 > v1, 1404);
        let v2 = safe_sub(arg4, v1);
        assert!(v2 > 0, 1404);
        assert!(0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg2.balance) >= v2, 1502);
        assert!(verify_merkle_proof(arg5, arg0.merkle_root, create_leaf_hash(v0, arg3, arg4)), 1400);
        if (!0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg1.user_claims, v0)) {
            0x2::table::add<address, 0x2::table::Table<u64, u64>>(&mut arg1.user_claims, v0, 0x2::table::new<u64, u64>(arg8));
            0x2::table_vec::push_back<address>(&mut arg1.all_users_with_claims, v0);
            0x2::table::add<address, 0x2::table_vec::TableVec<u64>>(&mut arg1.user_stake_ids, v0, 0x2::table_vec::empty<u64>(arg8));
            arg1.total_users_count = safe_add(arg1.total_users_count, 1);
        };
        let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, u64>>(&mut arg1.user_claims, v0);
        if (!0x2::table::contains<u64, u64>(v3, arg3)) {
            0x2::table::add<u64, u64>(v3, arg3, arg4);
            0x2::table_vec::push_back<u64>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<u64>>(&mut arg1.user_stake_ids, v0), arg3);
        } else {
            *0x2::table::borrow_mut<u64, u64>(v3, arg3) = arg4;
        };
        arg0.total_distributed = safe_add(arg0.total_distributed, v2);
        arg0.total_claims = safe_add(arg0.total_claims, 1);
        let v4 = RewardClaimed{
            user                : v0,
            stake_id            : arg3,
            amount_claimed      : v2,
            cumulative_entitled : arg4,
            timestamp           : 0x2::clock::timestamp_ms(arg7),
            tx_digest           : *0x2::tx_context::digest(arg8),
        };
        0x2::event::emit<RewardClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(0x2::coin::from_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(0x2::balance::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg2.balance, v2), arg8), v0);
    }

    fun compare_hashes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 == 32, 1401);
        assert!(0x1::vector::length<u8>(arg1) == 32, 1401);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = *0x1::vector::borrow<u8>(arg1, v1);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v1 = v1 + 1;
        };
        false
    }

    fun create_leaf_hash(arg0: address, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&v0)
    }

    entry fun deposit_to_vault(arg0: &AdminCap, arg1: &mut RewardsVault, arg2: &AdminRegistry, arg3: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version_vault_operations(arg2, arg1);
        check_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        emit_function_call(b"deposit_to_vault", v0, arg6, arg7);
        assert!(is_admin(arg2, v0), 1100);
        assert!(arg4 > 0, 1003);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 <= v1, 1405);
        assert!(v1 - arg5 <= 2592000000, 1405);
        let v2 = process_coin_deposit(arg3, arg4, v0, arg7);
        0x2::balance::join<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg1.balance, v2);
        let v3 = VaultDeposit{
            deposited_by : v0,
            amount       : arg4,
            new_balance  : 0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1.balance),
            rewards_date : arg5,
            timestamp    : v1,
            tx_digest    : *0x2::tx_context::digest(arg7),
        };
        0x2::event::emit<VaultDeposit>(v3);
    }

    entry fun destroy_old_admin_cap(arg0: AdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_admin_cap", v0, arg2, arg3);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &v0), 1103);
        let AdminCap {
            id      : v1,
            version : _,
        } = arg0;
        0x2::object::delete(v1);
        let v3 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"AdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CapabilityDestroyed>(v3);
    }

    entry fun destroy_old_merkle_admin_cap(arg0: MerkleAdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_merkle_admin_cap", v0, arg2, arg3);
        assert!(!is_merkle_admin(arg1, v0), 1104);
        let MerkleAdminCap {
            id      : v1,
            version : _,
        } = arg0;
        0x2::object::delete(v1);
        let v3 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"MerkleAdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CapabilityDestroyed>(v3);
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

    fun ensure_not_paused(arg0: &RewardsConfig) {
        assert!(arg0.active, 1500);
    }

    fun ensure_paused(arg0: &RewardsConfig) {
        assert!(!arg0.active, 1501);
    }

    public fun get_all_admins(arg0: &AdminRegistry) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.admins)
    }

    public fun get_all_users_with_claims_paginated(arg0: &ClaimRegistry, arg1: u64, arg2: u64) : (vector<address>, bool) {
        let v0 = 0x2::table_vec::length<address>(&arg0.all_users_with_claims);
        assert!(arg2 > 0 && arg2 <= 100, 1001);
        assert!(arg1 <= v0, 1007);
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (arg1 + arg2 > v0) {
            v0
        } else {
            arg1 + arg2
        };
        while (arg1 < v2) {
            0x1::vector::push_back<address>(&mut v1, *0x2::table_vec::borrow<address>(&arg0.all_users_with_claims, arg1));
            arg1 = arg1 + 1;
        };
        (v1, v2 < v0)
    }

    public fun get_batch_stakes_claims_detailed(arg0: &ClaimRegistry, arg1: address, arg2: vector<u64>, arg3: vector<u64>) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 1008);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        if (0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg0.user_claims, arg1)) {
            let v5 = 0x2::table::borrow<address, 0x2::table::Table<u64, u64>>(&arg0.user_claims, arg1);
            while (v4 < 0x1::vector::length<u64>(&arg2)) {
                let v6 = *0x1::vector::borrow<u64>(&arg2, v4);
                let v7 = *0x1::vector::borrow<u64>(&arg3, v4);
                let v8 = if (0x2::table::contains<u64, u64>(v5, v6)) {
                    *0x2::table::borrow<u64, u64>(v5, v6)
                } else {
                    0
                };
                let v9 = if (v7 > v8) {
                    v7 - v8
                } else {
                    0
                };
                0x1::vector::push_back<u64>(&mut v0, v6);
                0x1::vector::push_back<u64>(&mut v1, v7);
                0x1::vector::push_back<u64>(&mut v2, v8);
                0x1::vector::push_back<u64>(&mut v3, v9);
                v4 = v4 + 1;
            };
        } else {
            while (v4 < 0x1::vector::length<u64>(&arg2)) {
                let v10 = *0x1::vector::borrow<u64>(&arg3, v4);
                0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(&arg2, v4));
                0x1::vector::push_back<u64>(&mut v1, v10);
                0x1::vector::push_back<u64>(&mut v2, 0);
                0x1::vector::push_back<u64>(&mut v3, v10);
                v4 = v4 + 1;
            };
        };
        (v0, v1, v2, v3)
    }

    public fun get_claimed_amount(arg0: &ClaimRegistry, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, u64>>(&arg0.user_claims, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, u64>>(&arg0.user_claims, arg1);
        if (!0x2::table::contains<u64, u64>(v0, arg2)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(v0, arg2)
    }

    public fun get_contract_stats(arg0: &RewardsConfig, arg1: &RewardsVault, arg2: &ClaimRegistry) : (u64, u64, u64, u64, bool) {
        (arg0.total_distributed, arg0.total_claims, 0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1.balance), arg2.total_users_count, arg0.active)
    }

    public fun get_merkle_admin(arg0: &AdminRegistry) : address {
        arg0.merkle_admin
    }

    public fun get_migration_status(arg0: &AdminRegistry, arg1: &RewardsConfig, arg2: &ClaimRegistry, arg3: &RewardsVault) : (u64, bool, u64, u64, u64, u64, bool) {
        let v0 = if (arg0.version == 1) {
            if (arg1.version == 1) {
                if (arg2.version == 1) {
                    arg3.version == 1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        (1, v0, arg0.version, arg1.version, arg2.version, arg3.version, arg1.active)
    }

    public fun get_owner(arg0: &AdminRegistry) : address {
        arg0.owner
    }

    public fun get_rewards_config(arg0: &RewardsConfig) : (vector<u8>, bool, u64, u64, u64) {
        (arg0.merkle_root, arg0.active, arg0.total_distributed, arg0.total_claims, arg0.current_epoch)
    }

    public fun get_total_users_with_claims_count(arg0: &ClaimRegistry) : u64 {
        arg0.total_users_count
    }

    public fun get_user_claimed_stake_ids(arg0: &ClaimRegistry, arg1: address) : vector<u64> {
        if (!0x2::table::contains<address, 0x2::table_vec::TableVec<u64>>(&arg0.user_stake_ids, arg1)) {
            return 0x1::vector::empty<u64>()
        };
        let v0 = 0x2::table::borrow<address, 0x2::table_vec::TableVec<u64>>(&arg0.user_stake_ids, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x2::table_vec::length<u64>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, *0x2::table_vec::borrow<u64>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_vault_balance(arg0: &RewardsVault) : u64 {
        0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminRegistry{
            id               : 0x2::object::new(arg0),
            version          : 1,
            owner            : v0,
            pending_transfer : 0x1::option::none<PendingOwnershipTransfer>(),
            admins           : 0x2::vec_set::empty<address>(),
            max_admins       : 2,
            merkle_admin     : v0,
        };
        let v2 = RewardsConfig{
            id                : 0x2::object::new(arg0),
            version           : 1,
            merkle_root       : 0x1::vector::empty<u8>(),
            current_epoch     : 0,
            active            : true,
            total_distributed : 0,
            total_claims      : 0,
        };
        let v3 = ClaimRegistry{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            user_claims           : 0x2::table::new<address, 0x2::table::Table<u64, u64>>(arg0),
            all_users_with_claims : 0x2::table_vec::empty<address>(arg0),
            user_stake_ids        : 0x2::table::new<address, 0x2::table_vec::TableVec<u64>>(arg0),
            total_users_count     : 0,
        };
        let v4 = RewardsVault{
            id      : 0x2::object::new(arg0),
            version : 1,
            balance : 0x2::balance::zero<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(),
        };
        let v5 = OwnerCap{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::transfer<OwnerCap>(v5, v0);
        let v6 = MerkleAdminCap{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::transfer<MerkleAdminCap>(v6, v0);
        0x2::transfer::share_object<AdminRegistry>(v1);
        0x2::transfer::share_object<RewardsConfig>(v2);
        0x2::transfer::share_object<ClaimRegistry>(v3);
        0x2::transfer::share_object<RewardsVault>(v4);
    }

    entry fun initiate_ownership_transfer(arg0: OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        check_owner_cap_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"initiate_ownership_transfer", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1300);
        assert!(arg2 != @0x0, 1004);
        assert!(arg2 != v0, 1000);
        assert!(!is_admin(arg1, arg2), 1006);
        assert!(!is_merkle_admin(arg1, arg2), 1006);
        assert!(0x1::option::is_none<PendingOwnershipTransfer>(&arg1.pending_transfer), 1203);
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

    public fun is_merkle_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.merkle_admin == arg1
    }

    public fun is_owner(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: &mut RewardsConfig, arg3: &mut ClaimRegistry, arg4: &mut RewardsVault, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.version < 1, 1700);
        ensure_paused(arg2);
        emit_function_call(b"migrate", 0x2::tx_context::sender(arg6), arg5, arg6);
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg6)), 1300);
        assert!(arg1.version < 1, 1700);
        arg1.version = 1;
        arg2.version = 1;
        arg3.version = 1;
        arg4.version = 1;
        let v0 = MigrationEvent{
            migrated_to_version : 1,
            migrated_by         : 0x2::tx_context::sender(arg6),
            timestamp           : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MigrationEvent>(v0);
    }

    entry fun migrate_admin_cap(arg0: &mut AdminCap, arg1: &AdminRegistry, arg2: &RewardsConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        ensure_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"migrate_admin_cap", v0, arg3, arg4);
        assert!(is_admin(arg1, v0), 1100);
        assert!(arg0.version < 1, 1700);
        arg0.version = 1;
        let v1 = CapabilityMigrated{
            capability_type : 0x1::ascii::string(b"AdminCap"),
            migrated_by     : v0,
            new_version     : 1,
            tx_digest       : *0x2::tx_context::digest(arg4),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapabilityMigrated>(v1);
    }

    entry fun migrate_merkle_admin_cap(arg0: &mut MerkleAdminCap, arg1: &AdminRegistry, arg2: &RewardsConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        ensure_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"migrate_merkle_admin_cap", v0, arg3, arg4);
        assert!(is_merkle_admin(arg1, v0), 1100);
        assert!(arg0.version < 1, 1700);
        arg0.version = 1;
        let v1 = CapabilityMigrated{
            capability_type : 0x1::ascii::string(b"MerkleAdminCap"),
            migrated_by     : v0,
            new_version     : 1,
            tx_digest       : *0x2::tx_context::digest(arg4),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapabilityMigrated>(v1);
    }

    entry fun migrate_owner_cap(arg0: &mut OwnerCap, arg1: &AdminRegistry, arg2: &RewardsConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        ensure_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"migrate_owner_cap", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1300);
        assert!(arg0.version < 1, 1700);
        arg0.version = 1;
        let v1 = CapabilityMigrated{
            capability_type : 0x1::ascii::string(b"OwnerCap"),
            migrated_by     : v0,
            new_version     : 1,
            tx_digest       : *0x2::tx_context::digest(arg4),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapabilityMigrated>(v1);
    }

    entry fun pause_contract_by_merkle_admin(arg0: &MerkleAdminCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        check_merkle_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"pause_contract_by_merkle_admin", v0, arg3, arg4);
        ensure_not_paused(arg1);
        assert!(is_merkle_admin(arg2, v0), 1100);
        arg1.active = false;
        let v1 = ContractPaused{
            paused_by : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
            tx_digest : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractPaused>(v1);
    }

    entry fun pause_contract_by_owner(arg0: &OwnerCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version <= 1, 1700);
        assert!(arg1.version <= 1, 1700);
        assert!(arg0.version <= 1, 1700);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"pause_contract_by_owner", v0, arg3, arg4);
        ensure_not_paused(arg1);
        assert!(is_owner(arg2, v0), 1300);
        arg1.active = false;
        let v1 = ContractPaused{
            paused_by : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
            tx_digest : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractPaused>(v1);
    }

    fun process_coin_deposit(arg0: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI> {
        let v0 = 0x2::coin::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg0);
        assert!(arg1 <= v0, 1002);
        if (arg1 == v0) {
            0x2::coin::into_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(arg0)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(0x2::coin::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg0, safe_sub(v0, arg1), arg3), arg2);
            0x2::coin::into_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(arg0)
        }
    }

    entry fun remove_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_registry(arg1);
        check_owner_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"remove_admin", v0, arg3, arg4);
        assert!(is_owner(arg1, v0), 1300);
        assert!(arg2 != @0x0, 1004);
        assert!(0x2::vec_set::length<address>(&arg1.admins) > 0, 1102);
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1100);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
        let v1 = AdminRemoved{
            admin_address      : arg2,
            removed_by         : v0,
            total_admins_after : 0x2::vec_set::length<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminRemoved>(v1);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 1600);
        arg0 + arg1
    }

    fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1601);
        arg0 - arg1
    }

    entry fun topup_vault(arg0: &AdminCap, arg1: &mut RewardsVault, arg2: &AdminRegistry, arg3: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version_vault_operations(arg2, arg1);
        check_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"topup_vault", v0, arg5, arg6);
        assert!(is_admin(arg2, v0), 1100);
        assert!(arg4 > 0, 1003);
        let v1 = process_coin_deposit(arg3, arg4, v0, arg6);
        0x2::balance::join<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg1.balance, v1);
        let v2 = VaultTopup{
            topped_up_by : v0,
            amount       : arg4,
            new_balance  : 0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1.balance),
            timestamp    : 0x2::clock::timestamp_ms(arg5),
            tx_digest    : *0x2::tx_context::digest(arg6),
        };
        0x2::event::emit<VaultTopup>(v2);
    }

    entry fun unpause_contract_by_merkle_admin(arg0: &MerkleAdminCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        check_merkle_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"unpause_contract_by_merkle_admin", v0, arg3, arg4);
        ensure_paused(arg1);
        assert!(is_merkle_admin(arg2, v0), 1100);
        arg1.active = true;
        let v1 = ContractUnpaused{
            unpaused_by : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            tx_digest   : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractUnpaused>(v1);
    }

    entry fun unpause_contract_by_owner(arg0: &OwnerCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        check_owner_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"unpause_contract_by_owner", v0, arg3, arg4);
        ensure_paused(arg1);
        assert!(is_owner(arg2, v0), 1300);
        arg1.active = true;
        let v1 = ContractUnpaused{
            unpaused_by : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            tx_digest   : *0x2::tx_context::digest(arg4),
        };
        0x2::event::emit<ContractUnpaused>(v1);
    }

    fun update_merkle_root(arg0: &mut RewardsConfig, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        ensure_paused(arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1406);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 <= v0, 1405);
        assert!(v0 - arg3 <= 2592000000, 1405);
        let v1 = arg0.current_epoch;
        arg0.current_epoch = safe_add(v1, 1);
        arg0.merkle_root = arg1;
        let v2 = MerkleRootUpdated{
            old_epoch    : v1,
            new_epoch    : arg0.current_epoch,
            old_root     : arg0.merkle_root,
            new_root     : arg1,
            updated_by   : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            rewards_date : arg3,
            tx_digest    : *0x2::tx_context::digest(arg5),
        };
        0x2::event::emit<MerkleRootUpdated>(v2);
    }

    entry fun update_merkle_root_by_admin(arg0: &AdminCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        check_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"update_merkle_root", v0, arg5, arg6);
        assert!(is_admin(arg2, v0), 1100);
        update_merkle_root(arg1, arg3, v0, arg4, arg5, arg6);
    }

    entry fun update_merkle_root_by_merkle_admin(arg0: &MerkleAdminCap, arg1: &mut RewardsConfig, arg2: &AdminRegistry, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version_admin_config(arg2, arg1);
        check_merkle_admin_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"update_merkle_root_by_merkle_admin", v0, arg5, arg6);
        assert!(is_merkle_admin(arg2, v0), 1100);
        update_merkle_root(arg1, arg3, v0, arg4, arg5, arg6);
    }

    fun verify_merkle_proof(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        assert!(0x1::vector::length<vector<u8>>(&arg0) <= 20, 1402);
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg0, v1);
            let v3 = if (compare_hashes(&v0, &v2)) {
                let v4 = v0;
                0x1::vector::append<u8>(&mut v4, v2);
                v4
            } else {
                0x1::vector::append<u8>(&mut v2, v0);
                v2
            };
            let v5 = v3;
            v0 = 0x2::hash::keccak256(&v5);
            v1 = v1 + 1;
        };
        v0 == arg1
    }

    entry fun withdraw_from_vault(arg0: &OwnerCap, arg1: &mut RewardsVault, arg2: &AdminRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_vault_operations(arg2, arg1);
        check_owner_cap_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"withdraw_from_vault", v0, arg4, arg5);
        assert!(is_owner(arg2, v0), 1300);
        assert!(arg3 > 0, 1003);
        assert!(0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1.balance) >= arg3, 1502);
        let v1 = VaultWithdrawal{
            withdrawn_by : v0,
            amount       : arg3,
            new_balance  : 0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1.balance),
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            tx_digest    : *0x2::tx_context::digest(arg5),
        };
        0x2::event::emit<VaultWithdrawal>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(0x2::coin::from_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(0x2::balance::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg1.balance, arg3), arg5), v0);
    }

    // decompiled from Move bytecode v6
}

