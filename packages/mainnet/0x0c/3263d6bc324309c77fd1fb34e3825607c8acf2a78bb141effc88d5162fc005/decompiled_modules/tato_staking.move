module 0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking {
    struct TATO_STAKING has drop {
        dummy_field: bool,
    }

    struct StakeRecord has copy, drop, store {
        tato_amount: u64,
        xtato_earned: u64,
        lock_days: u64,
        stake_timestamp: u64,
    }

    struct UserStakingInfo has store {
        stakes: vector<StakeRecord>,
        xtato_balance: u64,
    }

    struct TatoStakingRegistry has key {
        id: 0x2::object::UID,
        user_info: 0x2::table::Table<address, UserStakingInfo>,
        total_xtato_supply: u64,
        total_tato_locked: u64,
        tato_balance: 0x2::balance::Balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>,
        treasury_address: address,
        version: u64,
        paused: bool,
        total_users_count: u64,
        total_stakes_count: u64,
        total_withdrawals_count: u64,
        total_active_stakes_count: u64,
    }

    struct TatoStakingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TatoStakingCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserStakingSummary has copy, drop {
        xtato_balance: u64,
        total_active_stakes: u64,
        total_tato_staked: u64,
    }

    struct TatoStaked has copy, drop {
        user: address,
        tato_amount: u64,
        xtato_earned: u64,
        lock_days: u64,
        stake_timestamp: u64,
    }

    struct TatoWithdrawn has copy, drop {
        user: address,
        tato_amount: u64,
        stake_index: u64,
        timestamp: u64,
    }

    struct XtatoDeducted has copy, drop {
        user: address,
        xtato_amount: u64,
        deducted_by: address,
        reason: 0x1::string::String,
    }

    struct XtatoAdded has copy, drop {
        user: address,
        xtato_amount: u64,
        added_by: address,
        reason: 0x1::string::String,
    }

    public fun add_xtato_with_cap(arg0: &mut TatoStakingRegistry, arg1: &TatoStakingCap, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        assert!(arg3 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_amount_too_small());
        if (!0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, arg2)) {
            let v0 = UserStakingInfo{
                stakes        : 0x1::vector::empty<StakeRecord>(),
                xtato_balance : arg3,
            };
            0x2::table::add<address, UserStakingInfo>(&mut arg0.user_info, arg2, v0);
            arg0.total_users_count = arg0.total_users_count + 1;
        } else {
            let v1 = 0x2::table::borrow_mut<address, UserStakingInfo>(&mut arg0.user_info, arg2);
            v1.xtato_balance = v1.xtato_balance + arg3;
        };
        arg0.total_xtato_supply = arg0.total_xtato_supply + arg3;
        let v2 = XtatoAdded{
            user         : arg2,
            xtato_amount : arg3,
            added_by     : 0x2::tx_context::sender(arg6),
            reason       : arg4,
        };
        0x2::event::emit<XtatoAdded>(v2);
    }

    fun check_not_paused(arg0: &TatoStakingRegistry) {
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
    }

    fun check_version(arg0: &TatoStakingRegistry) {
        assert!(arg0.version == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    public entry fun create_and_transfer_tato_staking_cap(arg0: &TatoStakingAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_tato_staking_cap(arg0, arg1);
        0x2::transfer::public_transfer<TatoStakingCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_tato_staking_cap(arg0: &TatoStakingAdminCap, arg1: &mut 0x2::tx_context::TxContext) : TatoStakingCap {
        TatoStakingCap{id: 0x2::object::new(arg1)}
    }

    public fun deduct_xtato_with_cap(arg0: &mut TatoStakingRegistry, arg1: &TatoStakingCap, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        assert!(arg3 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_amount_too_small());
        assert!(0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, arg2), 40);
        let v0 = 0x2::table::borrow_mut<address, UserStakingInfo>(&mut arg0.user_info, arg2);
        assert!(v0.xtato_balance >= arg3, 40);
        v0.xtato_balance = v0.xtato_balance - arg3;
        arg0.total_xtato_supply = arg0.total_xtato_supply - arg3;
        let v1 = XtatoDeducted{
            user         : arg2,
            xtato_amount : arg3,
            deducted_by  : 0x2::tx_context::sender(arg6),
            reason       : arg4,
        };
        0x2::event::emit<XtatoDeducted>(v1);
    }

    public fun get_stake_info(arg0: &TatoStakingRegistry, arg1: address, arg2: u64) : StakeRecord {
        assert!(0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, arg1), 45);
        let v0 = 0x2::table::borrow<address, UserStakingInfo>(&arg0.user_info, arg1);
        assert!(arg2 < 0x1::vector::length<StakeRecord>(&v0.stakes), 44);
        *0x1::vector::borrow<StakeRecord>(&v0.stakes, arg2)
    }

    public fun get_user_stakes_paginated(arg0: &TatoStakingRegistry, arg1: address, arg2: u64, arg3: u64) : vector<StakeRecord> {
        let v0 = 0x1::vector::empty<StakeRecord>();
        if (!0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, UserStakingInfo>(&arg0.user_info, arg1);
        let v2 = 0x1::vector::length<StakeRecord>(&v1.stakes);
        if (arg2 >= v2) {
            return v0
        };
        let v3 = if (arg3 > v2 - arg2) {
            v2
        } else {
            arg2 + arg3
        };
        while (arg2 < v3) {
            0x1::vector::push_back<StakeRecord>(&mut v0, *0x1::vector::borrow<StakeRecord>(&v1.stakes, arg2));
            arg2 = arg2 + 1;
        };
        v0
    }

    public fun get_user_summary(arg0: &TatoStakingRegistry, arg1: address) : UserStakingSummary {
        if (!0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, arg1)) {
            return UserStakingSummary{
                xtato_balance       : 0,
                total_active_stakes : 0,
                total_tato_staked   : 0,
            }
        };
        let v0 = 0x2::table::borrow<address, UserStakingInfo>(&arg0.user_info, arg1);
        let v1 = 0x1::vector::length<StakeRecord>(&v0.stakes);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + 0x1::vector::borrow<StakeRecord>(&v0.stakes, v3).tato_amount;
            v3 = v3 + 1;
        };
        UserStakingSummary{
            xtato_balance       : v0.xtato_balance,
            total_active_stakes : v1,
            total_tato_staked   : v2,
        }
    }

    fun init(arg0: TATO_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TatoStakingRegistry{
            id                        : 0x2::object::new(arg1),
            user_info                 : 0x2::table::new<address, UserStakingInfo>(arg1),
            total_xtato_supply        : 0,
            total_tato_locked         : 0,
            tato_balance              : 0x2::balance::zero<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(),
            treasury_address          : 0x2::tx_context::sender(arg1),
            version                   : 1,
            paused                    : false,
            total_users_count         : 0,
            total_stakes_count        : 0,
            total_withdrawals_count   : 0,
            total_active_stakes_count : 0,
        };
        0x2::transfer::share_object<TatoStakingRegistry>(v0);
        let v1 = TatoStakingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TatoStakingAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<TATO_STAKING>(arg0, arg1);
    }

    public entry fun set_paused(arg0: &TatoStakingAdminCap, arg1: &mut TatoStakingRegistry, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun stake_tato(arg0: &mut TatoStakingRegistry, arg1: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        assert!(arg2 >= 14 && arg2 <= 1000, 41);
        let v0 = 0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg1);
        assert!(v0 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_amount_too_small());
        assert!(v0 >= 100000000000, 46);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v0 * arg2 / 1000;
        assert!(arg2 * 86400000 <= 18446744073709551615 - v2, 41);
        let v4 = StakeRecord{
            tato_amount     : v0,
            xtato_earned    : v3,
            lock_days       : arg2,
            stake_timestamp : v2,
        };
        if (!0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, v1)) {
            let v5 = 0x1::vector::empty<StakeRecord>();
            0x1::vector::push_back<StakeRecord>(&mut v5, v4);
            let v6 = UserStakingInfo{
                stakes        : v5,
                xtato_balance : v3,
            };
            0x2::table::add<address, UserStakingInfo>(&mut arg0.user_info, v1, v6);
            arg0.total_users_count = arg0.total_users_count + 1;
        } else {
            let v7 = 0x2::table::borrow_mut<address, UserStakingInfo>(&mut arg0.user_info, v1);
            0x1::vector::push_back<StakeRecord>(&mut v7.stakes, v4);
            v7.xtato_balance = v7.xtato_balance + v3;
        };
        arg0.total_xtato_supply = arg0.total_xtato_supply + v3;
        arg0.total_tato_locked = arg0.total_tato_locked + v0;
        arg0.total_stakes_count = arg0.total_stakes_count + 1;
        arg0.total_active_stakes_count = arg0.total_active_stakes_count + 1;
        0x2::balance::join<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.tato_balance, 0x2::coin::into_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(arg1));
        let v8 = TatoStaked{
            user            : v1,
            tato_amount     : v0,
            xtato_earned    : v3,
            lock_days       : arg2,
            stake_timestamp : v2,
        };
        0x2::event::emit<TatoStaked>(v8);
    }

    public entry fun update_treasury_address(arg0: &TatoStakingAdminCap, arg1: &mut TatoStakingRegistry, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &TatoStakingAdminCap, arg1: &mut TatoStakingRegistry) {
        assert!(arg1.version < 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
        arg1.version = 1;
    }

    public entry fun withdraw_tato(arg0: &mut TatoStakingRegistry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStakingInfo>(&arg0.user_info, v0), 45);
        let v1 = 0x2::table::borrow_mut<address, UserStakingInfo>(&mut arg0.user_info, v0);
        assert!(arg1 < 0x1::vector::length<StakeRecord>(&v1.stakes), 44);
        let v2 = 0x1::vector::borrow<StakeRecord>(&v1.stakes, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        assert!(v3 >= v2.stake_timestamp + v2.lock_days * 86400000, 42);
        let v4 = v2.tato_amount;
        0x1::vector::swap_remove<StakeRecord>(&mut v1.stakes, arg1);
        arg0.total_tato_locked = arg0.total_tato_locked - v4;
        arg0.total_withdrawals_count = arg0.total_withdrawals_count + 1;
        arg0.total_active_stakes_count = arg0.total_active_stakes_count - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::coin::from_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(0x2::balance::split<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.tato_balance, v4), arg3), v0);
        let v5 = TatoWithdrawn{
            user        : v0,
            tato_amount : v4,
            stake_index : arg1,
            timestamp   : v3,
        };
        0x2::event::emit<TatoWithdrawn>(v5);
    }

    // decompiled from Move bytecode v6
}

