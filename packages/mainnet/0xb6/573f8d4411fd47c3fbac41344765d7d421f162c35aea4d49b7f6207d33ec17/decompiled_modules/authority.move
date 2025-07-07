module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority {
    struct AUTHORITY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
        cap: 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::GameCap,
        event_cap: 0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap,
        map_cap: 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap,
        crimes_cap: 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap,
        swap_cap: 0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::SwapCap,
        dvd_cap: 0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::dvd_authority::DVDCap,
    }

    struct Status has key {
        id: 0x2::object::UID,
        crimes_pause: bool,
        onboarding_pause: bool,
        battle_pause: bool,
    }

    struct GameMasterCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameOperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    entry fun add_game_cap(arg0: &GameMasterCap, arg1: 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::GameCap, arg2: 0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg3: 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap, arg4: 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap, arg5: 0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::SwapCap, arg6: 0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::dvd_authority::DVDCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CapWrapper{
            id         : 0x2::object::new(arg7),
            cap        : arg1,
            event_cap  : arg2,
            map_cap    : arg3,
            crimes_cap : arg4,
            swap_cap   : arg5,
            dvd_cap    : arg6,
        };
        0x2::transfer::share_object<CapWrapper>(v0);
    }

    public(friend) fun borrow_crimes_cap(arg0: &CapWrapper) : &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap {
        &arg0.crimes_cap
    }

    public(friend) fun borrow_dvd_cap(arg0: &CapWrapper) : &0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::dvd_authority::DVDCap {
        &arg0.dvd_cap
    }

    public(friend) fun borrow_event_cap(arg0: &CapWrapper) : &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap {
        &arg0.event_cap
    }

    public(friend) fun borrow_game_cap(arg0: &CapWrapper) : &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::GameCap {
        &arg0.cap
    }

    public(friend) fun borrow_map_cap(arg0: &CapWrapper) : &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap {
        &arg0.map_cap
    }

    public(friend) fun borrow_swap_cap(arg0: &CapWrapper) : &0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::SwapCap {
        &arg0.swap_cap
    }

    fun init(arg0: AUTHORITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameMasterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GameMasterCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AUTHORITY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = OperatorCapsBag{
            id   : 0x2::object::new(arg1),
            caps : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        let v2 = Status{
            id               : 0x2::object::new(arg1),
            crimes_pause     : true,
            onboarding_pause : true,
            battle_pause     : true,
        };
        0x2::transfer::share_object<Status>(v2);
        0x2::transfer::share_object<OperatorCapsBag>(v1);
    }

    public(friend) fun is_operator(arg0: &GameOperatorCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 1);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 2);
    }

    public fun issue_operator_cap(arg0: &CapWrapper, arg1: &GameMasterCap, arg2: &mut OperatorCapsBag, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = GameOperatorCap{id: 0x2::object::new(arg5)};
        let v1 = 0x2::object::id<GameOperatorCap>(&v0);
        0x2::transfer::public_transfer<GameOperatorCap>(v0, arg3);
        0x2::table::add<0x2::object::ID, bool>(&mut arg2.caps, v1, true);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_operator_cap_issued_event(borrow_event_cap(arg0), v1, 0x2::clock::timestamp_ms(arg4));
    }

    public fun revoke_operator_cap(arg0: &CapWrapper, arg1: &GameMasterCap, arg2: &mut OperatorCapsBag, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.caps, arg4), 0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg2.caps, arg4) = false;
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_operator_cap_revoked_event(borrow_event_cap(arg0), arg4, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_status(arg0: &GameMasterCap, arg1: &mut Status, arg2: bool, arg3: bool, arg4: bool) {
        arg1.crimes_pause = arg2;
        arg1.onboarding_pause = arg3;
        arg1.battle_pause = arg4;
    }

    public(friend) fun validate_battle_status(arg0: &Status) {
        assert!(!arg0.battle_pause, 3);
    }

    public(friend) fun validate_crime_status(arg0: &Status) {
        assert!(!arg0.crimes_pause, 5);
    }

    public(friend) fun validate_onboarding_status(arg0: &Status) {
        assert!(!arg0.onboarding_pause, 4);
    }

    // decompiled from Move bytecode v6
}

