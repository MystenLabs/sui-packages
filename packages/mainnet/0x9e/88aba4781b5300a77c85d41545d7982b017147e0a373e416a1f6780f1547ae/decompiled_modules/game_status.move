module 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::game_status {
    struct NewEndTime has copy, drop {
        ms: u64,
    }

    struct GameStatus has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u8>,
        start_time: u64,
        end_time: u64,
    }

    struct Starter has key {
        id: 0x2::object::UID,
    }

    public fun add_version(arg0: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::listing::ListingCap, arg1: &mut GameStatus, arg2: u8) {
        assert_valid_package_version(arg1);
        0x2::vec_set::insert<u8>(&mut arg1.version_set, arg2);
    }

    public fun assert_game_is_ended(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) <= arg0.end_time) {
            err_game_is_not_ended();
        };
    }

    public fun assert_game_is_not_ended(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) > arg0.end_time) {
            err_game_is_ended();
        };
    }

    public fun assert_game_is_started(arg0: &GameStatus, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.start_time) {
            err_game_is_not_started();
        };
    }

    public fun assert_valid_package_version(arg0: &GameStatus) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u8>(&arg0.version_set, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun end_time(arg0: &GameStatus) : u64 {
        arg0.end_time
    }

    fun err_game_is_ended() {
        abort 2
    }

    fun err_game_is_not_ended() {
        abort 1
    }

    fun err_game_is_not_started() {
        abort 0
    }

    fun err_invalid_package_version() {
        abort 3
    }

    public fun extend_end_time(arg0: &mut GameStatus, arg1: u64) {
        arg0.end_time = arg1;
    }

    public(friend) fun increase_end_time(arg0: &mut GameStatus, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.end_time + 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::time_increment();
        let v2 = v1;
        let v3 = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::end_time_hard_cap();
        if (v1 > v0 + v3) {
            v2 = v0 + v3;
        };
        if (arg0.end_time < v2) {
            let v4 = NewEndTime{ms: v2};
            0x2::event::emit<NewEndTime>(v4);
            arg0.end_time = v2;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Starter{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Starter>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameStatus{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u8>(package_version()),
            start_time  : 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math::max_u64(),
            end_time    : 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math::max_u64(),
        };
        0x2::transfer::share_object<GameStatus>(v1);
    }

    public fun package_version() : u8 {
        1
    }

    public fun raffle_epoch(arg0: &GameStatus, arg1: &0x2::clock::Clock) : u64 {
        let v0 = start_time(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 >= v0) {
            (v1 - v0) / 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::raffle_period()
        } else {
            0
        }
    }

    public fun remove_version(arg0: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::listing::ListingCap, arg1: &mut GameStatus, arg2: u8) {
        assert_valid_package_version(arg1);
        0x2::vec_set::remove<u8>(&mut arg1.version_set, &arg2);
    }

    public fun start(arg0: &mut GameStatus, arg1: Starter, arg2: u64) {
        let Starter { id: v0 } = arg1;
        0x2::object::delete(v0);
        arg0.start_time = arg2;
        arg0.end_time = arg2 + 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::initial_countdown();
    }

    public fun start_time(arg0: &GameStatus) : u64 {
        arg0.start_time
    }

    // decompiled from Move bytecode v6
}

