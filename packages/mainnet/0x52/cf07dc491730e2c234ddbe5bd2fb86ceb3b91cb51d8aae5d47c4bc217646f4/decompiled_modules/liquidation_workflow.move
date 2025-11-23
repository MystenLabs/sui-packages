module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::liquidation_workflow {
    struct WorkoutRegistry has key {
        id: 0x2::object::UID,
        distressed_vaults: 0x2::table::Table<0x2::object::ID, WorkoutRecord>,
        total_distressed: u64,
        total_in_workout: u64,
        total_liquidated: u64,
        total_resolved: u64,
        admin: address,
        ai_servicer: address,
    }

    struct WorkoutRecord has copy, drop, store {
        vault_id: 0x2::object::ID,
        borrower: address,
        status: u8,
        days_delinquent: u64,
        missed_payments: u64,
        last_payment_date: u64,
        distress_date: u64,
        workout_start_date: u64,
        workout_end_date: u64,
        ready_for_liquidation: bool,
        liquidation_date: u64,
        borrower_responsive: bool,
        last_contact_date: u64,
        workout_plan_hash: vector<u8>,
        resolution_type: u8,
    }

    struct WorkoutPlan has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        created_at: u64,
        plan_hash: vector<u8>,
        weekly_updates: vector<WeeklyUpdate>,
        final_recommendation: u8,
        ai_confidence_score: u64,
    }

    struct WeeklyUpdate has copy, drop, store {
        week_number: u64,
        timestamp: u64,
        borrower_contacted: bool,
        borrower_responded: bool,
        payment_received: bool,
        payment_amount: u64,
        ai_notes_hash: vector<u8>,
        recommendation: u8,
    }

    struct VaultDistressed has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        days_delinquent: u64,
        missed_payments: u64,
        timestamp: u64,
    }

    struct WorkoutStarted has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        start_time: u64,
        expected_end_time: u64,
    }

    struct WorkoutWeeklyUpdate has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        week_number: u64,
        borrower_responsive: bool,
        recommendation: u8,
        timestamp: u64,
    }

    struct WorkoutResolved has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        resolution_type: u8,
        timestamp: u64,
    }

    struct LiquidationReady has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        days_in_workout: u64,
        borrower_responsive: bool,
        timestamp: u64,
    }

    struct LiquidationExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        collateral_amount: u64,
        proceeds_amount: u64,
        surplus_returned: u64,
        timestamp: u64,
    }

    struct DAOLiquidationVote has copy, drop {
        vault_id: 0x2::object::ID,
        votes_for: u64,
        votes_against: u64,
        approved: bool,
        timestamp: u64,
    }

    public entry fun escalate_to_liquidation(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin || v0 == arg0.ai_servicer, 1);
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
        assert!(v1.status == 2, 4);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v2 >= v1.workout_end_date, 5);
        assert!(!v1.borrower_responsive, 11);
        v1.status = 4;
        v1.ready_for_liquidation = true;
        let v3 = LiquidationReady{
            vault_id            : arg1,
            borrower            : v1.borrower,
            days_in_workout     : (v2 - v1.workout_start_date) / 86400,
            borrower_responsive : false,
            timestamp           : v2,
        };
        0x2::event::emit<LiquidationReady>(v3);
    }

    public entry fun execute_liquidation(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1);
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
        assert!(v0.ready_for_liquidation, 7);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        v0.status = 5;
        v0.liquidation_date = v1;
        arg0.total_liquidated = arg0.total_liquidated + 1;
        arg0.total_in_workout = arg0.total_in_workout - 1;
        let v2 = LiquidationExecuted{
            vault_id          : arg1,
            borrower          : v0.borrower,
            collateral_amount : arg2,
            proceeds_amount   : arg3,
            surplus_returned  : arg4,
            timestamp         : v1,
        };
        0x2::event::emit<LiquidationExecuted>(v2);
    }

    public fun get_registry_stats(arg0: &WorkoutRegistry) : (u64, u64, u64, u64) {
        (arg0.total_distressed, arg0.total_in_workout, arg0.total_liquidated, arg0.total_resolved)
    }

    public fun get_workout_record(arg0: &WorkoutRegistry, arg1: 0x2::object::ID) : (u8, u64, u64, u64, u64, bool, bool) {
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 9);
        let v0 = 0x2::table::borrow<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1);
        (v0.status, v0.days_delinquent, v0.missed_payments, v0.workout_start_date, v0.workout_end_date, v0.ready_for_liquidation, v0.borrower_responsive)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkoutRegistry{
            id                : 0x2::object::new(arg0),
            distressed_vaults : 0x2::table::new<0x2::object::ID, WorkoutRecord>(arg0),
            total_distressed  : 0,
            total_in_workout  : 0,
            total_liquidated  : 0,
            total_resolved    : 0,
            admin             : 0x2::tx_context::sender(arg0),
            ai_servicer       : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<WorkoutRegistry>(v0);
    }

    public fun is_in_workout(arg0: &WorkoutRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1).status == 2
    }

    public fun is_ready_for_liquidation(arg0: &WorkoutRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1).ready_for_liquidation
    }

    public entry fun mark_as_distressed(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg0.admin || v0 == arg0.ai_servicer, 1);
        assert!(arg3 >= 90, 2);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        if (0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
            v2.days_delinquent = arg3;
            v2.missed_payments = arg4;
            v2.status = 3;
        } else {
            let v3 = WorkoutRecord{
                vault_id              : arg1,
                borrower              : arg2,
                status                : 3,
                days_delinquent       : arg3,
                missed_payments       : arg4,
                last_payment_date     : arg5,
                distress_date         : v1,
                workout_start_date    : 0,
                workout_end_date      : 0,
                ready_for_liquidation : false,
                liquidation_date      : 0,
                borrower_responsive   : true,
                last_contact_date     : v1,
                workout_plan_hash     : 0x1::vector::empty<u8>(),
                resolution_type       : 0,
            };
            0x2::table::add<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1, v3);
            arg0.total_distressed = arg0.total_distressed + 1;
        };
        let v4 = VaultDistressed{
            vault_id        : arg1,
            borrower        : arg2,
            days_delinquent : arg3,
            missed_payments : arg4,
            timestamp       : v1,
        };
        0x2::event::emit<VaultDistressed>(v4);
    }

    public entry fun record_weekly_update(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg0.admin || v0 == arg0.ai_servicer, 1);
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
        assert!(v1.status == 2, 4);
        let v2 = 0x2::clock::timestamp_ms(arg9) / 1000;
        if (arg4) {
            v1.borrower_responsive = true;
            v1.last_contact_date = v2;
        } else if (!arg3) {
            v1.borrower_responsive = false;
        };
        if (arg5 && arg6 > 0) {
            if (v1.missed_payments > 0) {
                v1.missed_payments = v1.missed_payments - 1;
            };
        };
        let v3 = WorkoutWeeklyUpdate{
            vault_id            : arg1,
            borrower            : v1.borrower,
            week_number         : arg2,
            borrower_responsive : v1.borrower_responsive,
            recommendation      : arg8,
            timestamp           : v2,
        };
        0x2::event::emit<WorkoutWeeklyUpdate>(v3);
    }

    public entry fun resolve_workout(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin || v0 == arg0.ai_servicer, 1);
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
        assert!(v1.status == 2 || v1.status == 3, 8);
        v1.status = 6;
        v1.resolution_type = arg2;
        arg0.total_resolved = arg0.total_resolved + 1;
        if (v1.workout_start_date > 0) {
            arg0.total_in_workout = arg0.total_in_workout - 1;
        };
        let v2 = WorkoutResolved{
            vault_id        : arg1,
            borrower        : v1.borrower,
            resolution_type : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<WorkoutResolved>(v2);
    }

    public entry fun set_ai_servicer(arg0: &mut WorkoutRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.ai_servicer = arg1;
    }

    public entry fun start_workout_plan(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin || v0 == arg0.ai_servicer, 1);
        assert!(0x2::table::contains<0x2::object::ID, WorkoutRecord>(&arg0.distressed_vaults, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, WorkoutRecord>(&mut arg0.distressed_vaults, arg1);
        assert!(v1.status == 3, 8);
        assert!(v1.workout_start_date == 0, 3);
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000;
        v1.status = 2;
        v1.workout_start_date = v2;
        v1.workout_end_date = v2 + 15552000;
        v1.workout_plan_hash = arg2;
        arg0.total_in_workout = arg0.total_in_workout + 1;
        let v3 = WorkoutStarted{
            vault_id          : arg1,
            borrower          : v1.borrower,
            start_time        : v2,
            expected_end_time : v1.workout_end_date,
        };
        0x2::event::emit<WorkoutStarted>(v3);
    }

    public entry fun transfer_admin(arg0: &mut WorkoutRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

