module 0x2042f38374d496697df01b7eaf2682447248f1525252a90ce945c280cfa29c2c::deposit_pool {
    struct VestingCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        created_at_ms: u64,
        schedule_start_ms: u64,
        stop_allowed: bool,
        receipt_ids: vector<0x2::object::ID>,
        amounts: u64,
        maturities_ms: vector<u64>,
        cliff_amount: u64,
        vest_amount: u64,
    }

    struct VestingStoppedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        stopped_by: address,
        stopped_at_ms: u64,
        refunded_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        rate_decimal: u8,
        return_rates: 0x2::table::Table<u32, u16>,
        admin_cap_id: 0x2::object::ID,
        version: u64,
        options: 0x2::bag::Bag,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
        issue_at_ms: u64,
        mature_at_ms: u64,
        apy: u16,
    }

    entry fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u16, arg2: 0x1::option::Option<u8>, arg3: bool, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg5)};
        let v1 = if (0x1::option::is_some<u8>(&arg2)) {
            0x1::option::destroy_some<u8>(arg2)
        } else {
            0x1::option::destroy_none<u8>(arg2);
            2
        };
        let v2 = DepositPool<T0, T1>{
            id           : 0x2::object::new(arg5),
            balance      : 0x2::balance::zero<T0>(),
            treasury_cap : arg0,
            rate_decimal : v1,
            return_rates : 0x2::table::new<u32, u16>(arg5),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            version      : 2,
            options      : 0x2::bag::new(arg5),
        };
        0x2::bag::add<u8, bool>(&mut v2.options, 1, arg3);
        if (arg4 > 0) {
            0x2::bag::add<u8, u64>(&mut v2.options, 2, (arg4 as u64) * 86400000);
        };
        0x2::table::add<u32, u16>(&mut v2.return_rates, 0, arg1);
        0x2::transfer::share_object<DepositPool<T0, T1>>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun add_reward_program<T0: drop, T1, T2>(arg0: &mut DepositPool<T1, T2>, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        assert!(!0x2::bag::contains<u8>(&arg0.options, 6), 11);
        let (v0, v1) = 0x2::token::new_policy<T2>(&arg0.treasury_cap, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::token::add_rule_for_action<T2, T0>(&mut v3, &v2, 0x2::token::spend_action(), arg2);
        0x2::token::share_policy<T2>(v3);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<T2>>(v2, 0x2::tx_context::sender(arg2));
    }

    fun calculate_token_amount<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u16) : u64 {
        if (0x2::bag::contains<u8>(&arg0.options, 6)) {
            return 0
        };
        let v0 = if (0x2::bag::contains<u8>(&arg0.options, 2)) {
            0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut arg0.id, arg2) - *0x2::bag::borrow<u8, u64>(&arg0.options, 2)
        } else {
            0x2::clock::timestamp_ms(arg1)
        };
        if (v0 < arg4) {
            return 0
        };
        let v1 = 0x1::u128::try_as_u64((((v0 - arg5) / 86400000) as u128) * (arg3 as u128) * (arg6 as u128) / 0x1::u128::pow(10, arg0.rate_decimal) / 365);
        if (0x1::option::is_some<u64>(&v1)) {
            0x1::option::destroy_some<u64>(v1)
        } else {
            0x1::option::destroy_none<u64>(v1);
            0
        }
    }

    public fun cancel_pending_withdrawal<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut Receipt) {
        assert!(arg0.version == 2, 2);
        assert!(arg1.pool_id == 0x2::object::id<DepositPool<T0, T1>>(arg0), 3);
        0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut arg0.id, 0x2::object::id<Receipt>(arg1));
    }

    public fun delete_lock_term<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut AdminCap, arg2: u32) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        assert!(arg2 != 0, 6);
        0x2::table::remove<u32, u16>(&mut arg0.return_rates, arg2);
    }

    public fun deposit<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u32, arg3: address, arg4: 0x1::option::Option<u16>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        assert!(!0x2::bag::contains<u8>(&arg0.options, 6), 11);
        let (v0, v1) = if (0x2::table::contains<u32, u16>(&arg0.return_rates, arg2)) {
            ((arg2 as u64), *0x2::table::borrow<u32, u16>(&arg0.return_rates, arg2))
        } else {
            (0, *0x2::table::borrow<u32, u16>(&arg0.return_rates, 0))
        };
        let v2 = if (0x1::option::is_some<u16>(&arg4)) {
            0x1::option::destroy_some<u16>(arg4)
        } else {
            0x1::option::destroy_none<u16>(arg4);
            0
        };
        assert!(v2 <= v1, 7);
        let v3 = Receipt{
            id           : 0x2::object::new(arg6),
            pool_id      : 0x2::object::id<DepositPool<T0, T1>>(arg0),
            amount       : 0x2::coin::value<T0>(&arg1),
            issue_at_ms  : 0x2::clock::timestamp_ms(arg5),
            mature_at_ms : 0x2::clock::timestamp_ms(arg5) + (v0 as u64) * 86400000,
            apy          : v1,
        };
        0x2::transfer::transfer<Receipt>(v3, arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun disable_extending_terms<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut AdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        0x2::bag::remove<u8, bool>(&mut arg0.options, 3);
    }

    public fun enable_extending_terms<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut AdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        0x2::bag::add<u8, bool>(&mut arg0.options, 3, true);
    }

    entry fun migrate<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &AdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version < 2, 1);
        arg0.version = 2;
    }

    public fun new_vesting<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg6);
        let v1 = arg4 > 0;
        let v2 = if (v1) {
            256 - 1
        } else {
            256
        };
        assert!(v0 <= v2, 10);
        if (v0 > 0) {
            assert!(arg5 > 0, 10);
        } else {
            assert!(arg5 == 0, 10);
        };
        let v3 = arg4 + v0 * arg5;
        assert!(v3 > 0 && v3 == 0x2::coin::value<T0>(&arg1), 10);
        let v4 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg3 >= v4, 10);
        let v5 = AdminCap{id: 0x2::object::new(arg9)};
        let v6 = 0x2::bag::new(arg9);
        0x2::bag::add<u8, bool>(&mut v6, 1, false);
        0x2::bag::add<u8, bool>(&mut v6, 5, arg7);
        0x2::bag::add<u8, bool>(&mut v6, 6, false);
        let v7 = 0x2::table::new<u32, u16>(arg9);
        0x2::table::add<u32, u16>(&mut v7, 0, 0);
        let v8 = DepositPool<T0, T1>{
            id           : 0x2::object::new(arg9),
            balance      : 0x2::coin::into_balance<T0>(arg1),
            treasury_cap : arg0,
            rate_decimal : 2,
            return_rates : v7,
            admin_cap_id : 0x2::object::id<AdminCap>(&v5),
            version      : 2,
            options      : v6,
        };
        let v9 = 0x2::object::id<DepositPool<T0, T1>>(&v8);
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        if (v1) {
            let v11 = Receipt{
                id           : 0x2::object::new(arg9),
                pool_id      : v9,
                amount       : arg4,
                issue_at_ms  : v4,
                mature_at_ms : arg3,
                apy          : 0,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v10, 0x2::object::id<Receipt>(&v11));
            0x2::transfer::transfer<Receipt>(v11, arg2);
        };
        let v12 = &arg6;
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(v12)) {
            let v14 = 0x1::vector::borrow<u64>(v12, v13);
            assert!(*v14 > arg3, 10);
            let v15 = Receipt{
                id           : 0x2::object::new(arg9),
                pool_id      : v9,
                amount       : arg5,
                issue_at_ms  : v4,
                mature_at_ms : *v14,
                apy          : 0,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v10, 0x2::object::id<Receipt>(&v15));
            0x2::transfer::transfer<Receipt>(v15, arg2);
            arg3 = *v14;
            v13 = v13 + 1;
        };
        let v16 = VestingCreatedEvent{
            pool_id           : v9,
            admin_cap_id      : 0x2::object::id<AdminCap>(&v5),
            creator           : 0x2::tx_context::sender(arg9),
            recipient         : arg2,
            created_at_ms     : v4,
            schedule_start_ms : arg3,
            stop_allowed      : arg7,
            receipt_ids       : v10,
            amounts           : v3,
            maturities_ms     : arg6,
            cliff_amount      : arg4,
            vest_amount       : arg5,
        };
        0x2::event::emit<VestingCreatedEvent>(v16);
        0x2::transfer::share_object<DepositPool<T0, T1>>(v8);
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg9));
    }

    public fun stop_vesting<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        assert!(0x2::bag::contains<u8>(&arg0.options, 6), 12);
        assert!(*0x2::bag::borrow<u8, bool>(&arg0.options, 5), 13);
        assert!(!*0x2::bag::borrow<u8, bool>(&arg0.options, 6), 14);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        *0x2::bag::borrow_mut<u8, bool>(&mut arg0.options, 6) = true;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg3), 0x2::tx_context::sender(arg3));
        };
        let v1 = VestingStoppedEvent{
            pool_id         : 0x2::object::id<DepositPool<T0, T1>>(arg0),
            admin_cap_id    : 0x2::object::id<AdminCap>(arg1),
            stopped_by      : 0x2::tx_context::sender(arg3),
            stopped_at_ms   : 0x2::clock::timestamp_ms(arg2),
            refunded_amount : v0,
        };
        0x2::event::emit<VestingStoppedEvent>(v1);
    }

    public fun upgrade_term<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut Receipt, arg2: u32, arg3: 0x1::option::Option<u16>, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 2, 2);
        assert!(arg1.pool_id == 0x2::object::id<DepositPool<T0, T1>>(arg0), 3);
        assert!(!0x2::bag::contains<u8>(&arg0.options, 6), 11);
        assert!(0x2::bag::contains<u8>(&arg0.options, 3), 8);
        assert!(arg1.mature_at_ms > 0x2::clock::timestamp_ms(arg4), 9);
        let v0 = *0x2::table::borrow<u32, u16>(&arg0.return_rates, arg2);
        let v1 = if (0x1::option::is_some<u16>(&arg3)) {
            0x1::option::destroy_some<u16>(arg3)
        } else {
            0x1::option::destroy_none<u16>(arg3);
            arg1.apy
        };
        assert!(v0 >= v1, 7);
        let v2 = arg1.issue_at_ms + (arg2 as u64) * 86400000;
        assert!(v2 > arg1.mature_at_ms, 9);
        arg1.mature_at_ms = v2;
        arg1.apy = v0;
    }

    public fun upsert_lock_term<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: &mut AdminCap, arg2: u32, arg3: u16) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 2, 2);
        if (0x2::table::contains<u32, u16>(&arg0.return_rates, arg2)) {
            0x2::table::remove<u32, u16>(&mut arg0.return_rates, arg2);
        };
        0x2::table::add<u32, u16>(&mut arg0.return_rates, arg2, arg3);
    }

    entry fun withdraw<T0, T1>(arg0: &mut DepositPool<T0, T1>, arg1: Receipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 2);
        assert!(arg1.pool_id == 0x2::object::id<DepositPool<T0, T1>>(arg0), 3);
        if (0x2::bag::contains<u8>(&arg0.options, 6)) {
            assert!(!*0x2::bag::borrow<u8, bool>(&arg0.options, 6), 15);
        };
        if (!*0x2::bag::borrow<u8, bool>(&arg0.options, 1)) {
            assert!(0x2::clock::timestamp_ms(arg2) >= arg1.mature_at_ms, 4);
        };
        if (0x2::bag::contains<u8>(&arg0.options, 2)) {
            if (0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, 0x2::object::id<Receipt>(&arg1))) {
                assert!(*0x2::dynamic_field::borrow<0x2::object::ID, u64>(&arg0.id, 0x2::object::id<Receipt>(&arg1)) <= 0x2::clock::timestamp_ms(arg2), 5);
            } else {
                0x2::dynamic_field::add<0x2::object::ID, u64>(&mut arg0.id, 0x2::object::id<Receipt>(&arg1), 0x2::clock::timestamp_ms(arg2) + *0x2::bag::borrow<u8, u64>(&arg0.options, 2));
                0x2::transfer::transfer<Receipt>(arg1, 0x2::tx_context::sender(arg3));
                return
            };
        };
        let Receipt {
            id           : v0,
            pool_id      : _,
            amount       : v2,
            issue_at_ms  : v3,
            mature_at_ms : v4,
            apy          : v5,
        } = arg1;
        let v6 = v0;
        if (!0x2::bag::contains<u8>(&arg0.options, 6)) {
            let v7 = calculate_token_amount<T0, T1>(arg0, arg2, 0x2::object::uid_to_inner(&v6), v2, v4, v3, v5);
            if (v7 > 0) {
                let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T1>(&mut arg0.treasury_cap, 0x2::token::transfer<T1>(0x2::token::mint<T1>(&mut arg0.treasury_cap, v7, arg3), 0x2::tx_context::sender(arg3), arg3), arg3);
            };
        };
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

