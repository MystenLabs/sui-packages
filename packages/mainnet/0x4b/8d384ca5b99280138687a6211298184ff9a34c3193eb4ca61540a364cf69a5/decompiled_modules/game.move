module 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::game {
    struct GameCap has store, key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
    }

    struct TrophyDef has copy, drop, store {
        key: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        tier: u8,
        points: u64,
        hidden: bool,
        in_platinum_set: bool,
        unlocked: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        version: u64,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        platform: 0x1::string::String,
        image_url: 0x1::string::String,
        cap: 0x2::object::ID,
        attested: bool,
        paused: bool,
        defs: 0x2::table::Table<u64, TrophyDef>,
        keys: 0x2::table::Table<0x1::string::String, u64>,
        platinum: 0x1::option::Option<u64>,
        platinum_set: vector<u64>,
        unlocks: u64,
        players: u64,
        creator: address,
        issuer: vector<u8>,
    }

    struct ClaimKey has copy, drop, store {
        trophy_id: u64,
        player: address,
    }

    struct NonceKey has copy, drop, store {
        player: address,
        nonce: u64,
    }

    struct PlayerKey has copy, drop, store {
        player: address,
    }

    struct Progress has copy, drop, store {
        earned: u64,
        points: u64,
        set_earned: u64,
        set_self_reported: bool,
    }

    public fun platinum_set(arg0: &Game) : vector<u64> {
        arg0.platinum_set
    }

    public fun add_trophy(arg0: &GameCap, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: bool) : u64 {
        assert_cap(arg1, arg0);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::assert_tier(arg6);
        assert!(arg6 != 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::platinum(), 206);
        define(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun assert_cap(arg0: &Game, arg1: &GameCap) {
        assert!(arg1.game == 0x2::object::id<Game>(arg0) && 0x2::object::id<GameCap>(arg1) == arg0.cap, 203);
    }

    public fun attestation_message(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = b"RARE_TROPHY_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        v0
    }

    public fun attested(arg0: &Game) : bool {
        arg0.attested
    }

    public fun cap_game(arg0: &GameCap) : 0x2::object::ID {
        arg0.game
    }

    fun check_text(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = if (0x1::string::length(&arg0) <= 128) {
            if (0x1::string::length(&arg1) <= 512) {
                0x1::string::length(&arg2) <= 512
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 214);
    }

    public fun claimed(arg0: &Game, arg1: u64, arg2: address) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ClaimKey{
            trophy_id : arg1,
            player    : arg2,
        };
        if (0x2::dynamic_field::exists<ClaimKey>(&arg0.id, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ClaimKey, 0x2::object::ID>(&arg0.id, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun create_game(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap, arg1: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : GameCap {
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::assert_current(arg1);
        assert!(0x1::string::length(&arg2) > 0, 214);
        new_game(arg1, arg2, arg3, arg4, arg5, arg6, false, arg7)
    }

    public fun create_studio_game(arg0: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : GameCap {
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::assert_live(arg0);
        new_game(arg0, arg1, arg2, 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::studio_platform(&arg1), arg3, false, true, arg4)
    }

    public fun creator(arg0: &Game) : address {
        arg0.creator
    }

    public fun def_hidden(arg0: &TrophyDef) : bool {
        arg0.hidden
    }

    public fun def_in_platinum_set(arg0: &TrophyDef) : bool {
        arg0.in_platinum_set
    }

    public fun def_key(arg0: &TrophyDef) : 0x1::string::String {
        arg0.key
    }

    public fun def_name(arg0: &TrophyDef) : 0x1::string::String {
        arg0.name
    }

    public fun def_points(arg0: &TrophyDef) : u64 {
        arg0.points
    }

    public fun def_tier(arg0: &TrophyDef) : u8 {
        arg0.tier
    }

    public fun def_unlocked(arg0: &TrophyDef) : u64 {
        arg0.unlocked
    }

    fun define(arg0: &mut Game, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool) : u64 {
        assert!(0x1::string::length(&arg1) > 0 && 0x1::string::length(&arg1) <= 128, 214);
        check_text(arg2, arg3, arg4);
        assert!(!0x2::table::contains<0x1::string::String, u64>(&arg0.keys, arg1), 215);
        let v0 = 0x2::table::length<u64, TrophyDef>(&arg0.defs);
        let v1 = 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::points_for(arg5);
        let v2 = TrophyDef{
            key             : arg1,
            name            : arg2,
            description     : arg3,
            image_url       : arg4,
            tier            : arg5,
            points          : v1,
            hidden          : arg6,
            in_platinum_set : false,
            unlocked        : 0,
        };
        0x2::table::add<u64, TrophyDef>(&mut arg0.defs, v0, v2);
        0x2::table::add<0x1::string::String, u64>(&mut arg0.keys, arg1, v0);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::trophy_defined(0x2::object::id<Game>(arg0), v0, arg1, arg2, arg5, v1, arg6);
        v0
    }

    fun emit_updated(arg0: &Game) {
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::game_updated(0x2::object::id<Game>(arg0), arg0.name, arg0.image_url, arg0.attested, arg0.paused);
    }

    public fun image_url(arg0: &Game) : 0x1::string::String {
        arg0.image_url
    }

    fun issue(arg0: &mut Game, arg1: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::Profile, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::player(arg1);
        let v1 = ClaimKey{
            trophy_id : arg2,
            player    : v0,
        };
        assert!(!0x2::dynamic_field::exists<ClaimKey>(&arg0.id, v1), 205);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x2::object::id<Game>(arg0);
        let v4 = 0x2::table::borrow_mut<u64, TrophyDef>(&mut arg0.defs, arg2);
        v4.unlocked = v4.unlocked + 1;
        let v5 = *0x2::table::borrow<u64, TrophyDef>(&arg0.defs, arg2);
        let v6 = 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::new(v3, arg0.name, arg2, v5.name, v5.description, v5.image_url, v5.tier, arg3, v5.unlocked, v2, arg5);
        let v7 = 0x2::object::id<0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::Trophy>(&v6);
        0x2::dynamic_field::add<ClaimKey, 0x2::object::ID>(&mut arg0.id, v1, v7);
        let v8 = PlayerKey{player: v0};
        let v9 = !0x2::dynamic_field::exists<PlayerKey>(&arg0.id, v8);
        if (v9) {
            let v10 = Progress{
                earned            : 0,
                points            : 0,
                set_earned        : 0,
                set_self_reported : false,
            };
            0x2::dynamic_field::add<PlayerKey, Progress>(&mut arg0.id, v8, v10);
            arg0.players = arg0.players + 1;
        };
        let v11 = 0x2::dynamic_field::borrow_mut<PlayerKey, Progress>(&mut arg0.id, v8);
        v11.earned = v11.earned + 1;
        v11.points = v11.points + v5.points;
        arg0.unlocks = arg0.unlocks + 1;
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::record(arg1, v5.tier, v5.points, arg3, v9, v2);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::trophy_unlocked(v7, v3, arg2, v0, v5.tier, v5.points, arg3, v5.unlocked, v2);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::give(v6, v0);
        v7
    }

    public fun issuer(arg0: &Game) : vector<u8> {
        arg0.issuer
    }

    public fun migrate(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap, arg1: &mut Game) {
        assert!(arg1.version < 1, 216);
        arg1.version = 1;
    }

    public fun mint(arg0: &GameCap, arg1: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg2: &mut Game, arg3: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::Profile, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_cap(arg2, arg0);
        unlock(arg2, arg1, arg3, arg4, 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_studio(), arg5, arg6)
    }

    public fun mint_attested(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg1: &mut Game, arg2: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::Profile, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = arg1.issuer;
        let v1 = 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::issuer_key(arg0);
        assert!(!0x1::vector::is_empty<u8>(&v0) || arg1.attested, 207);
        assert!(!0x1::vector::is_empty<u8>(&v0) || !0x1::vector::is_empty<u8>(&v1), 208);
        assert!(0x2::clock::timestamp_ms(arg7) < arg5, 209);
        let v2 = 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::player(arg2);
        let v3 = attestation_message(0x2::object::id<0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry>(arg0), v2, 0x2::object::id<Game>(arg1), arg3, arg4, arg5);
        let v4 = if (!0x1::vector::is_empty<u8>(&v0)) {
            if (v0 != v1) {
                0x2::ed25519::ed25519_verify(&arg6, &v0, &v3)
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (v4) {
            0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_studio()
        } else {
            let v6 = if (arg1.attested) {
                if (!0x1::vector::is_empty<u8>(&v1)) {
                    0x2::ed25519::ed25519_verify(&arg6, &v1, &v3)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 210);
            0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_attested()
        };
        let v7 = NonceKey{
            player : v2,
            nonce  : arg4,
        };
        assert!(!0x2::dynamic_field::exists<NonceKey>(&arg1.id, v7), 211);
        0x2::dynamic_field::add<NonceKey, bool>(&mut arg1.id, v7, true);
        unlock(arg1, arg0, arg2, arg3, v5, arg7, arg8)
    }

    public fun name(arg0: &Game) : 0x1::string::String {
        arg0.name
    }

    fun new_game(arg0: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : GameCap {
        assert!(0x1::string::length(&arg1) <= 96, 214);
        let v0 = if (0x1::string::length(&arg2) <= 128) {
            if (0x1::string::length(&arg3) <= 32) {
                0x1::string::length(&arg4) <= 512
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 214);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = GameCap{
            id   : 0x2::object::new(arg7),
            game : v2,
        };
        let v4 = 0x2::object::id<GameCap>(&v3);
        let v5 = 0x2::tx_context::sender(arg7);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::add_game(arg0, arg1, v2);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::game_created(v2, arg1, arg2, arg3, v4, arg5, arg6, v5);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::game_cap_issued(v2, v4);
        let v6 = Game{
            id           : v1,
            version      : 1,
            slug         : arg1,
            name         : arg2,
            platform     : arg3,
            image_url    : arg4,
            cap          : v4,
            attested     : arg5,
            paused       : false,
            defs         : 0x2::table::new<u64, TrophyDef>(arg7),
            keys         : 0x2::table::new<0x1::string::String, u64>(arg7),
            platinum     : 0x1::option::none<u64>(),
            platinum_set : vector[],
            unlocks      : 0,
            players      : 0,
            creator      : v5,
            issuer       : b"",
        };
        0x2::transfer::share_object<Game>(v6);
        v3
    }

    public fun nonce_used(arg0: &Game, arg1: address, arg2: u64) : bool {
        let v0 = NonceKey{
            player : arg1,
            nonce  : arg2,
        };
        0x2::dynamic_field::exists<NonceKey>(&arg0.id, v0)
    }

    public fun paused(arg0: &Game) : bool {
        arg0.paused
    }

    public fun platform(arg0: &Game) : 0x1::string::String {
        arg0.platform
    }

    public fun platinum(arg0: &Game) : 0x1::option::Option<u64> {
        arg0.platinum
    }

    public fun players(arg0: &Game) : u64 {
        arg0.players
    }

    public fun progress(arg0: &Game, arg1: address) : (u64, u64, u64) {
        let v0 = PlayerKey{player: arg1};
        if (!0x2::dynamic_field::exists<PlayerKey>(&arg0.id, v0)) {
            return (0, 0, 0)
        };
        let v1 = 0x2::dynamic_field::borrow<PlayerKey, Progress>(&arg0.id, v0);
        (v1.earned, v1.points, v1.set_earned)
    }

    public fun reissue_cap(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap, arg1: &mut Game, arg2: &mut 0x2::tx_context::TxContext) : GameCap {
        let v0 = GameCap{
            id   : 0x2::object::new(arg2),
            game : 0x2::object::id<Game>(arg1),
        };
        arg1.cap = 0x2::object::id<GameCap>(&v0);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::game_cap_issued(0x2::object::id<Game>(arg1), arg1.cap);
        v0
    }

    public fun set_attested(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap, arg1: &mut Game, arg2: bool) {
        arg1.attested = arg2;
        emit_updated(arg1);
    }

    public fun set_info(arg0: &GameCap, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert_cap(arg1, arg0);
        assert!(0x1::string::length(&arg2) <= 128 && 0x1::string::length(&arg3) <= 512, 214);
        arg1.name = arg2;
        arg1.image_url = arg3;
        emit_updated(arg1);
    }

    public fun set_issuer(arg0: &GameCap, arg1: &mut Game, arg2: vector<u8>) {
        assert_cap(arg1, arg0);
        assert!(0x1::vector::is_empty<u8>(&arg2) || 0x1::vector::length<u8>(&arg2) == 32, 217);
        arg1.issuer = arg2;
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::game_issuer_set(0x2::object::id<Game>(arg1), arg2);
    }

    public fun set_paused(arg0: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::AdminCap, arg1: &mut Game, arg2: bool) {
        arg1.paused = arg2;
        emit_updated(arg1);
    }

    public fun set_platinum(arg0: &GameCap, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u64>) : u64 {
        assert_cap(arg1, arg0);
        assert!(arg1.unlocks == 0, 212);
        assert!(!0x1::vector::is_empty<u64>(&arg6) && 0x1::vector::length<u64>(&arg6) <= 2048, 213);
        let v0 = arg1.platinum_set;
        0x1::vector::reverse<u64>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            0x2::table::borrow_mut<u64, TrophyDef>(&mut arg1.defs, 0x1::vector::pop_back<u64>(&mut v0)).in_platinum_set = false;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(v0);
        let v2 = &arg6;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(v2)) {
            let v4 = *0x1::vector::borrow<u64>(v2, v3);
            assert!(0x2::table::contains<u64, TrophyDef>(&arg1.defs, v4), 213);
            let v5 = 0x2::table::borrow_mut<u64, TrophyDef>(&mut arg1.defs, v4);
            assert!(v5.tier != 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::platinum() && !v5.in_platinum_set, 213);
            v5.in_platinum_set = true;
            v3 = v3 + 1;
        };
        let v6 = if (0x1::option::is_some<u64>(&arg1.platinum)) {
            let v7 = *0x1::option::borrow<u64>(&arg1.platinum);
            check_text(arg3, arg4, arg5);
            let v8 = 0x2::table::borrow<u64, TrophyDef>(&arg1.defs, v7).key;
            if (v8 != arg2) {
                assert!(!0x2::table::contains<0x1::string::String, u64>(&arg1.keys, arg2), 215);
                0x2::table::remove<0x1::string::String, u64>(&mut arg1.keys, v8);
                0x2::table::add<0x1::string::String, u64>(&mut arg1.keys, arg2, v7);
            };
            let v9 = 0x2::table::borrow_mut<u64, TrophyDef>(&mut arg1.defs, v7);
            v9.key = arg2;
            v9.name = arg3;
            v9.description = arg4;
            v9.image_url = arg5;
            let v10 = *0x2::table::borrow<u64, TrophyDef>(&arg1.defs, v7);
            0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::trophy_defined(0x2::object::id<Game>(arg1), v7, v10.key, v10.name, v10.tier, v10.points, v10.hidden);
            v7
        } else {
            let v11 = define(arg1, arg2, arg3, arg4, arg5, 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::platinum(), false);
            arg1.platinum = 0x1::option::some<u64>(v11);
            v11
        };
        arg1.platinum_set = arg6;
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::platinum_set(0x2::object::id<Game>(arg1), v6, arg6);
        v6
    }

    public fun slug(arg0: &Game) : 0x1::string::String {
        arg0.slug
    }

    public fun trophy_by_key(arg0: &Game, arg1: 0x1::string::String) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.keys, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x1::string::String, u64>(&arg0.keys, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun trophy_count(arg0: &Game) : u64 {
        0x2::table::length<u64, TrophyDef>(&arg0.defs)
    }

    public fun trophy_def(arg0: &Game, arg1: u64) : TrophyDef {
        *0x2::table::borrow<u64, TrophyDef>(&arg0.defs, arg1)
    }

    fun unlock(arg0: &mut Game, arg1: &0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg2: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::Profile, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::assert_live(arg1);
        assert!(arg0.version == 1, 201);
        assert!(!arg0.paused, 202);
        assert!(0x2::table::contains<u64, TrophyDef>(&arg0.defs, arg3), 204);
        assert!(0x2::table::borrow<u64, TrophyDef>(&arg0.defs, arg3).tier != 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::platinum(), 206);
        let v0 = issue(arg0, arg2, arg3, arg4, arg5, arg6);
        if (0x2::table::borrow<u64, TrophyDef>(&arg0.defs, arg3).in_platinum_set) {
            let v1 = PlayerKey{player: 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile::player(arg2)};
            let v2 = 0x2::dynamic_field::borrow_mut<PlayerKey, Progress>(&mut arg0.id, v1);
            v2.set_earned = v2.set_earned + 1;
            if (arg4 == 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_attested()) {
                v2.set_self_reported = true;
            };
            let v3 = if (v2.set_self_reported) {
                0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_attested()
            } else {
                0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_studio()
            };
            if (v2.set_earned == 0x1::vector::length<u64>(&arg0.platinum_set)) {
                let v4 = *0x1::option::borrow<u64>(&arg0.platinum);
                issue(arg0, arg2, v4, v3, arg5, arg6);
            };
        };
        v0
    }

    public fun unlocks(arg0: &Game) : u64 {
        arg0.unlocks
    }

    public fun update_trophy(arg0: &GameCap, arg1: &mut Game, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool) {
        assert_cap(arg1, arg0);
        assert!(0x2::table::contains<u64, TrophyDef>(&arg1.defs, arg2), 204);
        check_text(arg3, arg4, arg5);
        let v0 = 0x2::table::borrow_mut<u64, TrophyDef>(&mut arg1.defs, arg2);
        v0.name = arg3;
        v0.description = arg4;
        v0.image_url = arg5;
        v0.hidden = arg6;
        let v1 = *0x2::table::borrow<u64, TrophyDef>(&arg1.defs, arg2);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::trophy_defined(0x2::object::id<Game>(arg1), arg2, v1.key, v1.name, v1.tier, v1.points, v1.hidden);
    }

    public fun valid_cap(arg0: &Game) : 0x2::object::ID {
        arg0.cap
    }

    // decompiled from Move bytecode v7
}

