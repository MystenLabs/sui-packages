module 0x8150644405377539c192ef601ea64640556edb73284f90e23966c82b5582367a::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        series: 0x2::table::Table<SeriesKey, SeriesRecord>,
        games: 0x2::table::Table<vector<u8>, GameConfig>,
        reveal_sla_ms: u64,
        total_commits: u64,
        total_reveals: u64,
        total_batches: u64,
    }

    struct SeriesKey has copy, drop, store {
        player: address,
        game_code: vector<u8>,
        series_id: u64,
    }

    struct SeriesRecord has drop, store {
        server_seed_hash: vector<u8>,
        committed_at_ms: u64,
        revealed_seed: vector<u8>,
        revealed_at_ms: u64,
    }

    struct GameConfig has drop, store {
        code: vector<u8>,
        name: vector<u8>,
        active: bool,
        registered_at_ms: u64,
    }

    struct Initialized has copy, drop {
        registry_id: address,
        admin_cap_id: address,
        reveal_sla_ms: u64,
    }

    struct GameRegistered has copy, drop {
        code: vector<u8>,
        name: vector<u8>,
        registered_at_ms: u64,
    }

    struct GameSetActive has copy, drop {
        code: vector<u8>,
        active: bool,
    }

    struct RevealSlaUpdated has copy, drop {
        old_sla_ms: u64,
        new_sla_ms: u64,
    }

    struct SeedCommitted has copy, drop {
        player: address,
        game_code: vector<u8>,
        series_id: u64,
        server_seed_hash: vector<u8>,
        committed_at_ms: u64,
    }

    struct SeedRevealed has copy, drop {
        player: address,
        game_code: vector<u8>,
        series_id: u64,
        revealed_seed: vector<u8>,
        revealed_at_ms: u64,
        committed_at_ms: u64,
    }

    struct SeedBatchCommitted has copy, drop {
        merkle_root: vector<u8>,
        leaf_count: u64,
        committed_at_ms: u64,
    }

    struct RevealStale has copy, drop {
        player: address,
        game_code: vector<u8>,
        series_id: u64,
        committed_at_ms: u64,
        age_ms: u64,
        sla_ms: u64,
    }

    fun assert_code(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 32, 11);
    }

    fun bytes_eq(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun commit_seed(arg0: &mut Registry, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert_code(&arg2);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 9);
        assert!(0x2::table::contains<vector<u8>, GameConfig>(&arg0.games, copy_bytes(&arg2)), 2);
        assert!(0x2::table::borrow<vector<u8>, GameConfig>(&arg0.games, copy_bytes(&arg2)).active, 4);
        let v0 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        let v1 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        assert!(!0x2::table::contains<SeriesKey, SeriesRecord>(&arg0.series, v1), 5);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = SeriesRecord{
            server_seed_hash : copy_bytes(&arg4),
            committed_at_ms  : v2,
            revealed_seed    : 0x1::vector::empty<u8>(),
            revealed_at_ms   : 0,
        };
        0x2::table::add<SeriesKey, SeriesRecord>(&mut arg0.series, v0, v3);
        arg0.total_commits = arg0.total_commits + 1;
        let v4 = SeedCommitted{
            player           : arg1,
            game_code        : arg2,
            series_id        : arg3,
            server_seed_hash : arg4,
            committed_at_ms  : v2,
        };
        0x2::event::emit<SeedCommitted>(v4);
    }

    public fun commit_seed_batch(arg0: &mut Registry, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 12);
        assert!(arg2 > 0, 12);
        arg0.total_batches = arg0.total_batches + 1;
        let v0 = SeedBatchCommitted{
            merkle_root     : arg1,
            leaf_count      : arg2,
            committed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SeedBatchCommitted>(v0);
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

    public fun game_active(arg0: &Registry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, GameConfig>(&arg0.games, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, GameConfig>(&arg0.games, arg1).active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Registry{
            id            : 0x2::object::new(arg0),
            series        : 0x2::table::new<SeriesKey, SeriesRecord>(arg0),
            games         : 0x2::table::new<vector<u8>, GameConfig>(arg0),
            reveal_sla_ms : 604800000,
            total_commits : 0,
            total_reveals : 0,
            total_batches : 0,
        };
        let v2 = Initialized{
            registry_id   : 0x2::object::id_address<Registry>(&v1),
            admin_cap_id  : 0x2::object::id_address<AdminCap>(&v0),
            reveal_sla_ms : 604800000,
        };
        0x2::event::emit<Initialized>(v2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun mark_stale(arg0: &Registry, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        assert!(0x2::table::contains<SeriesKey, SeriesRecord>(&arg0.series, v0), 6);
        let v1 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        let v2 = 0x2::table::borrow<SeriesKey, SeriesRecord>(&arg0.series, v1);
        assert!(0x1::vector::length<u8>(&v2.revealed_seed) == 0, 7);
        let v3 = v2.committed_at_ms;
        let v4 = arg0.reveal_sla_ms;
        let v5 = 0x2::clock::timestamp_ms(arg4) - v3;
        assert!(v5 > v4, 13);
        let v6 = RevealStale{
            player          : arg1,
            game_code       : arg2,
            series_id       : arg3,
            committed_at_ms : v3,
            age_ms          : v5,
            sla_ms          : v4,
        };
        0x2::event::emit<RevealStale>(v6);
    }

    public fun register_game(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_code(&arg2);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 64, 11);
        assert!(!0x2::table::contains<vector<u8>, GameConfig>(&arg1.games, copy_bytes(&arg2)), 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = GameConfig{
            code             : arg2,
            name             : arg3,
            active           : true,
            registered_at_ms : v0,
        };
        0x2::table::add<vector<u8>, GameConfig>(&mut arg1.games, copy_bytes(&arg2), v1);
        let v2 = GameRegistered{
            code             : copy_bytes(&arg2),
            name             : copy_bytes(&arg3),
            registered_at_ms : v0,
        };
        0x2::event::emit<GameRegistered>(v2);
    }

    public fun reveal_seed(arg0: &mut Registry, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg4) == 32, 10);
        let v0 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        assert!(0x2::table::contains<SeriesKey, SeriesRecord>(&arg0.series, v0), 6);
        let v1 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        let v2 = 0x2::table::borrow_mut<SeriesKey, SeriesRecord>(&mut arg0.series, v1);
        assert!(0x1::vector::length<u8>(&v2.revealed_seed) == 0, 7);
        let v3 = 0x1::hash::sha2_256(copy_bytes(&arg4));
        assert!(bytes_eq(&v3, &v2.server_seed_hash), 8);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        v2.revealed_seed = copy_bytes(&arg4);
        v2.revealed_at_ms = v4;
        arg0.total_reveals = arg0.total_reveals + 1;
        let v5 = SeedRevealed{
            player          : arg1,
            game_code       : arg2,
            series_id       : arg3,
            revealed_seed   : arg4,
            revealed_at_ms  : v4,
            committed_at_ms : v2.committed_at_ms,
        };
        0x2::event::emit<SeedRevealed>(v5);
    }

    public fun reveal_sla_ms(arg0: &Registry) : u64 {
        arg0.reveal_sla_ms
    }

    public fun series_exists(arg0: &Registry, arg1: address, arg2: vector<u8>, arg3: u64) : bool {
        let v0 = SeriesKey{
            player    : arg1,
            game_code : arg2,
            series_id : arg3,
        };
        0x2::table::contains<SeriesKey, SeriesRecord>(&arg0.series, v0)
    }

    public fun series_is_revealed(arg0: &Registry, arg1: address, arg2: vector<u8>, arg3: u64) : bool {
        let v0 = SeriesKey{
            player    : arg1,
            game_code : copy_bytes(&arg2),
            series_id : arg3,
        };
        if (!0x2::table::contains<SeriesKey, SeriesRecord>(&arg0.series, v0)) {
            return false
        };
        0x1::vector::length<u8>(&0x2::table::borrow<SeriesKey, SeriesRecord>(&arg0.series, v0).revealed_seed) > 0
    }

    public fun set_game_active(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: bool) {
        assert!(0x2::table::contains<vector<u8>, GameConfig>(&arg1.games, copy_bytes(&arg2)), 2);
        0x2::table::borrow_mut<vector<u8>, GameConfig>(&mut arg1.games, copy_bytes(&arg2)).active = arg3;
        let v0 = GameSetActive{
            code   : arg2,
            active : arg3,
        };
        0x2::event::emit<GameSetActive>(v0);
    }

    public fun set_reveal_sla(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg2 >= 3600000 && arg2 <= 31536000000, 14);
        arg1.reveal_sla_ms = arg2;
        let v0 = RevealSlaUpdated{
            old_sla_ms : arg1.reveal_sla_ms,
            new_sla_ms : arg2,
        };
        0x2::event::emit<RevealSlaUpdated>(v0);
    }

    public fun total_batches(arg0: &Registry) : u64 {
        arg0.total_batches
    }

    public fun total_commits(arg0: &Registry) : u64 {
        arg0.total_commits
    }

    public fun total_reveals(arg0: &Registry) : u64 {
        arg0.total_reveals
    }

    // decompiled from Move bytecode v7
}

