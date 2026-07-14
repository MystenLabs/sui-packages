module 0x23cca2a5be14315d6f170832f7ce94997e974b889a7b5aa2dd5d1f338e1770e6::sport_oracle {
    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct SportResult has copy, drop, store {
        event_id: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        home_score: u32,
        away_score: u32,
        winner: u8,
        confidence: u8,
        sport: 0x1::string::String,
        league: 0x1::string::String,
        status: u8,
        queued_at_ms: u64,
        finalized_at_ms: u64,
        dispute_deadline_ms: u64,
        walrus_blob_id: 0x1::string::String,
    }

    struct SportResultRegistry has key {
        id: 0x2::object::UID,
        results: 0x2::table::Table<0x1::string::String, SportResult>,
        total_published: u64,
        total_finalized: u64,
        total_disputed: u64,
        dispute_window_ms: u64,
        version: u64,
    }

    struct ResultPublished has copy, drop {
        event_id: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        home_score: u32,
        away_score: u32,
        winner: u8,
        confidence: u8,
        sport: 0x1::string::String,
        league: 0x1::string::String,
        queued_at_ms: u64,
        dispute_deadline_ms: u64,
    }

    struct ResultFinalized has copy, drop {
        event_id: 0x1::string::String,
        winner: u8,
        confidence: u8,
        finalized_at_ms: u64,
        walrus_blob_id: 0x1::string::String,
    }

    struct ResultDisputed has copy, drop {
        event_id: 0x1::string::String,
        challenger: address,
        disputed_at_ms: u64,
    }

    struct WalrusAnchorSet has copy, drop {
        event_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
    }

    public fun assert_finalized(arg0: &SportResultRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg0.results, arg1), 2);
        let v0 = 0x2::table::borrow<0x1::string::String, SportResult>(&arg0.results, arg1);
        assert!(v0.status == 1, 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.dispute_deadline_ms, 3);
    }

    public fun assert_winner(arg0: &SportResultRegistry, arg1: 0x1::string::String, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg0.results, arg1), 2);
        let v0 = 0x2::table::borrow<0x1::string::String, SportResult>(&arg0.results, arg1);
        assert!(v0.status == 1, 7);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.dispute_deadline_ms, 3);
        assert!(v0.winner == arg2, 6);
    }

    public fun away_score(arg0: &SportResult) : u32 {
        arg0.away_score
    }

    public fun away_team(arg0: &SportResult) : 0x1::string::String {
        arg0.away_team
    }

    public fun batch_publish(arg0: &OracleCap, arg1: &mut SportResultRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u32>, arg6: vector<u32>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 <= 100, 8);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 8);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 8);
        assert!(v0 == 0x1::vector::length<u32>(&arg5), 8);
        assert!(v0 == 0x1::vector::length<u32>(&arg6), 8);
        assert!(v0 == 0x1::vector::length<u8>(&arg7), 8);
        assert!(v0 == 0x1::vector::length<u8>(&arg8), 8);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg9), 8);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg10), 8);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (!0x2::table::contains<0x1::string::String, SportResult>(&arg1.results, v2)) {
                publish_result(arg0, arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<u32>(&arg5, v1), *0x1::vector::borrow<u32>(&arg6, v1), *0x1::vector::borrow<u8>(&arg7, v1), *0x1::vector::borrow<u8>(&arg8, v1), *0x1::vector::borrow<0x1::string::String>(&arg9, v1), *0x1::vector::borrow<0x1::string::String>(&arg10, v1), arg11);
            };
            v1 = v1 + 1;
        };
    }

    public fun confidence(arg0: &SportResult) : u8 {
        arg0.confidence
    }

    public fun dispute_deadline_ms(arg0: &SportResult) : u64 {
        arg0.dispute_deadline_ms
    }

    public fun dispute_result(arg0: &mut SportResultRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg0.results, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, SportResult>(&mut arg0.results, arg1);
        if (v0.status == 0) {
            assert!(0x2::clock::timestamp_ms(arg2) < v0.dispute_deadline_ms, 3);
            v0.status = 2;
            arg0.total_disputed = arg0.total_disputed + 1;
            let v1 = ResultDisputed{
                event_id       : arg1,
                challenger     : 0x2::tx_context::sender(arg3),
                disputed_at_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<ResultDisputed>(v1);
            return
        } else {
            abort if (v0.status == 2) {
                5
            } else {
                4
            }
        };
    }

    public fun finalize_result(arg0: &OracleCap, arg1: &mut SportResultRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg1.results, arg2), 2);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, SportResult>(&mut arg1.results, arg2);
        if (v0.status == 0) {
            assert!(0x2::clock::timestamp_ms(arg3) >= v0.dispute_deadline_ms, 3);
            let v1 = 0x2::clock::timestamp_ms(arg3);
            v0.status = 1;
            v0.finalized_at_ms = v1;
            let v2 = ResultFinalized{
                event_id        : v0.event_id,
                winner          : v0.winner,
                confidence      : v0.confidence,
                finalized_at_ms : v1,
                walrus_blob_id  : v0.walrus_blob_id,
            };
            0x2::event::emit<ResultFinalized>(v2);
            arg1.total_finalized = arg1.total_finalized + 1;
            return
        } else {
            abort if (v0.status == 1) {
                4
            } else {
                5
            }
        };
    }

    public fun finalized_at_ms(arg0: &SportResult) : u64 {
        arg0.finalized_at_ms
    }

    public fun get_result(arg0: &SportResultRegistry, arg1: 0x1::string::String) : SportResult {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg0.results, arg1), 2);
        *0x2::table::borrow<0x1::string::String, SportResult>(&arg0.results, arg1)
    }

    public fun home_score(arg0: &SportResult) : u32 {
        arg0.home_score
    }

    public fun home_team(arg0: &SportResult) : 0x1::string::String {
        arg0.home_team
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SportResultRegistry{
            id                : 0x2::object::new(arg0),
            results           : 0x2::table::new<0x1::string::String, SportResult>(arg0),
            total_published   : 0,
            total_finalized   : 0,
            total_disputed    : 0,
            dispute_window_ms : 7200000,
            version           : 1,
        };
        0x2::transfer::share_object<SportResultRegistry>(v1);
    }

    public fun is_disputed(arg0: &SportResult) : bool {
        arg0.status == 2
    }

    public fun is_final(arg0: &SportResult) : bool {
        arg0.status == 1
    }

    public fun is_pending(arg0: &SportResult) : bool {
        arg0.status == 0
    }

    public fun league(arg0: &SportResult) : 0x1::string::String {
        arg0.league
    }

    public fun publish_result(arg0: &OracleCap, arg1: &mut SportResultRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: u8, arg8: u8, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x1::string::String, SportResult>(&arg1.results, arg2), 1);
        assert!(arg7 <= 2, 10);
        assert!(arg8 <= 100, 9);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        let v1 = v0 + arg1.dispute_window_ms;
        let v2 = SportResult{
            event_id            : arg2,
            home_team           : arg3,
            away_team           : arg4,
            home_score          : arg5,
            away_score          : arg6,
            winner              : arg7,
            confidence          : arg8,
            sport               : arg9,
            league              : arg10,
            status              : 0,
            queued_at_ms        : v0,
            finalized_at_ms     : 0,
            dispute_deadline_ms : v1,
            walrus_blob_id      : 0x1::string::utf8(b""),
        };
        let v3 = ResultPublished{
            event_id            : v2.event_id,
            home_team           : v2.home_team,
            away_team           : v2.away_team,
            home_score          : v2.home_score,
            away_score          : v2.away_score,
            winner              : v2.winner,
            confidence          : v2.confidence,
            sport               : v2.sport,
            league              : v2.league,
            queued_at_ms        : v0,
            dispute_deadline_ms : v1,
        };
        0x2::event::emit<ResultPublished>(v3);
        0x2::table::add<0x1::string::String, SportResult>(&mut arg1.results, arg2, v2);
        arg1.total_published = arg1.total_published + 1;
    }

    public fun queued_at_ms(arg0: &SportResult) : u64 {
        arg0.queued_at_ms
    }

    public fun registry_dispute_window_ms(arg0: &SportResultRegistry) : u64 {
        arg0.dispute_window_ms
    }

    public fun registry_total_disputed(arg0: &SportResultRegistry) : u64 {
        arg0.total_disputed
    }

    public fun registry_total_finalized(arg0: &SportResultRegistry) : u64 {
        arg0.total_finalized
    }

    public fun registry_total_published(arg0: &SportResultRegistry) : u64 {
        arg0.total_published
    }

    public fun registry_version(arg0: &SportResultRegistry) : u64 {
        arg0.version
    }

    public fun result_exists(arg0: &SportResultRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, SportResult>(&arg0.results, arg1)
    }

    public fun set_walrus_anchor(arg0: &OracleCap, arg1: &mut SportResultRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, SportResult>(&arg1.results, arg2), 2);
        0x2::table::borrow_mut<0x1::string::String, SportResult>(&mut arg1.results, arg2).walrus_blob_id = arg3;
        let v0 = WalrusAnchorSet{
            event_id       : arg2,
            walrus_blob_id : arg3,
        };
        0x2::event::emit<WalrusAnchorSet>(v0);
    }

    public fun sport(arg0: &SportResult) : 0x1::string::String {
        arg0.sport
    }

    public fun status(arg0: &SportResult) : u8 {
        arg0.status
    }

    public fun status_disputed() : u8 {
        2
    }

    public fun status_final() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    public fun walrus_blob_id(arg0: &SportResult) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public fun winner(arg0: &SportResult) : u8 {
        arg0.winner
    }

    public fun winner_away() : u8 {
        1
    }

    public fun winner_draw() : u8 {
        2
    }

    public fun winner_home() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

