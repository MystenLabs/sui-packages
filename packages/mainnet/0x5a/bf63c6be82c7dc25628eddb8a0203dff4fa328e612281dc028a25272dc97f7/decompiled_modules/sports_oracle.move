module 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_oracle {
    struct SportsRegistry has store, key {
        id: 0x2::object::UID,
        game_ids: vector<0x2::object::ID>,
    }

    struct SportsGame has store, key {
        id: 0x2::object::UID,
        provider: vector<u8>,
        league: vector<u8>,
        league_id: u64,
        external_game_id: vector<u8>,
        home_team: vector<u8>,
        away_team: vector<u8>,
        home_logo_url: vector<u8>,
        away_logo_url: vector<u8>,
        start_time_ms: u64,
        lock_time_ms: u64,
        status: u8,
        home_score: u64,
        away_score: u64,
        period: vector<u8>,
        clock_str: vector<u8>,
        linked_market_id: 0x2::object::ID,
        has_linked_market: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
        finalized_at_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct GameCreated has copy, drop {
        game_id: 0x2::object::ID,
        provider: vector<u8>,
        league: vector<u8>,
        league_id: u64,
        external_game_id: vector<u8>,
        home_team: vector<u8>,
        away_team: vector<u8>,
        start_time_ms: u64,
        lock_time_ms: u64,
        timestamp_ms: u64,
    }

    struct GameStateUpdated has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
        home_score: u64,
        away_score: u64,
        period: vector<u8>,
        clock_str: vector<u8>,
        timestamp_ms: u64,
    }

    struct MarketLinked has copy, drop {
        game_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct GameFinalizedMarketResolved has copy, drop {
        game_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        winner: u8,
        timestamp_ms: u64,
    }

    struct GameCancelledMarketVoided has copy, drop {
        game_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp_ms: u64,
    }

    public entry fun cancel_and_void(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &mut SportsGame, arg2: &mut 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::SportsMarket, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_linked_market, 6004);
        assert!(0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::market_id(arg2) == arg1.linked_market_id, 6005);
        assert!(arg1.status != 3, 6001);
        assert!(arg1.status != 4, 6009);
        let v0 = now_ms(arg4);
        arg1.status = 4;
        arg1.updated_at_ms = v0;
        0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::cancel_market(arg0, arg2, arg3, arg4, arg5);
        let v1 = GameCancelledMarketVoided{
            game_id      : 0x2::object::uid_to_inner(&arg1.id),
            market_id    : 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::market_id(arg2),
            reason       : copy_bytes(&arg3),
            timestamp_ms : v0,
        };
        0x2::event::emit<GameCancelledMarketVoided>(v1);
    }

    fun copy_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_game(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &mut SportsRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = now_ms(arg12);
        assert!(arg10 > 0, 6002);
        assert!(arg11 > 0, 6002);
        assert!(arg11 <= arg10, 6002);
        assert!(arg11 > v0, 6002);
        let v1 = 0x2::object::new(arg13);
        0x2::object::delete(v1);
        let v2 = SportsGame{
            id                : 0x2::object::new(arg13),
            provider          : arg2,
            league            : arg3,
            league_id         : arg4,
            external_game_id  : arg5,
            home_team         : arg6,
            away_team         : arg7,
            home_logo_url     : arg8,
            away_logo_url     : arg9,
            start_time_ms     : arg10,
            lock_time_ms      : arg11,
            status            : 1,
            home_score        : 0,
            away_score        : 0,
            period            : b"PRE",
            clock_str         : b"",
            linked_market_id  : 0x2::object::uid_to_inner(&v1),
            has_linked_market : false,
            created_at_ms     : v0,
            updated_at_ms     : v0,
            finalized_at_ms   : 0,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.game_ids, v3);
        let v4 = GameCreated{
            game_id          : v3,
            provider         : copy_bytes(&arg2),
            league           : copy_bytes(&arg3),
            league_id        : arg4,
            external_game_id : copy_bytes(&arg5),
            home_team        : copy_bytes(&arg6),
            away_team        : copy_bytes(&arg7),
            start_time_ms    : arg10,
            lock_time_ms     : arg11,
            timestamp_ms     : v0,
        };
        0x2::event::emit<GameCreated>(v4);
        0x2::transfer::share_object<SportsGame>(v2);
    }

    public entry fun create_registry(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SportsRegistry{
            id       : 0x2::object::new(arg2),
            game_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = RegistryCreated{
            registry_id  : 0x2::object::uid_to_inner(&v0.id),
            timestamp_ms : now_ms(arg1),
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<SportsRegistry>(v0);
    }

    public entry fun finalize_and_resolve(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &mut SportsGame, arg2: &mut 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::SportsMarket, arg3: &mut 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::Treasury, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_linked_market, 6004);
        assert!(0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::market_id(arg2) == arg1.linked_market_id, 6005);
        assert!(arg1.status != 3, 6001);
        assert!(arg1.status != 4, 6009);
        assert!(arg4 == 1 || arg4 == 2, 6007);
        let v0 = now_ms(arg5);
        assert!(v0 >= arg1.start_time_ms, 6002);
        arg1.status = 3;
        arg1.period = b"FINAL";
        arg1.clock_str = b"00:00";
        arg1.updated_at_ms = v0;
        arg1.finalized_at_ms = v0;
        let v1 = if (arg4 == 1) {
            1
        } else {
            2
        };
        0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::resolve_market(arg0, arg2, arg3, v1, arg5, arg6);
        let v2 = GameFinalizedMarketResolved{
            game_id      : 0x2::object::uid_to_inner(&arg1.id),
            market_id    : 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::market_id(arg2),
            winner       : arg4,
            timestamp_ms : v0,
        };
        0x2::event::emit<GameFinalizedMarketResolved>(v2);
    }

    public fun game_league_id(arg0: &SportsGame) : u64 {
        arg0.league_id
    }

    public fun game_market_link(arg0: &SportsGame) : (bool, 0x2::object::ID) {
        (arg0.has_linked_market, arg0.linked_market_id)
    }

    public fun game_scores(arg0: &SportsGame) : (u64, u64) {
        (arg0.home_score, arg0.away_score)
    }

    public fun game_status(arg0: &SportsGame) : u8 {
        arg0.status
    }

    public fun game_times(arg0: &SportsGame) : (u64, u64) {
        (arg0.start_time_ms, arg0.lock_time_ms)
    }

    public fun is_cancelled(arg0: &SportsGame) : bool {
        arg0.status == 4
    }

    public fun is_final(arg0: &SportsGame) : bool {
        arg0.status == 3
    }

    public fun is_live(arg0: &SportsGame) : bool {
        arg0.status == 2
    }

    fun is_valid_status(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    public entry fun link_market(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &mut SportsGame, arg2: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::SportsMarket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.has_linked_market, 6003);
        let v0 = 0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::market_id(arg2);
        arg1.linked_market_id = v0;
        arg1.has_linked_market = true;
        arg1.updated_at_ms = now_ms(arg3);
        let v1 = MarketLinked{
            game_id      : 0x2::object::uid_to_inner(&arg1.id),
            market_id    : v0,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<MarketLinked>(v1);
    }

    fun now_ms(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun registry_game_ids(arg0: &SportsRegistry) : &vector<0x2::object::ID> {
        &arg0.game_ids
    }

    public entry fun update_game_state(arg0: &0x5abf63c6be82c7dc25628eddb8a0203dff4fa328e612281dc028a25272dc97f7::sports_market::AdminCap, arg1: &mut SportsGame, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status != 3, 6001);
        assert!(arg1.status != 4, 6009);
        assert!(is_valid_status(arg2), 6006);
        let v0 = now_ms(arg7);
        arg1.status = arg2;
        arg1.home_score = arg3;
        arg1.away_score = arg4;
        arg1.period = arg5;
        arg1.clock_str = arg6;
        arg1.updated_at_ms = v0;
        let v1 = GameStateUpdated{
            game_id      : 0x2::object::uid_to_inner(&arg1.id),
            status       : arg2,
            home_score   : arg3,
            away_score   : arg4,
            period       : copy_bytes(&arg5),
            clock_str    : copy_bytes(&arg6),
            timestamp_ms : v0,
        };
        0x2::event::emit<GameStateUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

