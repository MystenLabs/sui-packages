module 0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        fee_recipient: address,
        deposit_fee_bps: u64,
        mgmt_fee_bps: u64,
        redeem_fee_bps: u64,
        share_price: u128,
        total_shares: u64,
        pending_deposit: 0x2::balance::Balance<T0>,
        claim_reserve: 0x2::balance::Balance<T0>,
        rcusdp_custody: 0x2::balance::Balance<T1>,
        pending_redeem_rcusdp: 0x2::balance::Balance<T1>,
        last_deposit_settle_ms: u64,
        last_redeem_settle_ms: u64,
        settle_interval_ms: u64,
        paused: bool,
        accumulated_mgmt_fee: u64,
        last_mgmt_fee_ms: u64,
        instant_redeem_fee_bps: u64,
        reserve_fund: 0x2::balance::Balance<T0>,
        instant_redeem_enabled: bool,
        withdraw_fee_bps: u64,
        cancel_deposit_fee_bps: u64,
        cancel_deposit_enabled: bool,
        withdraw_rcusdp_enabled: bool,
        redeem_settled: bool,
    }

    struct VaultRoleStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRoleState has store {
        pending_admin: address,
        pending_admin_effective_ms: u64,
        pending_operator: address,
        pending_operator_effective_ms: u64,
        role_change_delay_ms: u64,
    }

    struct PendingDeposits<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
        users: vector<address>,
    }

    struct PendingRedeems<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
        users: vector<address>,
    }

    struct Claims<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
    }

    struct Balances<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
    }

    struct VaultTypeConfig has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        usdc_type: 0x1::type_name::TypeName,
        rcusdp_type: 0x1::type_name::TypeName,
    }

    struct DepositSettlementState has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        active: bool,
    }

    struct UserRecord has copy, drop, store {
        record_id: u64,
        action: u8,
        amount: u64,
        fee: u64,
        shares: u64,
        status: u8,
        created_at: u64,
        settled_at: u64,
        related_record_id: u64,
    }

    struct RecordIndexKey has copy, drop, store {
        user: address,
        record_id: u64,
    }

    struct UserRecords has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        records: 0x2::table::Table<address, vector<UserRecord>>,
        next_record_id: u64,
    }

    public(friend) fun accept_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        let v0 = role_state<T0, T1>(arg0);
        assert!(v0.pending_admin != @0x0, 11);
        assert!(0x2::tx_context::sender(arg2) == v0.pending_admin, 18);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.pending_admin_effective_ms, 12);
        let v1 = arg0.admin;
        let v2 = v0.pending_admin;
        arg0.admin = v2;
        let v3 = role_state_mut<T0, T1>(arg0);
        v3.pending_admin = @0x0;
        v3.pending_admin_effective_ms = 0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_change_completed(v1, v2);
    }

    public(friend) fun accept_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        let v0 = role_state<T0, T1>(arg0);
        assert!(v0.pending_operator != @0x0, 11);
        assert!(0x2::tx_context::sender(arg2) == v0.pending_operator, 17);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.pending_operator_effective_ms, 12);
        let v1 = arg0.operator;
        let v2 = v0.pending_operator;
        arg0.operator = v2;
        let v3 = role_state_mut<T0, T1>(arg0);
        v3.pending_operator = @0x0;
        v3.pending_operator_effective_ms = 0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_operator_change_completed(v1, v2);
    }

    fun add_user_record(arg0: &mut UserRecords, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = arg0.next_record_id;
        arg0.next_record_id = v0 + 1;
        let v1 = if (arg6 == 1) {
            arg7
        } else {
            0
        };
        let v2 = UserRecord{
            record_id         : v0,
            action            : arg2,
            amount            : arg3,
            fee               : arg4,
            shares            : arg5,
            status            : arg6,
            created_at        : arg7,
            settled_at        : v1,
            related_record_id : arg8,
        };
        let v3 = if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v4 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
            0x1::vector::push_back<UserRecord>(v4, v2);
            0x1::vector::length<UserRecord>(v4)
        } else {
            let v5 = 0x1::vector::empty<UserRecord>();
            0x1::vector::push_back<UserRecord>(&mut v5, v2);
            0x2::table::add<address, vector<UserRecord>>(&mut arg0.records, arg1, v5);
            0
        };
        let v6 = RecordIndexKey{
            user      : arg1,
            record_id : v0,
        };
        0x2::dynamic_field::add<RecordIndexKey, u64>(&mut arg0.id, v6, v3);
        v0
    }

    public(friend) fun admin_fix_balance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Balances<T1>, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_balances<T0, T1>(arg0, arg1);
        only_admin<T0, T1>(arg0, arg4);
        let v0 = if (0x2::table::contains<address, u64>(&arg1.amounts, arg2)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, arg2)
        } else {
            0
        };
        if (arg3 == 0 && v0 > 0) {
            0x2::table::remove<address, u64>(&mut arg1.amounts, arg2);
        } else if (arg3 > 0) {
            if (0x2::table::contains<address, u64>(&arg1.amounts, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, arg2) = arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg1.amounts, arg2, arg3);
            };
        };
        if (arg3 > v0) {
            arg0.total_shares = arg0.total_shares + arg3 - v0;
        } else if (v0 > arg3) {
            arg0.total_shares = arg0.total_shares - v0 - arg3;
        };
        let v1 = if (arg0.total_shares == 0) {
            (1000000000000000000 as u128)
        } else {
            (0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (arg0.total_shares as u128)
        };
        arg0.share_price = v1;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_balance_fixed(arg2, v0, arg3, arg0.total_shares, arg0.share_price);
    }

    public(friend) fun admin_fix_deposit_record_status<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut UserRecords, arg2: address, arg3: u64, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_user_records<T0, T1>(arg0, arg1);
        only_admin<T0, T1>(arg0, arg5);
        assert!(0x2::table::contains<address, vector<UserRecord>>(&arg1.records, arg2), 9);
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg1.records, arg2);
        let v1 = 0x1::vector::length<UserRecord>(v0);
        let v2 = RecordIndexKey{
            user      : arg2,
            record_id : arg3,
        };
        let v3 = false;
        let v4 = 0;
        if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v2)) {
            let v5 = *0x2::dynamic_field::borrow<RecordIndexKey, u64>(&arg1.id, v2);
            if (v5 < v1) {
                let v6 = 0x1::vector::borrow_mut<UserRecord>(v0, v5);
                if (v6.record_id == arg3 && v6.action == 0) {
                    v4 = v6.status;
                    v6.status = arg4;
                    if (arg4 == 0) {
                        v6.shares = 0;
                        v6.settled_at = 0;
                    };
                    v3 = true;
                };
            };
        };
        if (!v3) {
            let v7 = 0;
            while (v7 < v1) {
                let v8 = 0x1::vector::borrow_mut<UserRecord>(v0, v7);
                if (v8.record_id == arg3 && v8.action == 0) {
                    v4 = v8.status;
                    v8.status = arg4;
                    if (arg4 == 0) {
                        v8.shares = 0;
                        v8.settled_at = 0;
                    };
                    if (!0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v2)) {
                        0x2::dynamic_field::add<RecordIndexKey, u64>(&mut arg1.id, v2, v7);
                    };
                    v3 = true;
                    break
                };
                v7 = v7 + 1;
            };
        };
        assert!(v3, 9);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_deposit_record_fixed(arg2, arg3, v4, arg4);
    }

    public(friend) fun admin_fix_pending_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_deposits<T0, T1>(arg0, arg1);
        only_admin<T0, T1>(arg0, arg4);
        let v0 = if (0x2::table::contains<address, u64>(&arg1.amounts, arg2)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, arg2)
        } else {
            0
        };
        if (arg3 == 0 && v0 > 0) {
            0x2::table::remove<address, u64>(&mut arg1.amounts, arg2);
            let (v1, v2) = 0x1::vector::index_of<address>(&arg1.users, &arg2);
            if (v1) {
                0x1::vector::remove<address>(&mut arg1.users, v2);
            };
        } else if (arg3 > 0) {
            if (0x2::table::contains<address, u64>(&arg1.amounts, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, arg2) = arg3;
            } else {
                0x2::table::add<address, u64>(&mut arg1.amounts, arg2, arg3);
                0x1::vector::push_back<address>(&mut arg1.users, arg2);
            };
        };
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_pending_deposit_fixed(arg2, v0, arg3);
    }

    public(friend) fun admin_fix_user_record_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut UserRecords, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_user_records<T0, T1>(arg0, arg1);
        only_admin<T0, T1>(arg0, arg5);
        assert!(0x2::table::contains<address, vector<UserRecord>>(&arg1.records, arg2), 9);
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg1.records, arg2);
        let v1 = 0x1::vector::length<UserRecord>(v0);
        let v2 = RecordIndexKey{
            user      : arg2,
            record_id : arg3,
        };
        let v3 = false;
        let v4 = 0;
        if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v2)) {
            let v5 = *0x2::dynamic_field::borrow<RecordIndexKey, u64>(&arg1.id, v2);
            if (v5 < v1) {
                let v6 = 0x1::vector::borrow_mut<UserRecord>(v0, v5);
                if (v6.record_id == arg3) {
                    v4 = v6.shares;
                    v6.shares = arg4;
                    v3 = true;
                };
            };
        };
        if (!v3) {
            let v7 = 0;
            while (v7 < v1) {
                let v8 = 0x1::vector::borrow_mut<UserRecord>(v0, v7);
                if (v8.record_id == arg3) {
                    v4 = v8.shares;
                    v8.shares = arg4;
                    if (!0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v2)) {
                        0x2::dynamic_field::add<RecordIndexKey, u64>(&mut arg1.id, v2, v7);
                    };
                    v3 = true;
                    break
                };
                v7 = v7 + 1;
            };
        };
        assert!(v3, 9);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_user_record_shares_fixed(arg2, arg3, v4, arg4);
    }

    public(friend) fun admin_inject_rcusdp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        0x2::balance::join<T1>(&mut arg0.rcusdp_custody, 0x2::coin::into_balance<T1>(arg1));
        let v0 = if (arg0.total_shares == 0) {
            (1000000000000000000 as u128)
        } else {
            (0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (arg0.total_shares as u128)
        };
        arg0.share_price = v0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_rcusdp_injected(0x2::coin::value<T1>(&arg1), 0x2::balance::value<T1>(&arg0.rcusdp_custody), arg0.share_price);
    }

    public(friend) fun cancel_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg1);
        let v0 = role_state_mut<T0, T1>(arg0);
        assert!(v0.pending_admin != @0x0, 11);
        v0.pending_admin = @0x0;
        v0.pending_admin_effective_ms = 0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_change_cancelled(v0.pending_admin);
    }

    fun cancel_all_pending_deposits(arg0: &mut UserRecords, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0)) {
            let v3 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v3.action == 0 && v3.status == 0) {
                v3.status = 2;
                v2 = v3.record_id;
            };
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun cancel_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(arg0.cancel_deposit_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg1.amounts, v0), 9);
        let v1 = 0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg1.users, &v0);
        if (v2) {
            0x1::vector::remove<address>(&mut arg1.users, v3);
        };
        let v4 = if (arg0.cancel_deposit_fee_bps == 0 || v1 == 0) {
            0
        } else {
            ((((v1 as u128) * (arg0.cancel_deposit_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v5 = v1 - v4;
        let v6 = 0x2::balance::split<T0>(&mut arg0.pending_deposit, v1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg4), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), v0);
        let v7 = cancel_all_pending_deposits(arg2, v0);
        add_user_record(arg2, v0, 5, v5, v4, 0, 1, 0x2::clock::timestamp_ms(arg3), v7);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_cancelled(v0, v7, v1, v5, v4);
    }

    public(friend) fun cancel_deposit_by_id<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(arg0.cancel_deposit_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, vector<UserRecord>>(&arg2.records, v0), 9);
        let v1 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg2.records, v0);
        let v2 = 0x1::vector::length<UserRecord>(v1);
        let v3 = false;
        let v4 = 0;
        let v5 = 0;
        let v6 = RecordIndexKey{
            user      : v0,
            record_id : arg3,
        };
        if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg2.id, v6)) {
            let v7 = *0x2::dynamic_field::borrow<RecordIndexKey, u64>(&arg2.id, v6);
            if (v7 < v2) {
                let v8 = 0x1::vector::borrow_mut<UserRecord>(v1, v7);
                let v9 = if (v8.record_id == arg3) {
                    if (v8.action == 0) {
                        v8.status == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v9) {
                    v4 = v8.amount;
                    v8.status = 2;
                    v3 = true;
                };
            };
        };
        while (!v3 && v5 < v2) {
            let v10 = 0x1::vector::borrow_mut<UserRecord>(v1, v5);
            let v11 = if (v10.record_id == arg3) {
                if (v10.action == 0) {
                    v10.status == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                v4 = v10.amount;
                v10.status = 2;
                if (!0x2::dynamic_field::exists_<RecordIndexKey>(&arg2.id, v6)) {
                    0x2::dynamic_field::add<RecordIndexKey, u64>(&mut arg2.id, v6, v5);
                };
                v3 = true;
                break
            };
            v5 = v5 + 1;
        };
        assert!(v3, 9);
        assert!(0x2::table::contains<address, u64>(&arg1.amounts, v0), 9);
        let v12 = *0x2::table::borrow<address, u64>(&arg1.amounts, v0);
        if (v12 > v4) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v12 - v4;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
            let (v13, v14) = 0x1::vector::index_of<address>(&arg1.users, &v0);
            if (v13) {
                0x1::vector::remove<address>(&mut arg1.users, v14);
            };
        };
        let v15 = if (arg0.cancel_deposit_fee_bps == 0 || v4 == 0) {
            0
        } else {
            ((((v4 as u128) * (arg0.cancel_deposit_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v16 = v4 - v15;
        let v17 = 0x2::balance::split<T0>(&mut arg0.pending_deposit, v4);
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v17, v15), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg5), v0);
        add_user_record(arg2, v0, 5, v16, v15, 0, 1, 0x2::clock::timestamp_ms(arg4), arg3);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_cancelled(v0, arg3, v4, v16, v15);
    }

    public(friend) fun cancel_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg1);
        let v0 = role_state_mut<T0, T1>(arg0);
        assert!(v0.pending_operator != @0x0, 11);
        v0.pending_operator = @0x0;
        v0.pending_operator_effective_ms = 0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_operator_change_cancelled(v0.pending_operator);
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Claims<T0>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_claims<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg3, 4);
        if (v1 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v1 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.claim_reserve, arg3), arg5), v0);
        add_user_record(arg2, v0, 2, arg3, 0, 0, 1, 0x2::clock::timestamp_ms(arg4), 0);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_claimed(v0, arg3);
    }

    fun complete_pending_redeem_records(arg0: &mut UserRecords, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0)) {
            let v2 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v2.action == 1 && v2.status == 0) {
                v2.status = 1;
                v2.settled_at = arg2;
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun create<T0, T1>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = VaultRoleStateKey{dummy_field: false};
        let v3 = VaultRoleState{
            pending_admin                 : @0x0,
            pending_admin_effective_ms    : 0,
            pending_operator              : @0x0,
            pending_operator_effective_ms : 0,
            role_change_delay_ms          : 86400000,
        };
        0x2::dynamic_field::add<VaultRoleStateKey, VaultRoleState>(&mut v0, v2, v3);
        let v4 = Vault<T0, T1>{
            id                      : v0,
            version                 : 3,
            admin                   : arg0,
            operator                : arg0,
            fee_recipient           : arg1,
            deposit_fee_bps         : 0,
            mgmt_fee_bps            : 0,
            redeem_fee_bps          : 0,
            share_price             : (1000000000000000000 as u128),
            total_shares            : 0,
            pending_deposit         : 0x2::balance::zero<T0>(),
            claim_reserve           : 0x2::balance::zero<T0>(),
            rcusdp_custody          : 0x2::balance::zero<T1>(),
            pending_redeem_rcusdp   : 0x2::balance::zero<T1>(),
            last_deposit_settle_ms  : 0,
            last_redeem_settle_ms   : 0,
            settle_interval_ms      : 0,
            paused                  : false,
            accumulated_mgmt_fee    : 0,
            last_mgmt_fee_ms        : 0,
            instant_redeem_fee_bps  : 700,
            reserve_fund            : 0x2::balance::zero<T0>(),
            instant_redeem_enabled  : false,
            withdraw_fee_bps        : 0,
            cancel_deposit_fee_bps  : 0,
            cancel_deposit_enabled  : true,
            withdraw_rcusdp_enabled : false,
            redeem_settled          : false,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v4);
        let v5 = VaultTypeConfig{
            id          : 0x2::object::new(arg2),
            vault_id    : v1,
            usdc_type   : 0x1::type_name::with_defining_ids<T0>(),
            rcusdp_type : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::transfer::share_object<VaultTypeConfig>(v5);
        let v6 = PendingDeposits<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
            users    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PendingDeposits<T0>>(v6);
        let v7 = PendingRedeems<T1>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
            users    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PendingRedeems<T1>>(v7);
        let v8 = DepositSettlementState{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            active   : false,
        };
        0x2::transfer::share_object<DepositSettlementState>(v8);
        let v9 = Claims<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<Claims<T0>>(v9);
        let v10 = Balances<T1>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<Balances<T1>>(v10);
        let v11 = UserRecords{
            id             : 0x2::object::new(arg2),
            vault_id       : v1,
            records        : 0x2::table::new<address, vector<UserRecord>>(arg2),
            next_record_id : 1,
        };
        0x2::transfer::share_object<UserRecords>(v11);
    }

    public(friend) fun credit_claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Claims<T0>, arg2: &mut UserRecords, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg6);
        verify_claims<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x2::balance::join<T0>(&mut arg0.claim_reserve, 0x2::coin::into_balance<T0>(arg4));
        if (0x2::table::contains<address, u64>(&arg1.amounts, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, arg3);
            *v1 = *v1 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg1.amounts, arg3, v0);
        };
        add_user_record(arg2, arg3, 6, v0, 0, 0, 1, 0x2::clock::timestamp_ms(arg5), 0);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_claim_allocated(arg3, v0);
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: &DepositSettlementState, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        verify_deposit_settlement_state<T0, T1>(arg0, arg3);
        assert!(!arg0.paused, 0);
        assert!(!arg3.active, 27);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<T0>(&arg4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = if (arg0.deposit_fee_bps == 0 || v1 == 0) {
            0
        } else {
            ((((v1 as u128) * (arg0.deposit_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v4 = v1 - v3;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v3, arg6), arg0.fee_recipient);
            0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_fees_taken(v3, 0);
        };
        0x2::balance::join<T0>(&mut arg0.pending_deposit, 0x2::coin::into_balance<T0>(arg4));
        let v5 = &mut arg1.amounts;
        let v6 = &mut arg1.users;
        upsert_add(v5, v6, v0, v4);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_record_created(v0, add_user_record(arg2, v0, 0, v4, v3, 0, 0, v2, 0), v4, v3, v2);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_queued(v0, v4, v3);
    }

    public(friend) fun deposit_reserve<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.reserve_fund, 0x2::coin::into_balance<T0>(arg1));
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_reserve_fund_deposited(0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.reserve_fund));
    }

    public(friend) fun finalize_redeems<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingRedeems<T1>, arg2: &mut UserRecords, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_redeems<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        only_operator<T0, T1>(arg0, arg5);
        assert!(arg0.redeem_settled, 19);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = if (arg0.redeem_fee_bps == 0 || v0 == 0) {
            0
        } else {
            ((((v0 as u128) * (arg0.redeem_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1, arg5), arg0.fee_recipient);
            0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_fees_taken(v1, 1);
        };
        let v3 = sum_last_n_pending_values(&arg1.amounts, &arg1.users, 100);
        assert!(v3 > 0, 3);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = 0x2::coin::into_balance<T0>(arg3);
        let v6 = 0;
        while (!0x1::vector::is_empty<address>(&arg1.users) && v6 < 100) {
            let v7 = 0x1::vector::pop_back<address>(&mut arg1.users);
            let v8 = (((v2 as u128) * (0x2::table::remove<address, u64>(&mut arg1.amounts, v7) as u128) / (v3 as u128)) as u64);
            complete_pending_redeem_records(arg2, v7, v4);
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v8), arg5), v7);
                add_user_record(arg2, v7, 2, v8, 0, 0, 1, v4, 0);
                0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_claimed(v7, v8);
            };
            v6 = v6 + 1;
        };
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), arg0.fee_recipient);
            0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_dust_withdrawn(arg0.fee_recipient, 0x2::balance::value<T0>(&v5));
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x1::vector::is_empty<address>(&arg1.users)) {
            arg0.redeem_settled = false;
        };
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_redeem_finalized(v3, v2, v1);
    }

    public(friend) fun get_all_user_records(arg0: &UserRecords, arg1: address) : vector<UserRecord> {
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            *0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1)
        } else {
            0x1::vector::empty<UserRecord>()
        }
    }

    public(friend) fun get_cancel_deposit_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, bool) {
        (arg0.cancel_deposit_fee_bps, arg0.cancel_deposit_enabled)
    }

    public(friend) fun get_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (arg0.deposit_fee_bps, arg0.mgmt_fee_bps, arg0.redeem_fee_bps)
    }

    public(friend) fun get_instant_redeem_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, bool) {
        (arg0.instant_redeem_fee_bps, 0x2::balance::value<T0>(&arg0.reserve_fund), arg0.instant_redeem_enabled)
    }

    public(friend) fun get_pending_deposit_records(arg0: &UserRecords, arg1: address) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.action == 0 && v3.status == 0) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun get_pending_role_changes<T0, T1>(arg0: &Vault<T0, T1>) : (address, u64, address, u64, u64) {
        let v0 = role_state<T0, T1>(arg0);
        (v0.pending_admin, v0.pending_admin_effective_ms, v0.pending_operator, v0.pending_operator_effective_ms, v0.role_change_delay_ms)
    }

    public(friend) fun get_prunable_records_count(arg0: &UserRecords, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
        let v1 = 0x1::vector::length<UserRecord>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            if (0x1::vector::borrow<UserRecord>(v0, v3).status != 0) {
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public(friend) fun get_record_by_id(arg0: &UserRecords, arg1: address, arg2: u64) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0x1::vector::length<UserRecord>(v1);
            let v3 = RecordIndexKey{
                user      : arg1,
                record_id : arg2,
            };
            if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg0.id, v3)) {
                let v4 = *0x2::dynamic_field::borrow<RecordIndexKey, u64>(&arg0.id, v3);
                if (v4 < v2) {
                    let v5 = 0x1::vector::borrow<UserRecord>(v1, v4);
                    if (v5.record_id == arg2) {
                        0x1::vector::push_back<UserRecord>(&mut v0, *v5);
                        return v0
                    };
                };
            };
            let v6 = 0;
            while (v6 < v2) {
                let v7 = 0x1::vector::borrow<UserRecord>(v1, v6);
                if (v7.record_id == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v7);
                    break
                };
                v6 = v6 + 1;
            };
        };
        v0
    }

    public(friend) fun get_redeem_settled<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.redeem_settled
    }

    public(friend) fun get_tvl<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.rcusdp_custody)
    }

    public(friend) fun get_user_balance<T0>(arg0: &Balances<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_user_claimable<T0>(arg0: &Claims<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_user_pending_deposit<T0>(arg0: &PendingDeposits<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_user_pending_redeem<T0>(arg0: &PendingRedeems<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_user_records_by_action(arg0: &UserRecords, arg1: address, arg2: u8) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.action == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun get_user_records_by_status(arg0: &UserRecords, arg1: address, arg2: u8) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.status == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun get_user_records_summary(arg0: &UserRecords, arg1: address) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v6 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v7 = 0;
            while (v7 < 0x1::vector::length<UserRecord>(v6)) {
                let v8 = 0x1::vector::borrow<UserRecord>(v6, v7);
                v0 = v0 + 1;
                v4 = v4 + v8.amount;
                v5 = v5 + v8.shares;
                if (v8.status == 0) {
                    v1 = v1 + 1;
                } else if (v8.status == 1) {
                    v2 = v2 + 1;
                } else if (v8.status == 2) {
                    v3 = v3 + 1;
                };
                v7 = v7 + 1;
            };
        };
        (v0, v1, v2, v3, v4, v5)
    }

    public(friend) fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (u128, u64, u64, u64, u64, bool) {
        (arg0.share_price, arg0.total_shares, 0x2::balance::value<T0>(&arg0.pending_deposit), 0x2::balance::value<T1>(&arg0.rcusdp_custody), 0x2::balance::value<T0>(&arg0.claim_reserve), arg0.paused)
    }

    public(friend) fun get_vault_metrics<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.rcusdp_custody), 0x2::balance::value<T0>(&arg0.pending_deposit), 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp), 0x2::balance::value<T0>(&arg0.claim_reserve), 0x2::balance::value<T0>(&arg0.reserve_fund))
    }

    public(friend) fun get_version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.version
    }

    public(friend) fun get_withdraw_rcusdp_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, bool) {
        (arg0.withdraw_fee_bps, arg0.withdraw_rcusdp_enabled)
    }

    public(friend) fun get_withdrawal_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (arg0.withdraw_fee_bps, arg0.cancel_deposit_fee_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun initiate_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg3);
        let v0 = role_state_mut<T0, T1>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2) + v0.role_change_delay_ms;
        v0.pending_admin = arg1;
        v0.pending_admin_effective_ms = v1;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_admin_change_initiated(arg0.admin, arg1, v1);
    }

    public(friend) fun initiate_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg3);
        let v0 = role_state_mut<T0, T1>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2) + v0.role_change_delay_ms;
        v0.pending_operator = arg1;
        v0.pending_operator_effective_ms = v1;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_operator_change_initiated(arg0.operator, arg1, v1);
    }

    public(friend) fun instant_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Balances<T1>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_balances<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        assert!(arg0.instant_redeem_enabled, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg0.share_price;
        assert!(v1 <= 10000000000000000000, 26);
        let v2 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v2 >= arg3, 2);
        let v3 = if (v1 == 0) {
            arg3
        } else {
            (((arg3 as u128) * v1 / (1000000000000000000 as u128)) as u64)
        };
        assert!(0x2::balance::value<T0>(&arg0.reserve_fund) >= v3, 8);
        if (v2 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v2 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        let v4 = if (arg0.instant_redeem_fee_bps == 0 || v3 == 0) {
            0
        } else {
            ((((v3 as u128) * (arg0.instant_redeem_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v5 = v3 - v4;
        let v6 = 0x2::balance::split<T0>(&mut arg0.reserve_fund, v3);
        0x2::balance::join<T1>(&mut arg0.pending_redeem_rcusdp, 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg3));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg5), v0);
        arg0.total_shares = arg0.total_shares - arg3;
        add_user_record(arg2, v0, 3, v5, v4, arg3, 1, 0x2::clock::timestamp_ms(arg4), 0);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_instant_redeemed(v0, arg3, v3, v5, v4);
    }

    public(friend) fun migrate_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg1);
        let v0 = arg0.version;
        if (v0 < 3) {
            arg0.version = 3;
            0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_vault_migrated(v0, 3);
        };
    }

    fun only_admin<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
    }

    fun only_operator<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg1), 6);
    }

    public(friend) fun prune_user_records<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut UserRecords, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        verify_version<T0, T1>(arg0);
        verify_user_records<T0, T1>(arg0, arg1);
        only_operator<T0, T1>(arg0, arg4);
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg1.records, arg2)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg1.records, arg2);
        let v1 = 0x1::vector::length<UserRecord>(v0);
        if (v1 <= arg3) {
            return 0
        };
        let v2 = 0x1::vector::empty<UserRecord>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<UserRecord>(v0, v4);
            if (v4 >= v1 - arg3 || v5.status == 0) {
                0x1::vector::push_back<UserRecord>(&mut v2, *v5);
            } else {
                let v6 = RecordIndexKey{
                    user      : arg2,
                    record_id : v5.record_id,
                };
                if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v6)) {
                    0x2::dynamic_field::remove<RecordIndexKey, u64>(&mut arg1.id, v6);
                };
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        let v7 = 0x1::vector::length<UserRecord>(&v2);
        let v8 = 0;
        while (v8 < v7) {
            let v9 = RecordIndexKey{
                user      : arg2,
                record_id : 0x1::vector::borrow<UserRecord>(&v2, v8).record_id,
            };
            if (0x2::dynamic_field::exists_<RecordIndexKey>(&arg1.id, v9)) {
                *0x2::dynamic_field::borrow_mut<RecordIndexKey, u64>(&mut arg1.id, v9) = v8;
            } else {
                0x2::dynamic_field::add<RecordIndexKey, u64>(&mut arg1.id, v9, v8);
            };
            v8 = v8 + 1;
        };
        *v0 = v2;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_user_records_pruned(arg2, v3, v7);
        v3
    }

    public(friend) fun queue_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingRedeems<T1>, arg2: &mut Balances<T1>, arg3: &mut UserRecords, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_redeems<T0, T1>(arg0, arg1);
        verify_balances<T0, T1>(arg0, arg2);
        verify_user_records<T0, T1>(arg0, arg3);
        assert!(!arg0.paused, 0);
        assert!(!arg0.redeem_settled, 25);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = if (0x2::table::contains<address, u64>(&arg2.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg2.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg4, 2);
        if (v1 > arg4) {
            *0x2::table::borrow_mut<address, u64>(&mut arg2.amounts, v0) = v1 - arg4;
        } else {
            0x2::table::remove<address, u64>(&mut arg2.amounts, v0);
        };
        0x2::balance::join<T1>(&mut arg0.pending_redeem_rcusdp, 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg4));
        let v2 = &mut arg1.amounts;
        let v3 = &mut arg1.users;
        upsert_add(v2, v3, v0, arg4);
        arg0.total_shares = arg0.total_shares - arg4;
        add_user_record(arg3, v0, 1, arg4, 0, arg4, 0, 0x2::clock::timestamp_ms(arg5), 0);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_redeem_queued(v0, arg4, arg4);
    }

    fun role_state<T0, T1>(arg0: &Vault<T0, T1>) : &VaultRoleState {
        let v0 = VaultRoleStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<VaultRoleStateKey, VaultRoleState>(&arg0.id, v0)
    }

    fun role_state_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut VaultRoleState {
        let v0 = VaultRoleStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<VaultRoleStateKey, VaultRoleState>(&mut arg0.id, v0)
    }

    public(friend) fun set_cancel_deposit_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.cancel_deposit_enabled = arg1;
    }

    public(friend) fun set_cancel_deposit_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        assert!(arg1 <= 10000, 16);
        arg0.cancel_deposit_fee_bps = arg1;
    }

    public(friend) fun set_fee_recipient<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.fee_recipient = arg1;
    }

    public(friend) fun set_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg4);
        assert!(arg1 <= 10000, 16);
        assert!(arg2 <= 10000, 16);
        assert!(arg3 <= 10000, 16);
        arg0.deposit_fee_bps = arg1;
        arg0.mgmt_fee_bps = arg2;
        arg0.redeem_fee_bps = arg3;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_fees_updated(arg1, arg2, arg3);
    }

    public(friend) fun set_instant_redeem_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.instant_redeem_enabled = arg1;
    }

    public(friend) fun set_instant_redeem_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        assert!(arg1 <= 10000, 16);
        arg0.instant_redeem_fee_bps = arg1;
    }

    public(friend) fun set_operator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        let v0 = arg0.operator;
        arg0.operator = arg1;
        let v1 = role_state_mut<T0, T1>(arg0);
        v1.pending_operator = @0x0;
        v1.pending_operator_effective_ms = 0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_operator_change_completed(v0, arg1);
    }

    public(friend) fun set_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.paused = arg1;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_paused(arg1);
    }

    public(friend) fun set_role_change_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        assert!(arg1 >= 3600000, 13);
        let v0 = role_state_mut<T0, T1>(arg0);
        v0.role_change_delay_ms = arg1;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_role_change_delay_updated(v0.role_change_delay_ms, arg1);
    }

    public(friend) fun set_settle_interval<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.settle_interval_ms = arg1;
    }

    public(friend) fun set_withdraw_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        assert!(arg1 <= 10000, 16);
        arg0.withdraw_fee_bps = arg1;
    }

    public(friend) fun set_withdraw_rcusdp_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        arg0.withdraw_rcusdp_enabled = arg1;
    }

    public(friend) fun settle_deposits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: &mut Balances<T1>, arg4: &mut DepositSettlementState, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        verify_balances<T0, T1>(arg0, arg3);
        verify_deposit_settlement_state<T0, T1>(arg0, arg4);
        assert!(!arg0.paused, 0);
        only_operator<T0, T1>(arg0, arg7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (!arg4.active) {
            assert!(v0 >= arg0.last_deposit_settle_ms + arg0.settle_interval_ms, 1);
            arg4.active = true;
        };
        let v1 = 0x2::coin::value<T1>(&arg5);
        assert!(v1 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.rcusdp_custody, 0x2::coin::into_balance<T1>(arg5));
        let v2 = sum_last_n_pending_values(&arg1.amounts, &arg1.users, 100);
        assert!(v2 > 0, 3);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (!0x1::vector::is_empty<address>(&arg1.users) && v5 < 100) {
            let v6 = 0x1::vector::pop_back<address>(&mut arg1.users);
            let v7 = 0x2::table::remove<address, u64>(&mut arg1.amounts, v6);
            v4 = v4 + v7;
            let v8 = (((v1 as u128) * (v7 as u128) / (v2 as u128)) as u64);
            v3 = v3 + v8;
            if (0x2::table::contains<address, u64>(&arg3.amounts, v6)) {
                let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg3.amounts, v6);
                *v9 = *v9 + v8;
            } else {
                0x2::table::add<address, u64>(&mut arg3.amounts, v6, v8);
            };
            settle_user_deposit_records(arg2, v6, v7, v8, v0);
            v5 = v5 + 1;
        };
        let v10 = arg0.total_shares + v3;
        arg0.total_shares = v10;
        let v11 = if (v10 == 0) {
            (1000000000000000000 as u128)
        } else {
            (0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (v10 as u128)
        };
        arg0.share_price = v11;
        if (0x1::vector::is_empty<address>(&arg1.users)) {
            arg0.last_deposit_settle_ms = v0;
            arg4.active = false;
        };
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_settled(v4, v3);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_share_price_synced(arg0.share_price, arg0.total_shares);
    }

    public(friend) fun settle_redeems<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        assert!(!arg0.paused, 0);
        only_operator<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_redeem_settle_ms + arg0.settle_interval_ms, 1);
        let v1 = 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp);
        assert!(v1 > 0, 3);
        arg0.last_redeem_settle_ms = v0;
        arg0.redeem_settled = true;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_redeem_settled(v1);
    }

    fun settle_user_deposit_records(arg0: &mut UserRecords, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0) && arg2 > 0) {
            let v2 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v2.action == 0 && v2.status == 0) {
                if (v2.amount <= arg2) {
                    let v3 = if (arg2 == 0) {
                        0
                    } else {
                        (((v2.amount as u128) * (arg3 as u128) / (arg2 as u128)) as u64)
                    };
                    v2.shares = v3;
                    v2.status = 1;
                    v2.settled_at = arg4;
                    arg2 = arg2 - v2.amount;
                    0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_deposit_record_settled(arg1, v2.record_id, v3, arg4);
                };
            };
            v1 = v1 + 1;
        };
    }

    fun sum_last_n_pending_values(arg0: &0x2::table::Table<address, u64>, arg1: &vector<address>, arg2: u64) : u64 {
        let v0 = 0x1::vector::length<address>(arg1);
        let v1 = if (v0 < arg2) {
            v0
        } else {
            arg2
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x2::table::borrow<address, u64>(arg0, *0x1::vector::borrow<address>(arg1, v0 - 1 - v3));
            v3 = v3 + 1;
        };
        v2
    }

    fun sum_pending_values(arg0: &0x2::table::Table<address, u64>, arg1: &vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            v0 = v0 + *0x2::table::borrow<address, u64>(arg0, *0x1::vector::borrow<address>(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun sync_price<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        only_operator<T0, T1>(arg0, arg1);
        let v0 = if (arg0.total_shares == 0) {
            (1000000000000000000 as u128)
        } else {
            (0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (arg0.total_shares as u128)
        };
        arg0.share_price = v0;
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_share_price_synced(arg0.share_price, arg0.total_shares);
    }

    public(friend) fun take_pending_rcusdp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        verify_version<T0, T1>(arg0);
        only_operator<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp);
        if (v0 > 0) {
            arg0.redeem_settled = true;
        };
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_pending_rcusdp_taken(0x2::tx_context::sender(arg1), v0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.pending_redeem_rcusdp), arg1)
    }

    public(friend) fun take_pending_rcusdp_legacy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 108
    }

    public(friend) fun take_pending_usdc<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut DepositSettlementState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version<T0, T1>(arg0);
        verify_deposit_settlement_state<T0, T1>(arg0, arg1);
        only_operator<T0, T1>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.pending_deposit);
        if (v0 > 0) {
            arg1.active = true;
        };
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_pending_usdc_taken(0x2::tx_context::sender(arg2), v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_deposit), arg2)
    }

    public(friend) fun take_pending_usdc_legacy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 108
    }

    fun upsert_add(arg0: &mut 0x2::table::Table<address, u64>, arg1: &mut vector<address>, arg2: address, arg3: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<address, u64>(arg0, arg2, arg3);
            0x1::vector::push_back<address>(arg1, arg2);
        };
    }

    fun verify_balances<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Balances<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_claims<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Claims<T0>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_deposit_settlement_state<T0, T1>(arg0: &Vault<T0, T1>, arg1: &DepositSettlementState) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_pending_deposits<T0, T1>(arg0: &Vault<T0, T1>, arg1: &PendingDeposits<T0>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_pending_redeems<T0, T1>(arg0: &Vault<T0, T1>, arg1: &PendingRedeems<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_user_records<T0, T1>(arg0: &Vault<T0, T1>, arg1: &UserRecords) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    public(friend) fun verify_vault_type_config<T0, T1>(arg0: &Vault<T0, T1>, arg1: &VaultTypeConfig) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
        assert!(arg1.usdc_type == 0x1::type_name::with_defining_ids<T0>(), 23);
        assert!(arg1.rcusdp_type == 0x1::type_name::with_defining_ids<T1>(), 24);
    }

    fun verify_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 3, 21);
    }

    public(friend) fun withdraw_rcusdp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Balances<T1>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version<T0, T1>(arg0);
        verify_balances<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        assert!(arg0.withdraw_rcusdp_enabled, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg3, 2);
        if (v1 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v1 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        let v2 = if (arg0.withdraw_fee_bps == 0 || arg3 == 0) {
            0
        } else {
            ((((arg3 as u128) * (arg0.withdraw_fee_bps as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
        };
        let v3 = arg3 - v2;
        let v4 = 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v2), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg5), v0);
        arg0.total_shares = arg0.total_shares - arg3;
        add_user_record(arg2, v0, 4, v3, v2, arg3, 1, 0x2::clock::timestamp_ms(arg4), 0);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_rcusdp_withdrawn(v0, arg3, arg3, v3, v2);
    }

    public(friend) fun withdraw_reserve<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version<T0, T1>(arg0);
        only_admin<T0, T1>(arg0, arg2);
        assert!(0x2::balance::value<T0>(&arg0.reserve_fund) >= arg1, 8);
        0x9b149fa785d17c7f7d94c6132c21649cc13e73f55e0e8d6bf957f4dc208d22b6::vault_events::emit_reserve_fund_withdrawn(arg1, 0x2::balance::value<T0>(&arg0.reserve_fund));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_fund, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

