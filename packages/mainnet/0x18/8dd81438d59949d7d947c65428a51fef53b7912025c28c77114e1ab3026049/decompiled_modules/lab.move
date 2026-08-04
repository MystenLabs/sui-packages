module 0x188dd81438d59949d7d947c65428a51fef53b7912025c28c77114e1ab3026049::lab {
    struct TrialRecord has copy, drop, store {
        opener_applied: bool,
        opener_nonce: u64,
        backrun_applied: bool,
    }

    struct Opportunity has key {
        id: 0x2::object::UID,
        admin: address,
        opener_count: u64,
        backrun_count: u64,
        trials: 0x2::table::Table<u64, TrialRecord>,
    }

    struct OpenerApplied has copy, drop {
        opportunity: address,
        trial: u64,
        opener_nonce: u64,
    }

    struct BackrunApplied has copy, drop {
        opportunity: address,
        trial: u64,
        observed_opener_nonce: u64,
    }

    public fun admin(arg0: &Opportunity) : address {
        arg0.admin
    }

    public fun backrun(arg0: &mut Opportunity, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0, 6);
        assert!(arg2 != 0, 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(0x2::table::contains<u64, TrialRecord>(&arg0.trials, arg1), 3);
        let v0 = *0x2::table::borrow<u64, TrialRecord>(&arg0.trials, arg1);
        assert!(v0.opener_applied, 3);
        assert!(v0.opener_nonce == arg2, 3);
        assert!(!v0.backrun_applied, 4);
        0x2::table::borrow_mut<u64, TrialRecord>(&mut arg0.trials, arg1).backrun_applied = true;
        arg0.backrun_count = arg0.backrun_count + 1;
        let v1 = BackrunApplied{
            opportunity           : 0x2::object::uid_to_address(&arg0.id),
            trial                 : arg1,
            observed_opener_nonce : arg2,
        };
        0x2::event::emit<BackrunApplied>(v1);
    }

    public fun backrun_count(arg0: &Opportunity) : u64 {
        arg0.backrun_count
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Opportunity{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            opener_count  : 0,
            backrun_count : 0,
            trials        : 0x2::table::new<u64, TrialRecord>(arg0),
        };
        0x2::transfer::share_object<Opportunity>(v0);
    }

    public fun has_trial(arg0: &Opportunity, arg1: u64) : bool {
        0x2::table::contains<u64, TrialRecord>(&arg0.trials, arg1)
    }

    public fun opener(arg0: &mut Opportunity, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0, 6);
        assert!(arg2 != 0, 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(!0x2::table::contains<u64, TrialRecord>(&arg0.trials, arg1), 5);
        let v0 = TrialRecord{
            opener_applied  : true,
            opener_nonce    : arg2,
            backrun_applied : false,
        };
        0x2::table::add<u64, TrialRecord>(&mut arg0.trials, arg1, v0);
        arg0.opener_count = arg0.opener_count + 1;
        let v1 = OpenerApplied{
            opportunity  : 0x2::object::uid_to_address(&arg0.id),
            trial        : arg1,
            opener_nonce : arg2,
        };
        0x2::event::emit<OpenerApplied>(v1);
    }

    public fun opener_count(arg0: &Opportunity) : u64 {
        arg0.opener_count
    }

    public fun trial_backrun_applied(arg0: &Opportunity, arg1: u64) : bool {
        0x2::table::borrow<u64, TrialRecord>(&arg0.trials, arg1).backrun_applied
    }

    public fun trial_count(arg0: &Opportunity) : u64 {
        0x2::table::length<u64, TrialRecord>(&arg0.trials)
    }

    public fun trial_opener_applied(arg0: &Opportunity, arg1: u64) : bool {
        0x2::table::borrow<u64, TrialRecord>(&arg0.trials, arg1).opener_applied
    }

    public fun trial_opener_nonce(arg0: &Opportunity, arg1: u64) : u64 {
        0x2::table::borrow<u64, TrialRecord>(&arg0.trials, arg1).opener_nonce
    }

    // decompiled from Move bytecode v7
}

