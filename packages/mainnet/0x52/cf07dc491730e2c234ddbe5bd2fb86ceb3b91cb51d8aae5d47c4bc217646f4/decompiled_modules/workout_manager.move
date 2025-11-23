module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::workout_manager {
    struct WorkoutRegistry has key {
        id: 0x2::object::UID,
        vault_workouts: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        total_workouts: u64,
        active_workouts: u64,
        completed_workouts: u64,
        admin: address,
    }

    struct WorkoutPlan has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        status: u8,
        workout_type: vector<u8>,
        forbearance_active: bool,
        forbearance_start_time: u64,
        forbearance_end_time: u64,
        forbearance_duration_seconds: u64,
        payments_paused: u64,
        original_balance: u64,
        original_rate_bps: u64,
        original_term_months: u64,
        original_payment: u64,
        modification_offered: bool,
        offered_rate_bps: u64,
        offered_term_extension_months: u64,
        offered_principal_forbearance: u64,
        offered_new_payment: u64,
        offer_timestamp: u64,
        modification_accepted: bool,
        modification_accepted_time: u64,
        applied_rate_bps: u64,
        applied_term_extension_months: u64,
        applied_principal_forbearance: u64,
        applied_new_payment: u64,
        trial_payments_made: u64,
        trial_payments_required: u64,
        last_payment_time: u64,
        created_at: u64,
        updated_at: u64,
        completed_at: u64,
    }

    struct WorkoutAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WorkoutStarted has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        borrower: address,
        original_balance: u64,
        timestamp: u64,
    }

    struct ForbearanceActivated has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        duration_seconds: u64,
        end_time: u64,
        payments_paused: u64,
    }

    struct ForbearanceExtended has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        extension_seconds: u64,
        new_end_time: u64,
    }

    struct ForbearanceEnded has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        total_duration_seconds: u64,
    }

    struct ModificationOffered has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        offered_rate_bps: u64,
        offered_term_extension: u64,
        offered_principal_forbearance: u64,
        offered_new_payment: u64,
        timestamp: u64,
    }

    struct ModificationAccepted has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        new_rate_bps: u64,
        term_extension_months: u64,
        new_payment: u64,
        timestamp: u64,
    }

    struct ModificationRejected has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TrialPaymentRecorded has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        payment_number: u64,
        payments_remaining: u64,
        timestamp: u64,
    }

    struct WorkoutCompleted has copy, drop {
        workout_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        total_trial_payments: u64,
        completion_type: vector<u8>,
        timestamp: u64,
    }

    public entry fun accept_modification(arg0: &mut WorkoutPlan, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 1);
        assert!(arg0.modification_offered, 6);
        assert!(!arg0.modification_accepted, 7);
        assert!(arg0.status == 1, 8);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        arg0.modification_accepted = true;
        arg0.modification_accepted_time = v0;
        arg0.applied_rate_bps = arg0.offered_rate_bps;
        arg0.applied_term_extension_months = arg0.offered_term_extension_months;
        arg0.applied_principal_forbearance = arg0.offered_principal_forbearance;
        arg0.applied_new_payment = arg0.offered_new_payment;
        arg0.updated_at = v0;
        let v1 = ModificationAccepted{
            workout_id            : 0x2::object::id<WorkoutPlan>(arg0),
            vault_id              : arg0.vault_id,
            new_rate_bps          : arg0.applied_rate_bps,
            term_extension_months : arg0.applied_term_extension_months,
            new_payment           : arg0.applied_new_payment,
            timestamp             : v0,
        };
        0x2::event::emit<ModificationAccepted>(v1);
    }

    public entry fun activate_forbearance(arg0: &mut WorkoutPlan, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 1);
        assert!(arg0.status == 1, 8);
        assert!(!arg0.forbearance_active, 4);
        let v0 = if (arg1 == 0) {
            2592000
        } else {
            arg1
        };
        assert!(v0 <= 7776000, 10);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = v1 + v0;
        arg0.forbearance_active = true;
        arg0.forbearance_start_time = v1;
        arg0.forbearance_end_time = v2;
        arg0.forbearance_duration_seconds = v0;
        arg0.payments_paused = v0 / 2592000 + 1;
        arg0.updated_at = v1;
        let v3 = ForbearanceActivated{
            workout_id       : 0x2::object::id<WorkoutPlan>(arg0),
            vault_id         : arg0.vault_id,
            duration_seconds : v0,
            end_time         : v2,
            payments_paused  : arg0.payments_paused,
        };
        0x2::event::emit<ForbearanceActivated>(v3);
    }

    public entry fun cancel_workout(arg0: &WorkoutAdminCap, arg1: &mut WorkoutRegistry, arg2: &mut WorkoutPlan, arg3: &0x2::clock::Clock) {
        assert!(arg2.status == 1, 8);
        arg2.status = 4;
        arg2.forbearance_active = false;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg3) / 1000;
        arg1.active_workouts = arg1.active_workouts - 1;
    }

    public entry fun complete_workout(arg0: &WorkoutAdminCap, arg1: &mut WorkoutRegistry, arg2: &mut WorkoutPlan, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2.status == 1, 8);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        arg2.status = 2;
        arg2.completed_at = v0;
        arg2.updated_at = v0;
        arg1.active_workouts = arg1.active_workouts - 1;
        arg1.completed_workouts = arg1.completed_workouts + 1;
        let v1 = WorkoutCompleted{
            workout_id           : 0x2::object::id<WorkoutPlan>(arg2),
            vault_id             : arg2.vault_id,
            total_trial_payments : arg2.trial_payments_made,
            completion_type      : arg3,
            timestamp            : v0,
        };
        0x2::event::emit<WorkoutCompleted>(v1);
    }

    public entry fun end_forbearance(arg0: &mut WorkoutPlan, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 1);
        assert!(arg0.forbearance_active, 5);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        arg0.forbearance_active = false;
        arg0.updated_at = v0;
        let v1 = if (v0 > arg0.forbearance_start_time) {
            v0 - arg0.forbearance_start_time
        } else {
            0
        };
        let v2 = ForbearanceEnded{
            workout_id             : 0x2::object::id<WorkoutPlan>(arg0),
            vault_id               : arg0.vault_id,
            total_duration_seconds : v1,
        };
        0x2::event::emit<ForbearanceEnded>(v2);
    }

    public entry fun extend_forbearance(arg0: &mut WorkoutPlan, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 1);
        assert!(arg0.forbearance_active, 5);
        assert!(arg0.status == 1, 8);
        let v0 = arg0.forbearance_duration_seconds + arg1;
        assert!(v0 <= 7776000, 10);
        let v1 = arg0.forbearance_end_time + arg1;
        arg0.forbearance_end_time = v1;
        arg0.forbearance_duration_seconds = v0;
        arg0.payments_paused = v0 / 2592000 + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = ForbearanceExtended{
            workout_id        : 0x2::object::id<WorkoutPlan>(arg0),
            vault_id          : arg0.vault_id,
            extension_seconds : arg1,
            new_end_time      : v1,
        };
        0x2::event::emit<ForbearanceExtended>(v2);
    }

    public fun get_borrower(arg0: &WorkoutPlan) : address {
        arg0.borrower
    }

    public fun get_forbearance_end_time(arg0: &WorkoutPlan) : u64 {
        arg0.forbearance_end_time
    }

    public fun get_new_payment(arg0: &WorkoutPlan) : u64 {
        arg0.applied_new_payment
    }

    public fun get_registry_stats(arg0: &WorkoutRegistry) : (u64, u64, u64) {
        (arg0.total_workouts, arg0.active_workouts, arg0.completed_workouts)
    }

    public fun get_status(arg0: &WorkoutPlan) : u8 {
        arg0.status
    }

    public fun get_trial_progress(arg0: &WorkoutPlan) : (u64, u64) {
        (arg0.trial_payments_made, arg0.trial_payments_required)
    }

    public fun get_vault_id(arg0: &WorkoutPlan) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun has_active_workout(arg0: &WorkoutRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vault_workouts, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkoutRegistry{
            id                 : 0x2::object::new(arg0),
            vault_workouts     : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            total_workouts     : 0,
            active_workouts    : 0,
            completed_workouts : 0,
            admin              : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<WorkoutRegistry>(v0);
        let v1 = WorkoutAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WorkoutAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_forbearance_active(arg0: &WorkoutPlan) : bool {
        arg0.forbearance_active
    }

    public fun is_modification_accepted(arg0: &WorkoutPlan) : bool {
        arg0.modification_accepted
    }

    public fun is_modification_offered(arg0: &WorkoutPlan) : bool {
        arg0.modification_offered
    }

    public entry fun record_trial_payment(arg0: &WorkoutAdminCap, arg1: &mut WorkoutPlan, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 8);
        assert!(arg1.modification_accepted, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        arg1.trial_payments_made = arg1.trial_payments_made + 1;
        arg1.last_payment_time = v0;
        arg1.updated_at = v0;
        let v1 = if (arg1.trial_payments_required > arg1.trial_payments_made) {
            arg1.trial_payments_required - arg1.trial_payments_made
        } else {
            0
        };
        let v2 = TrialPaymentRecorded{
            workout_id         : 0x2::object::id<WorkoutPlan>(arg1),
            vault_id           : arg1.vault_id,
            payment_number     : arg1.trial_payments_made,
            payments_remaining : v1,
            timestamp          : v0,
        };
        0x2::event::emit<TrialPaymentRecorded>(v2);
    }

    public entry fun reject_modification(arg0: &mut WorkoutPlan, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 1);
        assert!(arg0.modification_offered, 6);
        assert!(!arg0.modification_accepted, 7);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        arg0.modification_offered = false;
        arg0.offered_rate_bps = 0;
        arg0.offered_term_extension_months = 0;
        arg0.offered_principal_forbearance = 0;
        arg0.offered_new_payment = 0;
        arg0.offer_timestamp = 0;
        arg0.updated_at = v0;
        let v1 = ModificationRejected{
            workout_id : 0x2::object::id<WorkoutPlan>(arg0),
            vault_id   : arg0.vault_id,
            timestamp  : v0,
        };
        0x2::event::emit<ModificationRejected>(v1);
    }

    public entry fun start_workout(arg0: &mut WorkoutRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vault_workouts, arg1), 2);
        let v2 = WorkoutPlan{
            id                            : 0x2::object::new(arg8),
            vault_id                      : arg1,
            borrower                      : v0,
            status                        : 1,
            workout_type                  : arg6,
            forbearance_active            : false,
            forbearance_start_time        : 0,
            forbearance_end_time          : 0,
            forbearance_duration_seconds  : 0,
            payments_paused               : 0,
            original_balance              : arg2,
            original_rate_bps             : arg3,
            original_term_months          : arg4,
            original_payment              : arg5,
            modification_offered          : false,
            offered_rate_bps              : 0,
            offered_term_extension_months : 0,
            offered_principal_forbearance : 0,
            offered_new_payment           : 0,
            offer_timestamp               : 0,
            modification_accepted         : false,
            modification_accepted_time    : 0,
            applied_rate_bps              : 0,
            applied_term_extension_months : 0,
            applied_principal_forbearance : 0,
            applied_new_payment           : 0,
            trial_payments_made           : 0,
            trial_payments_required       : 6,
            last_payment_time             : 0,
            created_at                    : v1,
            updated_at                    : v1,
            completed_at                  : 0,
        };
        let v3 = 0x2::object::id<WorkoutPlan>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_workouts, arg1, v3);
        arg0.total_workouts = arg0.total_workouts + 1;
        arg0.active_workouts = arg0.active_workouts + 1;
        let v4 = WorkoutStarted{
            workout_id       : v3,
            vault_id         : arg1,
            borrower         : v0,
            original_balance : arg2,
            timestamp        : v1,
        };
        0x2::event::emit<WorkoutStarted>(v4);
        0x2::transfer::share_object<WorkoutPlan>(v2);
    }

    public entry fun store_modification_offer(arg0: &WorkoutAdminCap, arg1: &mut WorkoutPlan, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 8);
        assert!(!arg1.modification_accepted, 7);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        arg1.modification_offered = true;
        arg1.offered_rate_bps = arg2;
        arg1.offered_term_extension_months = arg3;
        arg1.offered_principal_forbearance = arg4;
        arg1.offered_new_payment = arg5;
        arg1.offer_timestamp = v0;
        arg1.updated_at = v0;
        let v1 = ModificationOffered{
            workout_id                    : 0x2::object::id<WorkoutPlan>(arg1),
            vault_id                      : arg1.vault_id,
            offered_rate_bps              : arg2,
            offered_term_extension        : arg3,
            offered_principal_forbearance : arg4,
            offered_new_payment           : arg5,
            timestamp                     : v0,
        };
        0x2::event::emit<ModificationOffered>(v1);
    }

    public entry fun update_admin(arg0: &WorkoutAdminCap, arg1: &mut WorkoutRegistry, arg2: address) {
        arg1.admin = arg2;
    }

    // decompiled from Move bytecode v6
}

