module 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::round {
    struct RoundManager has store, key {
        id: 0x2::object::UID,
        round_duration_ms: u64,
        genesis_timestamp_ms: u64,
        rounds: 0x2::object_table::ObjectTable<u64, Round>,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        round_no: u64,
        end_time_ms: u64,
        start_time_ms: u64,
    }

    struct Storage has store {
        inner: 0x2::bag::Bag,
    }

    struct RoundStarted has copy, drop {
        round_no: u64,
        end_time_ms: u64,
        start_time_ms: u64,
    }

    public fun commit_end_time_ms(arg0: &Round) : u64 {
        arg0.start_time_ms + (arg0.end_time_ms - arg0.start_time_ms) / 2
    }

    public fun current_round(arg0: &mut RoundManager, arg1: &0x2::clock::Clock) : &Round {
        let v0 = round_no_for_timestamp(arg0, 0x2::clock::timestamp_ms(arg1));
        ensure_round_exists(arg0, v0)
    }

    public fun current_round_mut(arg0: &mut RoundManager, arg1: &0x2::clock::Clock) : &mut Round {
        let v0 = round_no_for_timestamp(arg0, 0x2::clock::timestamp_ms(arg1));
        ensure_round_exists(arg0, v0)
    }

    public fun current_round_no(arg0: &RoundManager, arg1: &0x2::clock::Clock) : u64 {
        round_no_for_timestamp(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun end_time_ms(arg0: &Round) : u64 {
        arg0.end_time_ms
    }

    fun ensure_round_exists(arg0: &mut RoundManager, arg1: u64) : &mut Round {
        if (!0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1)) {
            let (v0, v1) = round_boundaries(arg0, arg1);
            let v2 = Round{
                id            : 0x2::derived_object::claim<u64>(&mut arg0.id, arg1),
                round_no      : arg1,
                end_time_ms   : v1,
                start_time_ms : v0,
            };
            0x2::object_table::add<u64, Round>(&mut arg0.rounds, arg1, v2);
            let v3 = RoundStarted{
                round_no      : arg1,
                end_time_ms   : v1,
                start_time_ms : v0,
            };
            0x2::event::emit<RoundStarted>(v3);
        };
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1)
    }

    public fun genesis_timestamp_ms(arg0: &RoundManager) : u64 {
        arg0.genesis_timestamp_ms
    }

    public fun get_next_round_no(arg0: &RoundManager, arg1: &0x2::clock::Clock) : u64 {
        current_round_no(arg0, arg1) + 1
    }

    public(friend) fun get_or_create_round(arg0: &mut RoundManager, arg1: u64) : &Round {
        ensure_round_exists(arg0, arg1)
    }

    public fun get_round(arg0: &RoundManager, arg1: u64) : &Round {
        assert!(0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1), 0);
        0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1)
    }

    public fun get_round_for_timestamp(arg0: &mut RoundManager, arg1: u64) : &Round {
        let v0 = round_no_for_timestamp(arg0, arg1);
        ensure_round_exists(arg0, v0)
    }

    public fun get_round_mut(arg0: &mut RoundManager, arg1: u64) : &mut Round {
        assert!(0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1), 0);
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1)
    }

    public fun initialize_storage(arg0: &mut Round, arg1: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::ResolverCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_storage_initialized(arg0, arg1), 1);
        let v0 = Storage{inner: 0x2::bag::new(arg2)};
        0x2::dynamic_field::add<0x2::object::ID, Storage>(&mut arg0.id, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::cap_resolver_id(arg1), v0);
    }

    public fun is_in_commit_phase(arg0: &Round, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.start_time_ms && v0 < commit_end_time_ms(arg0)
    }

    public fun is_in_reveal_phase(arg0: &Round, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= commit_end_time_ms(arg0) && v0 < arg0.end_time_ms
    }

    public fun is_round_active(arg0: &RoundManager, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1)) {
            return false
        };
        let v0 = 0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        v1 >= v0.start_time_ms && v1 < v0.end_time_ms
    }

    public fun is_storage_initialized(arg0: &Round, arg1: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::ResolverCap) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::cap_resolver_id(arg1))
    }

    public(friend) fun new_round_manager(arg0: 0x1::option::Option<u64>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : RoundManager {
        let v0 = 0x1::option::destroy_with_default<u64>(arg0, 172800000);
        assert!(v0 >= 86400000, 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = RoundManager{
            id                   : 0x2::object::new(arg2),
            round_duration_ms    : v0,
            genesis_timestamp_ms : v1,
            rounds               : 0x2::object_table::new<u64, Round>(arg2),
        };
        let v3 = RoundStarted{
            round_no      : 0,
            end_time_ms   : v1 + v0,
            start_time_ms : v1,
        };
        0x2::event::emit<RoundStarted>(v3);
        v2
    }

    public fun next_round(arg0: &mut RoundManager, arg1: &0x2::clock::Clock) : &Round {
        let v0 = current_round_no(arg0, arg1) + 1;
        ensure_round_exists(arg0, v0)
    }

    public fun round_boundaries(arg0: &RoundManager, arg1: u64) : (u64, u64) {
        let v0 = arg0.genesis_timestamp_ms + arg1 * arg0.round_duration_ms;
        (v0, v0 + arg0.round_duration_ms)
    }

    public fun round_duration_ms(arg0: &RoundManager) : u64 {
        arg0.round_duration_ms
    }

    public fun round_no(arg0: &Round) : u64 {
        arg0.round_no
    }

    public fun round_no_for_timestamp(arg0: &RoundManager, arg1: u64) : u64 {
        assert!(arg1 >= arg0.genesis_timestamp_ms, 3);
        (arg1 - arg0.genesis_timestamp_ms) / arg0.round_duration_ms
    }

    public fun start_time_ms(arg0: &Round) : u64 {
        arg0.start_time_ms
    }

    public fun storage(arg0: &Round, arg1: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::ResolverCap) : &0x2::bag::Bag {
        assert!(is_storage_initialized(arg0, arg1), 2);
        &0x2::dynamic_field::borrow<0x2::object::ID, Storage>(&arg0.id, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::cap_resolver_id(arg1)).inner
    }

    public fun storage_mut(arg0: &mut Round, arg1: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::ResolverCap) : &mut 0x2::bag::Bag {
        assert!(is_storage_initialized(arg0, arg1), 2);
        &mut 0x2::dynamic_field::borrow_mut<0x2::object::ID, Storage>(&mut arg0.id, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::cap_resolver_id(arg1)).inner
    }

    // decompiled from Move bytecode v6
}

