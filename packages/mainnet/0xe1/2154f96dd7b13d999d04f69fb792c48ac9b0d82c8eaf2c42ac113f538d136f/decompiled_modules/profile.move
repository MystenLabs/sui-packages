module 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile {
    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct PunditProfile has key {
        id: 0x2::object::UID,
        owner: address,
        created_at_ms: u64,
        total_predictions: u64,
        correct: u64,
        wrong: u64,
        respect_score: u64,
        relationship_state: u8,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        created_at_ms: u64,
    }

    public(friend) fun apply_verdict(arg0: &mut PunditProfile, arg1: bool) {
        if (arg1) {
            arg0.correct = arg0.correct + 1;
        } else {
            arg0.wrong = arg0.wrong + 1;
        };
        recompute(arg0);
    }

    public fun correct(arg0: &PunditProfile) : u64 {
        arg0.correct
    }

    public fun create_profile(arg0: &mut ProfileRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = PunditProfile{
            id                 : 0x2::object::new(arg2),
            owner              : v0,
            created_at_ms      : v1,
            total_predictions  : 0,
            correct            : 0,
            wrong              : 0,
            respect_score      : 50,
            relationship_state : 0,
        };
        let v3 = 0x2::object::id<PunditProfile>(&v2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v3);
        let v4 = ProfileCreated{
            profile_id    : v3,
            owner         : v0,
            created_at_ms : v1,
        };
        0x2::event::emit<ProfileCreated>(v4);
        0x2::transfer::share_object<PunditProfile>(v2);
    }

    public fun has_profile(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistry{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ProfileRegistry>(v0);
    }

    public fun owner(arg0: &PunditProfile) : address {
        arg0.owner
    }

    fun recompute(arg0: &mut PunditProfile) {
        let v0 = arg0.correct + arg0.wrong;
        if (v0 == 0) {
            arg0.respect_score = 50;
            arg0.relationship_state = 0;
            return
        };
        let v1 = arg0.correct * 100 / v0;
        arg0.respect_score = v1;
        let v2 = if (v0 < 2) {
            0
        } else if (v1 < 35) {
            1
        } else if (v1 < 55) {
            2
        } else if (v1 < 80) {
            3
        } else {
            4
        };
        arg0.relationship_state = v2;
    }

    public(friend) fun record_commit(arg0: &mut PunditProfile) {
        arg0.total_predictions = arg0.total_predictions + 1;
    }

    public fun relationship_state(arg0: &PunditProfile) : u8 {
        arg0.relationship_state
    }

    public fun respect_score(arg0: &PunditProfile) : u64 {
        arg0.respect_score
    }

    public fun total_predictions(arg0: &PunditProfile) : u64 {
        arg0.total_predictions
    }

    public fun wrong(arg0: &PunditProfile) : u64 {
        arg0.wrong
    }

    // decompiled from Move bytecode v6
}

