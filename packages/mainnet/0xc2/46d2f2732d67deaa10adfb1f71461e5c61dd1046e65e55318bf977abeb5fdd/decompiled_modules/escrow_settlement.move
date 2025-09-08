module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::escrow_settlement {
    struct EscrowRegistry has key {
        id: 0x2::object::UID,
        escrows: 0x2::table::Table<0x2::object::ID, Escrow>,
        total_escrowed: u64,
        total_released: u64,
        total_refunded: u64,
        custom_metrics: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>,
    }

    struct Escrow has store {
        event_id: 0x2::object::ID,
        organizer: address,
        sponsor: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        conditions: 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::SponsorConditions,
        created_at: u64,
        settled: bool,
        settlement_time: u64,
        settlement_result: SettlementResult,
    }

    struct SettlementResult has copy, drop, store {
        conditions_met: bool,
        attendees_actual: u64,
        attendees_required: u64,
        completion_rate_actual: u64,
        completion_rate_required: u64,
        avg_rating_actual: u64,
        avg_rating_required: u64,
        amount_released: u64,
        amount_refunded: u64,
    }

    struct EscrowCreated has copy, drop {
        event_id: 0x2::object::ID,
        organizer: address,
        sponsor: address,
        amount: u64,
        created_at: u64,
    }

    struct FundsReleased has copy, drop {
        event_id: 0x2::object::ID,
        organizer: address,
        amount: u64,
        settlement_time: u64,
    }

    struct FundsRefunded has copy, drop {
        event_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        reason: 0x1::string::String,
    }

    struct SettlementCompleted has copy, drop {
        event_id: 0x2::object::ID,
        result: SettlementResult,
    }

    public fun add_funds_to_escrow(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut EscrowRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg2.escrows, arg0), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Escrow>(&mut arg2.escrows, arg0);
        assert!(!v0.settled, 3);
        assert!(0x2::tx_context::sender(arg3) == v0.sponsor, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg2.total_escrowed = arg2.total_escrowed + 0x2::coin::value<0x2::sui::SUI>(&arg1);
    }

    public fun check_conditions_status(arg0: 0x2::object::ID, arg1: &EscrowRegistry, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry) : (bool, u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg1.escrows, arg0), 6);
        let (v0, v1, v2, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_condition_details(&0x2::table::borrow<0x2::object::ID, Escrow>(&arg1.escrows, arg0).conditions);
        let (v4, _, v6) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_event_stats(arg0, arg2);
        let v7 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::get_event_average_rating(arg0, arg3);
        let v8 = if (v4 >= v0) {
            if (v6 >= v1) {
                v7 >= v2
            } else {
                false
            }
        } else {
            false
        };
        (v8, v4, v6, v7)
    }

    public fun check_custom_benchmarks_status(arg0: 0x2::object::ID, arg1: 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::SponsorConditions, arg2: &EscrowRegistry) : bool {
        evaluate_custom_benchmarks(arg0, arg1, arg2)
    }

    public fun create_escrow(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut EscrowRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 1);
        assert!(!0x2::table::contains<0x2::object::ID, Escrow>(&arg3.escrows, v0), 3);
        let v2 = SettlementResult{
            conditions_met           : false,
            attendees_actual         : 0,
            attendees_required       : 0,
            completion_rate_actual   : 0,
            completion_rate_required : 0,
            avg_rating_actual        : 0,
            avg_rating_required      : 0,
            amount_released          : 0,
            amount_refunded          : 0,
        };
        let v3 = Escrow{
            event_id          : v0,
            organizer         : 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0),
            sponsor           : arg1,
            balance           : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            conditions        : *0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_sponsor_conditions(arg0),
            created_at        : 0x2::clock::timestamp_ms(arg4),
            settled           : false,
            settlement_time   : 0,
            settlement_result : v2,
        };
        0x2::table::add<0x2::object::ID, Escrow>(&mut arg3.escrows, v0, v3);
        arg3.total_escrowed = arg3.total_escrowed + v1;
        let v4 = EscrowCreated{
            event_id   : v0,
            organizer  : 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0),
            sponsor    : arg1,
            amount     : v1,
            created_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EscrowCreated>(v4);
    }

    public fun emergency_withdraw(arg0: 0x2::object::ID, arg1: &mut EscrowRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg1.escrows, arg0), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Escrow>(&mut arg1.escrows, arg0);
        assert!(!v0.settled, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v0.organizer || v1 == v0.sponsor, 5);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 > v0.created_at + 604800000, 7);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.balance), arg3), v0.sponsor);
        arg1.total_refunded = arg1.total_refunded + v3;
        v0.settled = true;
        v0.settlement_time = v2;
        let v4 = FundsRefunded{
            event_id : arg0,
            sponsor  : v0.sponsor,
            amount   : v3,
            reason   : 0x1::string::utf8(b"Emergency withdrawal after grace period"),
        };
        0x2::event::emit<FundsRefunded>(v4);
    }

    fun evaluate_custom_benchmarks(arg0: 0x2::object::ID, arg1: 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::SponsorConditions, arg2: &EscrowRegistry) : bool {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_custom_benchmarks(&arg1);
        let v1 = 0x1::vector::length<0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::CustomBenchmark>(v0);
        if (v1 == 0) {
            return true
        };
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(&arg2.custom_metrics, arg0)) {
            return false
        };
        let v2 = 0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(&arg2.custom_metrics, arg0);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow<0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::CustomBenchmark>(v0, v3);
            let v5 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_benchmark_metric_name(v4);
            let v6 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_benchmark_comparison_type(v4);
            if (!0x2::table::contains<0x1::string::String, u64>(v2, v5)) {
                return false
            };
            let v7 = v6 == 0 && *0x2::table::borrow<0x1::string::String, u64>(v2, v5) >= 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_benchmark_target_value(v4) || v6 == 1 && *0x2::table::borrow<0x1::string::String, u64>(v2, v5) <= 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_benchmark_target_value(v4) || v6 == 2 && *0x2::table::borrow<0x1::string::String, u64>(v2, v5) == 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_benchmark_target_value(v4);
            if (!v7) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun get_escrow_details(arg0: 0x2::object::ID, arg1: &EscrowRegistry) : (address, address, u64, bool, u64) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg1.escrows, arg0), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, Escrow>(&arg1.escrows, arg0);
        (v0.organizer, v0.sponsor, 0x2::balance::value<0x2::sui::SUI>(&v0.balance), v0.settled, v0.settlement_time)
    }

    public fun get_global_stats(arg0: &EscrowRegistry) : (u64, u64, u64) {
        (arg0.total_escrowed, arg0.total_released, arg0.total_refunded)
    }

    public fun get_settlement_result(arg0: 0x2::object::ID, arg1: &EscrowRegistry) : SettlementResult {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg1.escrows, arg0), 6);
        0x2::table::borrow<0x2::object::ID, Escrow>(&arg1.escrows, arg0).settlement_result
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowRegistry{
            id             : 0x2::object::new(arg0),
            escrows        : 0x2::table::new<0x2::object::ID, Escrow>(arg0),
            total_escrowed : 0,
            total_released : 0,
            total_refunded : 0,
            custom_metrics : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(arg0),
        };
        0x2::transfer::share_object<EscrowRegistry>(v0);
    }

    public fun settle_escrow(arg0: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: 0x2::object::ID, arg2: &mut EscrowRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry, arg5: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg2.escrows, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, Escrow>(&arg2.escrows, arg1);
        let v1 = v0.organizer;
        let v2 = v0.sponsor;
        let v3 = v0.conditions;
        assert!(!v0.settled, 3);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_completed(arg0), 2);
        assert!(0x2::tx_context::sender(arg7) == v1 || 0x2::tx_context::sender(arg7) == v2, 5);
        let (v4, _, v6) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_event_stats(arg1, arg3);
        let v7 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::get_event_average_rating(arg1, arg4);
        let (v8, v9, v10, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_condition_details(&v3);
        let v12 = v4 >= v8;
        let v13 = v6 >= v9;
        let v14 = v7 >= v10;
        let v15 = evaluate_custom_benchmarks(arg1, v3, arg2);
        let v16 = if (v12) {
            if (v13) {
                if (v14) {
                    v15
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v17 = 0x2::table::borrow_mut<0x2::object::ID, Escrow>(&mut arg2.escrows, arg1);
        let v18 = 0x2::balance::value<0x2::sui::SUI>(&v17.balance);
        let v19 = 0x2::clock::timestamp_ms(arg6);
        if (v16) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v17.balance), arg7), v1);
            arg2.total_released = arg2.total_released + v18;
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::mark_event_settled(arg0, true, arg5);
            let v20 = FundsReleased{
                event_id        : arg1,
                organizer       : v1,
                amount          : v18,
                settlement_time : v19,
            };
            0x2::event::emit<FundsReleased>(v20);
            let v21 = SettlementResult{
                conditions_met           : true,
                attendees_actual         : v4,
                attendees_required       : v8,
                completion_rate_actual   : v6,
                completion_rate_required : v9,
                avg_rating_actual        : v7,
                avg_rating_required      : v10,
                amount_released          : v18,
                amount_refunded          : 0,
            };
            v17.settlement_result = v21;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v17.balance), arg7), v2);
            arg2.total_refunded = arg2.total_refunded + v18;
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::mark_event_settled(arg0, false, arg5);
            let v22 = 0x1::string::utf8(b"Conditions not met: ");
            if (!v12) {
                0x1::string::append(&mut v22, 0x1::string::utf8(b"insufficient attendees, "));
            };
            if (!v13) {
                0x1::string::append(&mut v22, 0x1::string::utf8(b"low completion rate, "));
            };
            if (!v14) {
                0x1::string::append(&mut v22, 0x1::string::utf8(b"low rating, "));
            };
            if (!v15) {
                0x1::string::append(&mut v22, 0x1::string::utf8(b"custom benchmarks not met, "));
            };
            let v23 = FundsRefunded{
                event_id : arg1,
                sponsor  : v2,
                amount   : v18,
                reason   : v22,
            };
            0x2::event::emit<FundsRefunded>(v23);
            let v24 = SettlementResult{
                conditions_met           : false,
                attendees_actual         : v4,
                attendees_required       : v8,
                completion_rate_actual   : v6,
                completion_rate_required : v9,
                avg_rating_actual        : v7,
                avg_rating_required      : v10,
                amount_released          : 0,
                amount_refunded          : v18,
            };
            v17.settlement_result = v24;
        };
        v17.settled = true;
        v17.settlement_time = v19;
        let v25 = SettlementCompleted{
            event_id : arg1,
            result   : v17.settlement_result,
        };
        0x2::event::emit<SettlementCompleted>(v25);
    }

    public fun update_custom_metric(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: &mut EscrowRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Escrow>(&arg3.escrows, arg0), 6);
        assert!(0x2::tx_context::sender(arg4) == 0x2::table::borrow<0x2::object::ID, Escrow>(&arg3.escrows, arg0).organizer, 5);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(&arg3.custom_metrics, arg0)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(&mut arg3.custom_metrics, arg0, 0x2::table::new<0x1::string::String, u64>(arg4));
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x1::string::String, u64>>(&mut arg3.custom_metrics, arg0);
        if (0x2::table::contains<0x1::string::String, u64>(v0, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(v0, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(v0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

