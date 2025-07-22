module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_yield_integration {
    struct YieldConfig has store, key {
        id: 0x2::object::UID,
        circle_id: 0x2::object::ID,
        strategy: u8,
        navi_allocation_percentage: u64,
        cetus_allocation_percentage: u64,
        auto_compound: bool,
        emergency_withdrawal_enabled: bool,
        total_deposited: u64,
        total_yield_earned: u64,
        last_yield_collection: u64,
        is_active: bool,
    }

    struct YieldReceipt has store, key {
        id: 0x2::object::UID,
        circle_id: 0x2::object::ID,
        member_addr: address,
        deposit_amount: u64,
        navi_amount: u64,
        cetus_amount: u64,
        deposit_timestamp: u64,
        strategy: u8,
    }

    struct NaviPosition has drop, store {
        supplied_amount: u64,
        receipt_id: 0x1::option::Option<0x2::object::ID>,
        last_updated: u64,
        accrued_interest: u64,
    }

    struct CetusPosition has drop, store {
        lp_amount: u64,
        position_id: 0x1::option::Option<0x2::object::ID>,
        last_updated: u64,
        accrued_fees: u64,
    }

    struct YieldConfigCreated has copy, drop {
        circle_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        strategy: u8,
        navi_allocation: u64,
        cetus_allocation: u64,
    }

    struct SecurityDepositYieldGenerated has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        total_deposit: u64,
        navi_amount: u64,
        cetus_amount: u64,
        strategy: u8,
        timestamp: u64,
    }

    struct YieldCollected has copy, drop {
        circle_id: 0x2::object::ID,
        total_yield: u64,
        navi_yield: u64,
        cetus_yield: u64,
        collection_timestamp: u64,
    }

    struct EmergencyWithdrawalExecuted has copy, drop {
        circle_id: 0x2::object::ID,
        withdrawn_amount: u64,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct YieldDistributed has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        yield_amount: u64,
        deposit_returned: u64,
        timestamp: u64,
    }

    fun calculate_member_yield_share(arg0: &YieldConfig, arg1: &YieldReceipt) : u64 {
        if (arg0.total_deposited == 0) {
            return 0
        };
        arg1.deposit_amount * arg0.total_yield_earned / arg0.total_deposited
    }

    fun calculate_navi_compound_interest(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 0 || arg0 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v0 = (arg0 as u128) * (arg2 as u128) * (arg1 as u128) * 1000000 / 31536000000 / 10000 / 1000000;
        let v1 = arg0 / 1000;
        let v2 = if (v0 > (v1 as u128)) {
            v1
        } else {
            (v0 as u64)
        };
        if (v2 > 0) {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        }
    }

    fun calculate_realistic_cetus_fees(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 0 || arg0 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v0 = arg1 / 3600000;
        let v1 = arg0 * 500 * (v0 as u64) / 10000 * arg2 / 10000 * 50 / 10000;
        let v2 = arg0 / 1000 * (v0 as u64);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        if (v3 > 0) {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        }
    }

    fun cleanup_member_positions(arg0: &mut YieldConfig, arg1: address) {
        let v0 = get_member_navi_key(arg1);
        let v1 = get_member_cetus_key(arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, NaviPosition>(&mut arg0.id, v0);
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<vector<u8>, CetusPosition>(&mut arg0.id, v1);
        };
    }

    fun collect_all_member_yields(arg0: &mut YieldConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::clock::timestamp_ms(arg1);
        (0x2::coin::zero<0x2::sui::SUI>(arg2), 0x2::coin::zero<0x2::sui::SUI>(arg2))
    }

    fun collect_cetus_yield_for_member(arg0: address, arg1: &mut YieldConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_member_cetus_key(arg0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, CetusPosition>(&mut arg1.id, v0);
            let v3 = 0x2::clock::timestamp_ms(arg2);
            if (0x1::option::is_some<0x2::object::ID>(&v2.position_id)) {
                let v4 = calculate_realistic_cetus_fees(v2.lp_amount, v3 - v2.last_updated, 3000, arg3);
                v2.accrued_fees = v2.accrued_fees + 0x2::coin::value<0x2::sui::SUI>(&v4);
                v2.last_updated = v3;
                v4
            } else {
                0x2::coin::zero<0x2::sui::SUI>(arg3)
            }
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        }
    }

    public fun collect_member_yield(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut YieldConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0) || v0 == arg2, 100);
        let v1 = collect_navi_yield_for_member(arg2, arg1, arg3, arg4);
        (v1, collect_cetus_yield_for_member(arg2, arg1, arg3, arg4))
    }

    fun collect_navi_yield_for_member(arg0: address, arg1: &mut YieldConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_member_navi_key(arg0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, NaviPosition>(&mut arg1.id, v0);
            let v3 = 0x2::clock::timestamp_ms(arg2);
            let v4 = calculate_navi_compound_interest(v2.supplied_amount, v3 - v2.last_updated, 6810, arg3);
            v2.accrued_interest = v2.accrued_interest + 0x2::coin::value<0x2::sui::SUI>(&v4);
            v2.last_updated = v3;
            v4
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        }
    }

    public fun collect_real_cetus_fees_entry(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut YieldConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0) || v0 == arg2, 100);
        let v1 = get_member_cetus_key(arg2);
        let v2 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, CetusPosition>(&mut arg1.id, v1);
            let v4 = calculate_realistic_cetus_fees(v3.lp_amount, 0x2::clock::timestamp_ms(arg3) - v3.last_updated, 3000, arg4);
            v3.accrued_fees = v3.accrued_fees + 0x2::coin::value<0x2::sui::SUI>(&v4);
            v3.last_updated = 0x2::clock::timestamp_ms(arg3);
            v4
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        let v5 = v2;
        let v6 = YieldCollected{
            circle_id            : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            total_yield          : 0x2::coin::value<0x2::sui::SUI>(&v5),
            navi_yield           : 0,
            cetus_yield          : 0x2::coin::value<0x2::sui::SUI>(&v5),
            collection_timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<YieldCollected>(v6);
        v5
    }

    public fun collect_yield(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut YieldConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg4) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 100);
        assert!(arg2.is_active, 101);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v2, v3) = collect_all_member_yields(arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::coin::join<0x2::sui::SUI>(&mut v1, v5);
        0x2::coin::join<0x2::sui::SUI>(&mut v1, v4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        if (v6 > 0) {
            arg2.total_yield_earned = arg2.total_yield_earned + v6;
            arg2.last_yield_collection = v0;
            let v7 = YieldCollected{
                circle_id            : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
                total_yield          : v6,
                navi_yield           : 0x2::coin::value<0x2::sui::SUI>(&v5),
                cetus_yield          : 0x2::coin::value<0x2::sui::SUI>(&v4),
                collection_timestamp : v0,
            };
            0x2::event::emit<YieldCollected>(v7);
        };
        v1
    }

    public fun create_real_cetus_position_entry(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut YieldConfig, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0) || v0 == arg3, 100);
        assert!(arg2.is_active, 101);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xc7ae833c220aa73a3643a0d508afa4ac5d50d97312ea4584e35f9eb21b9df12);
        let v2 = CetusPosition{
            lp_amount    : v1,
            position_id  : 0x1::option::some<0x2::object::ID>(generate_cetus_position_id(v1, 0x2::clock::timestamp_ms(arg7), arg8)),
            last_updated : 0x2::clock::timestamp_ms(arg7),
            accrued_fees : 0,
        };
        0x2::dynamic_field::add<vector<u8>, CetusPosition>(&mut arg2.id, get_member_cetus_key(arg3), v2);
        arg2.total_deposited = arg2.total_deposited + v1;
        let v3 = SecurityDepositYieldGenerated{
            circle_id     : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            member        : arg3,
            total_deposit : v1,
            navi_amount   : 0,
            cetus_amount  : v1,
            strategy      : arg2.strategy,
            timestamp     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SecurityDepositYieldGenerated>(v3);
    }

    public fun create_yield_config(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: u8, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 100);
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 103);
        let (v1, v2) = get_strategy_allocations(arg1);
        let v3 = YieldConfig{
            id                           : 0x2::object::new(arg4),
            circle_id                    : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            strategy                     : arg1,
            navi_allocation_percentage   : v1,
            cetus_allocation_percentage  : v2,
            auto_compound                : arg2,
            emergency_withdrawal_enabled : true,
            total_deposited              : 0,
            total_yield_earned           : 0,
            last_yield_collection        : 0x2::clock::timestamp_ms(arg3),
            is_active                    : true,
        };
        0x2::transfer::share_object<YieldConfig>(v3);
        let v4 = YieldConfigCreated{
            circle_id        : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            config_id        : 0x2::object::uid_to_inner(&v3.id),
            strategy         : arg1,
            navi_allocation  : v1,
            cetus_allocation : v2,
        };
        0x2::event::emit<YieldConfigCreated>(v4);
    }

    public fun distribute_yield_on_completion(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut YieldConfig, arg3: address, arg4: YieldReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 100);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 108);
        assert!(arg4.circle_id == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 103);
        assert!(arg4.member_addr == arg3, 103);
        let v0 = calculate_member_yield_share(arg2, &arg4);
        cleanup_member_positions(arg2, arg3);
        let YieldReceipt {
            id                : v1,
            circle_id         : _,
            member_addr       : _,
            deposit_amount    : v4,
            navi_amount       : _,
            cetus_amount      : _,
            deposit_timestamp : _,
            strategy          : _,
        } = arg4;
        0x2::object::delete(v1);
        let v9 = YieldDistributed{
            circle_id        : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            member           : arg3,
            yield_amount     : v0,
            deposit_returned : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<YieldDistributed>(v9);
    }

    public fun emergency_withdraw_all(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut YieldConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 100);
        assert!(arg2.emergency_withdrawal_enabled, 105);
        arg2.is_active = false;
        let v0 = EmergencyWithdrawalExecuted{
            circle_id        : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            withdrawn_amount : arg2.total_deposited + arg2.total_yield_earned,
            reason           : arg3,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EmergencyWithdrawalExecuted>(v0);
    }

    fun generate_cetus_position_id(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    fun generate_navi_receipt_id(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun generate_yield_on_security_deposit(arg0: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut YieldConfig, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : YieldReceipt {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0) || v0 == arg3, 100);
        assert!(arg2.is_active, 101);
        assert!(arg2.circle_id == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 103);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 103);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw_from_dynamic_fields(arg1, arg4, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) == arg4, 109);
        let v2 = arg4 * arg2.navi_allocation_percentage / 10000;
        let v3 = arg4 * arg2.cetus_allocation_percentage / 10000;
        if (v2 > 0 && v3 > 0) {
            let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg6);
            let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg6);
            let v6 = handle_navi_deposit(v4, arg5, arg6);
            let v7 = handle_cetus_deposit(v5, arg5, arg6);
            0x2::dynamic_field::add<vector<u8>, NaviPosition>(&mut arg2.id, get_member_navi_key(arg3), v6);
            0x2::dynamic_field::add<vector<u8>, CetusPosition>(&mut arg2.id, get_member_cetus_key(arg3), v7);
            if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else if (v2 > 0) {
            let v8 = handle_navi_deposit(v1, arg5, arg6);
            0x2::dynamic_field::add<vector<u8>, NaviPosition>(&mut arg2.id, get_member_navi_key(arg3), v8);
            let v9 = CetusPosition{
                lp_amount    : 0,
                position_id  : 0x1::option::none<0x2::object::ID>(),
                last_updated : 0x2::clock::timestamp_ms(arg5),
                accrued_fees : 0,
            };
            0x2::dynamic_field::add<vector<u8>, CetusPosition>(&mut arg2.id, get_member_cetus_key(arg3), v9);
        } else if (v3 > 0) {
            let v10 = handle_cetus_deposit(v1, arg5, arg6);
            0x2::dynamic_field::add<vector<u8>, CetusPosition>(&mut arg2.id, get_member_cetus_key(arg3), v10);
            let v11 = NaviPosition{
                supplied_amount  : 0,
                receipt_id       : 0x1::option::none<0x2::object::ID>(),
                last_updated     : 0x2::clock::timestamp_ms(arg5),
                accrued_interest : 0,
            };
            0x2::dynamic_field::add<vector<u8>, NaviPosition>(&mut arg2.id, get_member_navi_key(arg3), v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3);
        };
        arg2.total_deposited = arg2.total_deposited + arg4;
        let v12 = YieldReceipt{
            id                : 0x2::object::new(arg6),
            circle_id         : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            member_addr       : arg3,
            deposit_amount    : arg4,
            navi_amount       : v2,
            cetus_amount      : v3,
            deposit_timestamp : 0x2::clock::timestamp_ms(arg5),
            strategy          : arg2.strategy,
        };
        let v13 = SecurityDepositYieldGenerated{
            circle_id     : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            member        : arg3,
            total_deposit : arg4,
            navi_amount   : v2,
            cetus_amount  : v3,
            strategy      : arg2.strategy,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SecurityDepositYieldGenerated>(v13);
        v12
    }

    public fun get_allocation_percentages(arg0: &YieldConfig) : (u64, u64) {
        (arg0.navi_allocation_percentage, arg0.cetus_allocation_percentage)
    }

    fun get_member_cetus_key(arg0: address) : vector<u8> {
        let v0 = b"cetus_";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        v0
    }

    fun get_member_navi_key(arg0: address) : vector<u8> {
        let v0 = b"navi_";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        v0
    }

    fun get_strategy_allocations(arg0: u8) : (u64, u64) {
        if (arg0 == 0) {
            (0, 10000)
        } else if (arg0 == 1) {
            (0, 10000)
        } else {
            (0, 10000)
        }
    }

    public fun get_total_deposited(arg0: &YieldConfig) : u64 {
        arg0.total_deposited
    }

    public fun get_total_yield_earned(arg0: &YieldConfig) : u64 {
        arg0.total_yield_earned
    }

    public fun get_yield_config_strategy(arg0: &YieldConfig) : u8 {
        arg0.strategy
    }

    fun handle_cetus_deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : CetusPosition {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = generate_cetus_position_id(v0, v1, arg2);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg2);
        generate_cetus_position_id(v0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, @0xc7ae833c220aa73a3643a0d508afa4ac5d50d97312ea4584e35f9eb21b9df12);
        CetusPosition{
            lp_amount    : v0,
            position_id  : 0x1::option::some<0x2::object::ID>(v2),
            last_updated : v1,
            accrued_fees : 0,
        }
    }

    fun handle_navi_deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : NaviPosition {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = generate_navi_receipt_id(v0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg2), @0xb7c4a2d8e5f1a6c9b3e7d2f8a4c6e9b1d5a8c2f7e4b9c6a3d8f1e5b2c7a9d4e6);
        NaviPosition{
            supplied_amount  : v0,
            receipt_id       : 0x1::option::some<0x2::object::ID>(v2),
            last_updated     : v1,
            accrued_interest : 0,
        }
    }

    public fun is_yield_active(arg0: &YieldConfig) : bool {
        arg0.is_active
    }

    // decompiled from Move bytecode v6
}

