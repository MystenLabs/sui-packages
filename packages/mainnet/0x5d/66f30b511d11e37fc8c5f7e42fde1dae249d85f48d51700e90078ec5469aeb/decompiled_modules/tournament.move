module 0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::tournament {
    struct TournamentOperatorCap has key {
        id: 0x2::object::UID,
    }

    struct BlindLevel has copy, drop, store {
        small: u64,
        big: u64,
    }

    struct TournamentDefinition has copy, drop, store {
        protocol_id: vector<u8>,
        dispute_window_ms: u64,
        referee_signature_type: u8,
        referee_public_key: vector<u8>,
        admitted_evidence_class: u8,
        funder: address,
        start_ms: u64,
        end_ms: u64,
        matchmaking_close_before_end_ms: u64,
        tickets_per_bundle: u64,
        chips_per_ticket: u64,
        base_blind_levels: vector<BlindLevel>,
        base_blind_interval_ms: u64,
        hands_per_level: u32,
        hand_limit: u32,
        decision_deadline_ms: u64,
        min_seats: u8,
        max_seats: u8,
        fill_wait_ms: u64,
        matchmaking_patience_ms: u64,
        stack_band_ratio: u64,
        table_stall_after_ms: u64,
        leaderboard_size: u32,
        transcript_retention_ms: u64,
    }

    struct EligibilityKey has store {
        revoked: bool,
        signature_type: u8,
    }

    struct EntryPass has key {
        id: 0x2::object::UID,
        tournament: 0x2::object::ID,
        owner: address,
        plays_left: u64,
        minted: u64,
    }

    struct EntryPassKey has copy, drop, store {
        owner: address,
    }

    struct PlayKey has copy, drop, store {
        index: u64,
    }

    struct Play has key {
        id: 0x2::object::UID,
        tournament: 0x2::object::ID,
        owner: address,
        index: u64,
        agent: 0x1::option::Option<address>,
    }

    struct Entry has store {
        owner: address,
        balance: u64,
        state: u8,
        tickets_redeemed: u64,
        last_settle_ms: u64,
        joined_at_ms: u64,
        tunnel: 0x1::option::Option<0x2::object::ID>,
    }

    struct TableRecord has store {
        seats: vector<address>,
        deposits: vector<u64>,
        funded_at_ms: u64,
        product_manifest_digest: vector<u8>,
        execution_manifest_digest: vector<u8>,
    }

    struct LeaderboardRow has copy, drop, store {
        agent: address,
        balance: u64,
        tickets_redeemed: u64,
        last_settle_ms: u64,
    }

    struct Tournament has key {
        id: 0x2::object::UID,
        contract_schema_version: u16,
        module_version: u64,
        paused: bool,
        event_seq: u64,
        definition: TournamentDefinition,
        eligibility_keys: 0x2::table::Table<vector<u8>, EligibilityKey>,
        entries: 0x2::table::Table<address, Entry>,
        entry_order: 0x2::table_vec::TableVec<address>,
        escrow: 0x2::balance::Balance<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>,
        tables: 0x2::table::Table<0x2::object::ID, TableRecord>,
        drained_tables: 0x2::table::Table<0x2::object::ID, TableRecord>,
        minted: u64,
        burned: u64,
        queued_count: u64,
        seated_count: u64,
        finalize_cursor: u64,
        finalized: bool,
        leaderboard: vector<LeaderboardRow>,
    }

    struct TournamentCreated has copy, drop {
        tournament_id: 0x2::object::ID,
        contract_schema_version: u16,
        module_version: u64,
        definition: TournamentDefinition,
    }

    struct TournamentVersionMigrated has copy, drop {
        tournament_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct TournamentPauseChanged has copy, drop {
        tournament_id: 0x2::object::ID,
        paused: bool,
    }

    struct PassClaimed has copy, drop {
        tournament_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        owner: address,
        plays: u64,
    }

    struct PlayCreated has copy, drop {
        tournament_id: 0x2::object::ID,
        play_id: 0x2::object::ID,
        owner: address,
        agent: address,
        index: u64,
        plays_left: u64,
    }

    struct PlayReassigned has copy, drop {
        tournament_id: 0x2::object::ID,
        play_id: 0x2::object::ID,
        owner: address,
        agent: 0x1::option::Option<address>,
    }

    struct PlayDeleted has copy, drop {
        tournament_id: 0x2::object::ID,
        play_id: 0x2::object::ID,
        owner: address,
        redeemed: bool,
        plays_left: 0x1::option::Option<u64>,
    }

    struct ChipsRedeemed has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        agent: address,
        owner: address,
        play_id: 0x2::object::ID,
        burned: u64,
        minted: u64,
        balance: u64,
        tickets_redeemed: u64,
        entry_index: 0x1::option::Option<u64>,
        redeemed_at_ms: u64,
    }

    struct QueueJoined has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        agent: address,
        owner: address,
        balance: u64,
        joined_at_ms: u64,
        queued_count: u64,
        seated_count: u64,
    }

    struct QueueLeft has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        agent: address,
        balance: u64,
        left_at_ms: u64,
        queued_count: u64,
        seated_count: u64,
    }

    struct TableFunded has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        tunnel_id: 0x2::object::ID,
        seats: vector<address>,
        deposits: vector<u64>,
        owners: vector<address>,
        funded_at_ms: u64,
        drainable_at_ms: u64,
        product_manifest_digest: vector<u8>,
        execution_manifest_digest: vector<u8>,
        queued_count: u64,
        seated_count: u64,
    }

    struct TableDrained has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        tunnel_id: 0x2::object::ID,
        seats: vector<address>,
        drained_at_ms: u64,
        queued_count: u64,
        seated_count: u64,
    }

    struct TableBooked has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        tunnel_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        seats: vector<address>,
        balances: vector<u64>,
        refunded: bool,
        was_drained: bool,
        settled_at_ms: u64,
        queued_count: u64,
        seated_count: u64,
    }

    struct TournamentFinalized has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        entries: u64,
        finalized_at_ms: u64,
        leaderboard: vector<LeaderboardRow>,
    }

    struct FinalizeProgressed has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        cursor: u64,
        total: u64,
    }

    struct LeaderboardRevised has copy, drop {
        tournament_id: 0x2::object::ID,
        event_seq: u64,
        tunnel_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        seats: vector<address>,
    }

    struct EligibilityKeyChanged has copy, drop {
        tournament_id: 0x2::object::ID,
        public_key: vector<u8>,
        revoked: bool,
        signature_type: u8,
    }

    struct TOURNAMENT has drop {
        dummy_field: bool,
    }

    public fun admitted(arg0: &Tournament) : bool {
        version_is_admitted(1, arg0.module_version)
    }

    fun assert_definition(arg0: &TournamentDefinition, arg1: u64) {
        let v0 = &arg0.base_blind_levels;
        let v1 = 0x1::vector::length<BlindLevel>(v0);
        assert!(0x1::vector::length<u8>(&arg0.protocol_id) == 32, 13906841407069683734);
        assert!(arg0.dispute_window_ms >= 3600000 && arg0.dispute_window_ms <= 2592000000, 13906841424249552918);
        if (0x1::vector::length<u8>(&arg0.referee_public_key) == 0) {
            assert!(arg0.referee_signature_type == 0, 13906841454314323990);
        } else {
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg0.referee_signature_type) && 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg0.referee_signature_type, &arg0.referee_public_key), 13906841488674062358);
        };
        assert!(arg0.admitted_evidence_class == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::evidence_class_local() || arg0.admitted_evidence_class == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::evidence_class_nitro(), 13906841514443866134);
        assert!(arg0.funder != @0x0, 13906841523033800726);
        assert!(arg0.start_ms >= arg1, 13906841527328768022);
        let v2 = if (arg0.matchmaking_close_before_end_ms > 0) {
            if (arg0.end_ms > arg0.start_ms) {
                arg0.end_ms - arg0.start_ms > arg0.matchmaking_close_before_end_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 13906841548803604502);
        assert!(arg0.end_ms <= 0x1::u64::saturating_add(arg1, 31536000000), 13906841574573408278);
        assert!(arg0.tickets_per_bundle > 0 && arg0.tickets_per_bundle <= 100, 13906841596048244758);
        assert!(v1 > 0 && v1 <= 255, 13906841604638179350);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow<BlindLevel>(v0, v3);
            assert!(v4.small > 0 && v4.small < v4.big, 13906841621818048534);
            if (v3 > 0) {
                let v5 = 0x1::vector::borrow<BlindLevel>(v0, v3 - 1);
                assert!(v4.small > v5.small && v4.big > v5.big, 13906841643292885014);
            };
            v3 = v3 + 1;
        };
        assert!(arg0.chips_per_ticket > 0x1::vector::borrow<BlindLevel>(v0, v1 - 1).big, 13906841664767721494);
        assert!(arg0.chips_per_ticket <= 1000000000, 13906841669062688790);
        assert!(arg0.base_blind_interval_ms > 0, 13906841673357656086);
        assert!(arg0.end_ms - arg0.start_ms > arg0.base_blind_interval_ms, 13906841699127459862);
        let v6 = if (arg0.hands_per_level > 0) {
            if (arg0.hand_limit > 0) {
                arg0.decision_deadline_ms > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13906841720602296342);
        let v7 = if (arg0.min_seats >= 2) {
            if (arg0.min_seats <= arg0.max_seats) {
                arg0.max_seats <= 10
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 13906841746372100118);
        assert!(arg0.stack_band_ratio > 0, 13906841754962034710);
        assert!(arg0.table_stall_after_ms >= 60000 && arg0.table_stall_after_ms <= 86400000, 13906841819386544150);
        assert!(arg0.table_stall_after_ms >= arg0.fill_wait_ms, 13906841836566413334);
        let v8 = if (arg0.matchmaking_patience_ms >= 1000) {
            if (arg0.matchmaking_patience_ms <= 86400000) {
                arg0.matchmaking_patience_ms >= arg0.fill_wait_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 13906841870926151702);
        assert!(arg0.leaderboard_size > 0 && arg0.leaderboard_size <= 250, 13906841888106020886);
        assert!(arg0.transcript_retention_ms >= 86400000, 13906841905285890070);
    }

    fun assert_live(arg0: &Tournament) {
        assert_version(arg0);
        assert!(!arg0.paused, 13906842051321069686);
    }

    fun assert_record_binds_table(arg0: &Tournament, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord, arg2: 0x2::object::ID) {
        let v0 = table_record(arg0, arg2);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_protocol_id(arg1) == arg0.definition.protocol_id, 13906840711288258632);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_product_manifest_digest(arg1) == v0.product_manifest_digest, 13906840724173291594);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_resolution_policy_digest(arg1) == resolution_policy_digest_for(arg2, &arg0.definition), 13906840745648259148);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_evidence_class(arg1) == arg0.definition.admitted_evidence_class, 13906840767123226702);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_execution_manifest_digest(arg1) == v0.execution_manifest_digest, 13906840784303226960);
    }

    fun assert_version(arg0: &Tournament) {
        assert!(admitted(arg0), 13906842021256167540);
    }

    fun big_blind_at(arg0: &TournamentDefinition, arg1: u64) : u64 {
        0x1::vector::borrow<BlindLevel>(&arg0.base_blind_levels, level_at(arg0, arg1)).big
    }

    fun book_table(arg0: &mut Tournament, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u64>, arg5: bool) {
        assert!(holds_table(arg0, arg1), 13906840835843620956);
        let v0 = 0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.drained_tables, arg1);
        let v1 = take_table(arg0, arg1);
        let TableRecord {
            seats                     : v2,
            deposits                  : v3,
            funded_at_ms              : _,
            product_manifest_digest   : _,
            execution_manifest_digest : _,
        } = v1;
        let v7 = v3;
        let v8 = v2;
        assert!(0x1::vector::length<u64>(&arg4) == 0x1::vector::length<address>(&v8), 13906840874498981990);
        assert!(sum(&arg4) == sum(&v7), 13906840878794080360);
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(&v8)) {
            let v10 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, *0x1::vector::borrow<address>(&v8, v9));
            v10.balance = *0x1::vector::borrow<u64>(&arg4, v9);
            v10.state = 0;
            v10.tunnel = 0x1::option::none<0x2::object::ID>();
            v10.last_settle_ms = arg3;
            if (v10.state == 2) {
                arg0.seated_count = arg0.seated_count - 1;
            };
            v9 = v9 + 1;
        };
        let v11 = bump_event_seq(arg0);
        let v12 = TableBooked{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            event_seq     : v11,
            tunnel_id     : arg1,
            record_id     : arg2,
            seats         : v8,
            balances      : arg4,
            refunded      : arg5,
            was_drained   : v0,
            settled_at_ms : arg3,
            queued_count  : arg0.queued_count,
            seated_count  : arg0.seated_count,
        };
        0x2::event::emit<TableBooked>(v12);
        if (arg0.finalize_cursor > 0) {
            arg0.finalize_cursor = 0;
            arg0.leaderboard = 0x1::vector::empty<LeaderboardRow>();
            arg0.finalized = false;
            let v13 = 0x2::object::id<Tournament>(arg0);
            let v14 = LeaderboardRevised{
                tournament_id : v13,
                event_seq     : bump_event_seq(arg0),
                tunnel_id     : arg1,
                record_id     : arg2,
                seats         : v8,
            };
            0x2::event::emit<LeaderboardRevised>(v14);
        };
    }

    fun bump_event_seq(arg0: &mut Tournament) : u64 {
        arg0.event_seq = arg0.event_seq + 1;
        arg0.event_seq
    }

    public fun burned(arg0: &Tournament) : u64 {
        arg0.burned
    }

    fun claim_message(arg0: 0x2::object::ID, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"dopa_open::tournament::bundle_claim::v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    entry fun claim_pass(arg0: &mut Tournament, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 < close_ms(&arg0.definition), 13906837825067089944);
        assert!(v1 < arg1, 13906837829362188314);
        assert!(0x2::table::contains<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg3), 13906837833657286684);
        let v2 = 0x2::table::borrow<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg3);
        assert!(!v2.revoked, 13906837842247352350);
        assert!(arg2 == v2.signature_type, 13906837846542450720);
        let v3 = claim_message(0x2::object::id<Tournament>(arg0), v0, arg1);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg2, &arg3, &v3, &arg4), 13906837863722450978);
        let v4 = 0x2::object::id<Tournament>(arg0);
        let v5 = arg0.definition.tickets_per_bundle;
        let v6 = EntryPassKey{owner: v0};
        let v7 = 0x2::derived_object::claim<EntryPassKey>(&mut arg0.id, v6);
        let v8 = EntryPass{
            id         : v7,
            tournament : v4,
            owner      : v0,
            plays_left : v5,
            minted     : 0,
        };
        0x2::transfer::transfer<EntryPass>(v8, v0);
        let v9 = PassClaimed{
            tournament_id : v4,
            pass_id       : 0x2::object::uid_to_inner(&v7),
            owner         : v0,
            plays         : v5,
        };
        0x2::event::emit<PassClaimed>(v9);
    }

    fun close_ms(arg0: &TournamentDefinition) : u64 {
        arg0.end_ms - arg0.matchmaking_close_before_end_ms
    }

    public fun contract_schema_version(arg0: &Tournament) : u16 {
        arg0.contract_schema_version
    }

    public fun create_tournament(arg0: &TournamentOperatorCap, arg1: TournamentDefinition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_definition(&arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = 0x2::object::new(arg3);
        let v1 = TournamentCreated{
            tournament_id           : 0x2::object::uid_to_inner(&v0),
            contract_schema_version : 1,
            module_version          : 1,
            definition              : arg1,
        };
        0x2::event::emit<TournamentCreated>(v1);
        let v2 = Tournament{
            id                      : v0,
            contract_schema_version : 1,
            module_version          : 1,
            paused                  : false,
            event_seq               : 0,
            definition              : arg1,
            eligibility_keys        : 0x2::table::new<vector<u8>, EligibilityKey>(arg3),
            entries                 : 0x2::table::new<address, Entry>(arg3),
            entry_order             : 0x2::table_vec::empty<address>(arg3),
            escrow                  : 0x2::balance::zero<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(),
            tables                  : 0x2::table::new<0x2::object::ID, TableRecord>(arg3),
            drained_tables          : 0x2::table::new<0x2::object::ID, TableRecord>(arg3),
            minted                  : 0,
            burned                  : 0,
            queued_count            : 0,
            seated_count            : 0,
            finalize_cursor         : 0,
            finalized               : false,
            leaderboard             : 0x1::vector::empty<LeaderboardRow>(),
        };
        0x2::transfer::share_object<Tournament>(v2);
    }

    public fun current_big_blind(arg0: &Tournament, arg1: &0x2::clock::Clock) : u64 {
        big_blind_at(&arg0.definition, 0x2::clock::timestamp_ms(arg1))
    }

    public fun current_level(arg0: &Tournament, arg1: &0x2::clock::Clock) : u64 {
        level_at(&arg0.definition, 0x2::clock::timestamp_ms(arg1))
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun definition(arg0: &Tournament) : TournamentDefinition {
        arg0.definition
    }

    public fun definition_chips_per_ticket(arg0: &TournamentDefinition) : u64 {
        arg0.chips_per_ticket
    }

    public fun definition_close_ms(arg0: &TournamentDefinition) : u64 {
        close_ms(arg0)
    }

    public fun definition_end_ms(arg0: &TournamentDefinition) : u64 {
        arg0.end_ms
    }

    public fun definition_funder(arg0: &TournamentDefinition) : address {
        arg0.funder
    }

    public fun definition_hands_per_level(arg0: &TournamentDefinition) : u32 {
        arg0.hands_per_level
    }

    public fun definition_levels(arg0: &TournamentDefinition) : vector<BlindLevel> {
        arg0.base_blind_levels
    }

    public fun definition_matchmaking_patience_ms(arg0: &TournamentDefinition) : u64 {
        arg0.matchmaking_patience_ms
    }

    public fun definition_start_ms(arg0: &TournamentDefinition) : u64 {
        arg0.start_ms
    }

    public fun definition_table_stall_after_ms(arg0: &TournamentDefinition) : u64 {
        arg0.table_stall_after_ms
    }

    entry fun drain_table(arg0: &mut Tournament, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        if (0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.drained_tables, arg1)) {
            abort 13906840311857741918
        };
        assert!(0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.tables, arg1), 13906840320447545436);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::u64::saturating_add(0x2::table::borrow<0x2::object::ID, TableRecord>(&arg0.tables, arg1).funded_at_ms, arg0.definition.table_stall_after_ms), 13906840354807545952);
        let v0 = 0x2::table::remove<0x2::object::ID, TableRecord>(&mut arg0.tables, arg1);
        0x2::table::add<0x2::object::ID, TableRecord>(&mut arg0.drained_tables, arg1, v0);
        let v1 = bump_event_seq(arg0);
        let v2 = TableDrained{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            event_seq     : v1,
            tunnel_id     : arg1,
            seats         : v0.seats,
            drained_at_ms : 0x2::clock::timestamp_ms(arg2),
            queued_count  : arg0.queued_count,
            seated_count  : arg0.seated_count,
        };
        0x2::event::emit<TableDrained>(v2);
    }

    public fun drained_table_count(arg0: &Tournament) : u64 {
        0x2::table::length<0x2::object::ID, TableRecord>(&arg0.drained_tables)
    }

    public fun ed25519_address(arg0: &vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun entry_balance(arg0: &Tournament, arg1: address) : u64 {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).balance
    }

    public fun entry_count(arg0: &Tournament) : u64 {
        0x2::table_vec::length<address>(&arg0.entry_order)
    }

    public fun entry_joined_at_ms(arg0: &Tournament, arg1: address) : u64 {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).joined_at_ms
    }

    public fun entry_last_settle_ms(arg0: &Tournament, arg1: address) : u64 {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).last_settle_ms
    }

    public fun entry_owner(arg0: &Tournament, arg1: address) : address {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).owner
    }

    public fun entry_state(arg0: &Tournament, arg1: address) : u8 {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).state
    }

    public fun entry_tickets_redeemed(arg0: &Tournament, arg1: address) : u64 {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).tickets_redeemed
    }

    public fun entry_tunnel(arg0: &Tournament, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        0x2::table::borrow<address, Entry>(&arg0.entries, arg1).tunnel
    }

    public fun escrow_value(arg0: &Tournament) : u64 {
        0x2::balance::value<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&arg0.escrow)
    }

    public fun event_seq(arg0: &Tournament) : u64 {
        arg0.event_seq
    }

    entry fun finalize(arg0: &mut Tournament, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_live(arg0);
        assert!(!arg0.finalized, 13906840084225654896);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.definition.end_ms, 13906840088520360044);
        assert!(0x2::table::is_empty<0x2::object::ID, TableRecord>(&arg0.tables), 13906840092815458414);
        assert!(arg1 > 0, 13906840097110687858);
        let v0 = 0x2::table_vec::length<address>(&arg0.entry_order);
        while (arg0.finalize_cursor < 0x1::u64::min(arg0.finalize_cursor + 0x1::u64::min(arg1, 450), v0)) {
            let v1 = *0x2::table_vec::borrow<address>(&arg0.entry_order, arg0.finalize_cursor);
            let v2 = 0x2::table::borrow<address, Entry>(&arg0.entries, v1);
            let v3 = LeaderboardRow{
                agent            : v1,
                balance          : v2.balance,
                tickets_redeemed : v2.tickets_redeemed,
                last_settle_ms   : v2.last_settle_ms,
            };
            let v4 = &mut arg0.leaderboard;
            insert_ranked(v4, v3, (arg0.definition.leaderboard_size as u64));
            arg0.finalize_cursor = arg0.finalize_cursor + 1;
        };
        let v5 = arg0.finalize_cursor;
        if (v5 == v0) {
            arg0.finalized = true;
            let v6 = bump_event_seq(arg0);
            let v7 = TournamentFinalized{
                tournament_id   : 0x2::object::id<Tournament>(arg0),
                event_seq       : v6,
                entries         : v0,
                finalized_at_ms : 0x2::clock::timestamp_ms(arg2),
                leaderboard     : arg0.leaderboard,
            };
            0x2::event::emit<TournamentFinalized>(v7);
        } else {
            let v8 = bump_event_seq(arg0);
            let v9 = FinalizeProgressed{
                tournament_id : 0x2::object::id<Tournament>(arg0),
                event_seq     : v8,
                cursor        : v5,
                total         : v0,
            };
            0x2::event::emit<FinalizeProgressed>(v9);
        };
    }

    entry fun fund_table(arg0: &mut Tournament, arg1: &mut 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::ArenaTunnel<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(in_play_window(&arg0.definition, 0x2::clock::timestamp_ms(arg3)), 13906839220933165106);
        assert!(0x2::tx_context::sender(arg4) == arg0.definition.funder, 13906839225229443142);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::protocol_id<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) == arg0.definition.protocol_id, 13906839229524541512);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::dispute_window_ms<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) == arg0.definition.dispute_window_ms, 13906839255294607436);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::referee_signature_type<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) == arg0.definition.referee_signature_type, 13906839276769443916);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::referee_public_key<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) == arg0.definition.referee_public_key, 13906839293949313100);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::admitted_evidence_class<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) == arg0.definition.admitted_evidence_class, 13906839315424280654);
        let v0 = (0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::participant_count<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1) as u64);
        assert!(v0 >= (arg0.definition.min_seats as u64) && v0 <= (arg0.definition.max_seats as u64), 13906839358374215762);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x2::vec_set::empty<address>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::seat_beneficiary<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, v4);
            assert!(0x2::table::contains<address, Entry>(&arg0.entries, v5), 13906839397029052500);
            let v6 = 0x2::table::borrow<address, Entry>(&arg0.entries, v5);
            assert!(v6.state == 1, 13906839405618987092);
            assert!(v6.balance == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::seat_required_deposit<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, v4), 13906839409914085462);
            let v7 = if (0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::seat_signature_type<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, v4) == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::ed25519()) {
                let v8 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::seat_participant_public_key<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, v4);
                ed25519_address(&v8) == v5
            } else {
                false
            };
            assert!(v7, 13906839427094085720);
            assert!(!0x2::vec_set::contains<address>(&v3, &v6.owner), 13906839435684151386);
            0x2::vec_set::insert<address>(&mut v3, v6.owner);
            0x1::vector::push_back<address>(&mut v1, v5);
            0x1::vector::push_back<u64>(&mut v2, v6.balance);
            v4 = v4 + 1;
        };
        let v9 = 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::ArenaTunnel<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>>(arg1);
        let v10 = 0x2::clock::timestamp_ms(arg3);
        let v11 = vector[];
        v4 = 0;
        while (v4 < v0) {
            0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::fund<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::seat_id<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1, v4), arg2, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::current_resolution_policy_digest<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1), arg0.definition.admitted_evidence_class, 0x2::balance::split<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&mut arg0.escrow, *0x1::vector::borrow<u64>(&v2, v4)), arg3, arg4);
            let v12 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, *0x1::vector::borrow<address>(&v1, v4));
            v12.state = 2;
            v12.tunnel = 0x1::option::some<0x2::object::ID>(v9);
            0x1::vector::push_back<address>(&mut v11, v12.owner);
            v4 = v4 + 1;
        };
        arg0.queued_count = arg0.queued_count - v0;
        arg0.seated_count = arg0.seated_count + v0;
        let v13 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::product_manifest_digest<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1);
        let v14 = TableRecord{
            seats                     : v1,
            deposits                  : v2,
            funded_at_ms              : v10,
            product_manifest_digest   : v13,
            execution_manifest_digest : arg2,
        };
        0x2::table::add<0x2::object::ID, TableRecord>(&mut arg0.tables, v9, v14);
        let v15 = bump_event_seq(arg0);
        let v16 = TableFunded{
            tournament_id             : 0x2::object::id<Tournament>(arg0),
            event_seq                 : v15,
            tunnel_id                 : v9,
            seats                     : v1,
            deposits                  : v2,
            owners                    : v11,
            funded_at_ms              : v10,
            drainable_at_ms           : v10 + arg0.definition.table_stall_after_ms,
            product_manifest_digest   : v13,
            execution_manifest_digest : arg2,
            queued_count              : arg0.queued_count,
            seated_count              : arg0.seated_count,
        };
        0x2::event::emit<TableFunded>(v16);
    }

    entry fun give_back(arg0: &Tournament, arg1: &mut Play, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.tournament == 0x2::object::id<Tournament>(arg0), 13906838409183690792);
        assert!(arg1.agent == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 13906838413478920236);
        arg1.agent = 0x1::option::none<address>();
        let v0 = PlayReassigned{
            tournament_id : arg1.tournament,
            play_id       : 0x2::object::id<Play>(arg1),
            owner         : arg1.owner,
            agent         : arg1.agent,
        };
        0x2::event::emit<PlayReassigned>(v0);
    }

    entry fun hand_out(arg0: &Tournament, arg1: &mut EntryPass, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 13906837988277289006);
        assert!(arg1.tournament == 0x2::object::id<Tournament>(arg0), 13906837992571863080);
        assert!(0x2::clock::timestamp_ms(arg4) < close_ms(&arg0.definition), 13906837996865781784);
        assert!(arg3 > 0, 13906838001162715190);
        assert!(arg3 <= 32, 13906838005456896042);
        assert!(arg1.plays_left >= arg3, 13906838009752518708);
        assert!(arg1.minted + arg3 <= 512, 13906838022641877112);
        arg1.plays_left = arg1.plays_left - arg3;
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = arg1.minted;
            arg1.minted = arg1.minted + 1;
            let v2 = PlayKey{index: v1};
            let v3 = 0x2::derived_object::claim<PlayKey>(&mut arg1.id, v2);
            let v4 = PlayCreated{
                tournament_id : arg1.tournament,
                play_id       : 0x2::object::uid_to_inner(&v3),
                owner         : arg1.owner,
                agent         : arg2,
                index         : v1,
                plays_left    : arg1.plays_left,
            };
            0x2::event::emit<PlayCreated>(v4);
            let v5 = Play{
                id         : v3,
                tournament : arg1.tournament,
                owner      : arg1.owner,
                index      : v1,
                agent      : 0x1::option::some<address>(arg2),
            };
            0x2::transfer::share_object<Play>(v5);
            v0 = v0 + 1;
        };
    }

    public fun has_drained_table(arg0: &Tournament, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.drained_tables, arg1)
    }

    public fun has_entry(arg0: &Tournament, arg1: address) : bool {
        0x2::table::contains<address, Entry>(&arg0.entries, arg1)
    }

    public fun has_table(arg0: &Tournament, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.tables, arg1)
    }

    fun holds_table(arg0: &Tournament, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.tables, arg1) || 0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.drained_tables, arg1)
    }

    fun in_play_window(arg0: &TournamentDefinition, arg1: u64) : bool {
        arg1 >= arg0.start_ms && arg1 < close_ms(arg0)
    }

    fun init(arg0: TOURNAMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TournamentOperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TournamentOperatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<TOURNAMENT>(arg0, arg1);
        let v2 = 0x2::display::new<EntryPass>(&v1, arg1);
        0x2::display::add<EntryPass>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DOPA-OPEN entry pass"));
        0x2::display::add<EntryPass>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{plays_left} plays left in tournament {tournament}. Hand them to your agents; each play enters one table."));
        0x2::display::update_version<EntryPass>(&mut v2);
        let v3 = 0x2::display::new<Play>(&v1, arg1);
        0x2::display::add<Play>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DOPA-OPEN play"));
        0x2::display::add<Play>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"One entry into tournament {tournament}, held for the agent it names."));
        0x2::display::update_version<Play>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<EntryPass>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Play>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    fun insert_ranked(arg0: &mut vector<LeaderboardRow>, arg1: LeaderboardRow, arg2: u64) {
        let v0 = 0x1::vector::length<LeaderboardRow>(arg0);
        if (v0 == arg2 && !ranks_above(&arg1, 0x1::vector::borrow<LeaderboardRow>(arg0, v0 - 1))) {
            return
        };
        let v1 = 0;
        let v2 = v0;
        while (v1 < v2) {
            v2 = (v1 + v2) / 2;
            if (ranks_above(0x1::vector::borrow<LeaderboardRow>(arg0, v2), &arg1)) {
                v1 = v2 + 1;
                continue
            };
        };
        0x1::vector::insert<LeaderboardRow>(arg0, arg1, v1);
        if (0x1::vector::length<LeaderboardRow>(arg0) > arg2) {
            0x1::vector::pop_back<LeaderboardRow>(arg0);
        };
    }

    public fun is_finalized(arg0: &Tournament) : bool {
        arg0.finalized
    }

    fun is_refund_disposition(arg0: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord) : bool {
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_disposition(arg0);
        v0 == 3 || v0 == 1 && 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_terminal_nonce(arg0) == 0
    }

    public fun leaderboard(arg0: &Tournament) : vector<LeaderboardRow> {
        arg0.leaderboard
    }

    fun level_at(arg0: &TournamentDefinition, arg1: u64) : u64 {
        if (arg1 < arg0.start_ms) {
            return 0
        };
        0x1::u64::min((arg1 - arg0.start_ms) / arg0.base_blind_interval_ms, 0x1::vector::length<BlindLevel>(&arg0.base_blind_levels) - 1)
    }

    public fun level_big(arg0: &BlindLevel) : u64 {
        arg0.big
    }

    public fun level_small(arg0: &BlindLevel) : u64 {
        arg0.small
    }

    entry fun migrate_version(arg0: &TournamentOperatorCap, arg1: &mut Tournament) {
        arg1.module_version = 1;
        let v0 = TournamentVersionMigrated{
            tournament_id : 0x2::object::id<Tournament>(arg1),
            from_version  : arg1.module_version,
            to_version    : 1,
        };
        0x2::event::emit<TournamentVersionMigrated>(v0);
    }

    public fun minted(arg0: &Tournament) : u64 {
        arg0.minted
    }

    public fun module_version(arg0: &Tournament) : u64 {
        arg0.module_version
    }

    public fun new_blind_level(arg0: u64, arg1: u64) : BlindLevel {
        BlindLevel{
            small : arg0,
            big   : arg1,
        }
    }

    public fun new_definition(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: u8, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<BlindLevel>, arg12: u64, arg13: u32, arg14: u32, arg15: u64, arg16: u8, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u32, arg23: u64) : TournamentDefinition {
        TournamentDefinition{
            protocol_id                     : arg0,
            dispute_window_ms               : arg1,
            referee_signature_type          : arg2,
            referee_public_key              : arg3,
            admitted_evidence_class         : arg4,
            funder                          : arg5,
            start_ms                        : arg6,
            end_ms                          : arg7,
            matchmaking_close_before_end_ms : arg8,
            tickets_per_bundle              : arg9,
            chips_per_ticket                : arg10,
            base_blind_levels               : arg11,
            base_blind_interval_ms          : arg12,
            hands_per_level                 : arg13,
            hand_limit                      : arg14,
            decision_deadline_ms            : arg15,
            min_seats                       : arg16,
            max_seats                       : arg17,
            fill_wait_ms                    : arg18,
            matchmaking_patience_ms         : arg19,
            stack_band_ratio                : arg20,
            table_stall_after_ms            : arg21,
            leaderboard_size                : arg22,
            transcript_retention_ms         : arg23,
        }
    }

    public fun open_table_count(arg0: &Tournament) : u64 {
        0x2::table::length<0x2::object::ID, TableRecord>(&arg0.tables)
    }

    public fun pass_exists(arg0: &Tournament, arg1: address) : bool {
        let v0 = EntryPassKey{owner: arg1};
        0x2::derived_object::exists<EntryPassKey>(&arg0.id, v0)
    }

    public fun pass_id(arg0: &Tournament, arg1: address) : 0x2::object::ID {
        let v0 = EntryPassKey{owner: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<EntryPassKey>(0x2::object::id<Tournament>(arg0), v0))
    }

    public fun pass_minted(arg0: &EntryPass) : u64 {
        arg0.minted
    }

    public fun pass_owner(arg0: &EntryPass) : address {
        arg0.owner
    }

    public fun pass_plays_left(arg0: &EntryPass) : u64 {
        arg0.plays_left
    }

    public fun pass_tournament(arg0: &EntryPass) : 0x2::object::ID {
        arg0.tournament
    }

    public fun paused(arg0: &Tournament) : bool {
        arg0.paused
    }

    public fun play_agent(arg0: &Play) : 0x1::option::Option<address> {
        arg0.agent
    }

    public fun play_id(arg0: &EntryPass, arg1: u64) : 0x2::object::ID {
        let v0 = PlayKey{index: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<PlayKey>(0x2::object::id<EntryPass>(arg0), v0))
    }

    public fun play_index(arg0: &Play) : u64 {
        arg0.index
    }

    public fun play_owner(arg0: &Play) : address {
        arg0.owner
    }

    public fun play_tournament(arg0: &Play) : 0x2::object::ID {
        arg0.tournament
    }

    public fun queue_join(arg0: &mut Tournament, arg1: 0x2::coin::Coin<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(in_play_window(&arg0.definition, v1), 13906838868745846834);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, v0), 13906838873041600574);
        let v2 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, v0);
        assert!(v2.state == 0, 13906838885926109240);
        assert!(v2.balance >= big_blind_at(&arg0.definition, v1), 13906838890221600832);
        assert!(0x2::coin::value<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&arg1) == v2.balance, 13906838894516699202);
        v2.state = 1;
        v2.joined_at_ms = v1;
        let v3 = v2.owner;
        0x2::balance::join<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&mut arg0.escrow, 0x2::coin::into_balance<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg1));
        arg0.queued_count = arg0.queued_count + 1;
        let v4 = bump_event_seq(arg0);
        let v5 = QueueJoined{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            event_seq     : v4,
            agent         : v0,
            owner         : v3,
            balance       : v2.balance,
            joined_at_ms  : v1,
            queued_count  : arg0.queued_count,
            seated_count  : arg0.seated_count,
        };
        0x2::event::emit<QueueJoined>(v5);
    }

    entry fun queue_leave(arg0: &mut Tournament, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, v0), 13906839044840292414);
        let v1 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, v0);
        assert!(v1.state == 1, 13906839053430620228);
        v1.state = 0;
        let v2 = v1.balance;
        0x2::balance::send_funds<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(0x2::balance::split<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&mut arg0.escrow, v2), v0);
        arg0.queued_count = arg0.queued_count - 1;
        let v3 = bump_event_seq(arg0);
        let v4 = QueueLeft{
            tournament_id : 0x2::object::id<Tournament>(arg0),
            event_seq     : v3,
            agent         : v0,
            balance       : v2,
            left_at_ms    : 0x2::clock::timestamp_ms(arg1),
            queued_count  : arg0.queued_count,
            seated_count  : arg0.seated_count,
        };
        0x2::event::emit<QueueLeft>(v4);
    }

    public fun queued_count(arg0: &Tournament) : u64 {
        arg0.queued_count
    }

    fun ranks_above(arg0: &LeaderboardRow, arg1: &LeaderboardRow) : bool {
        if (arg0.balance != arg1.balance) {
            return arg0.balance > arg1.balance
        };
        if (arg0.tickets_redeemed != arg1.tickets_redeemed) {
            return arg0.tickets_redeemed < arg1.tickets_redeemed
        };
        if (arg0.last_settle_ms != arg1.last_settle_ms) {
            if (arg0.last_settle_ms == 0) {
                return false
            };
            if (arg1.last_settle_ms == 0) {
                return true
            };
            return arg0.last_settle_ms < arg1.last_settle_ms
        };
        0x2::address::to_u256(arg0.agent) < 0x2::address::to_u256(arg1.agent)
    }

    entry fun reassign(arg0: &Tournament, arg1: &mut Play, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 13906838331874672686);
        assert!(arg1.tournament == 0x2::object::id<Tournament>(arg0), 13906838336169246760);
        arg1.agent = 0x1::option::some<address>(arg2);
        let v0 = PlayReassigned{
            tournament_id : arg1.tournament,
            play_id       : 0x2::object::id<Play>(arg1),
            owner         : arg1.owner,
            agent         : arg1.agent,
        };
        0x2::event::emit<PlayReassigned>(v0);
    }

    entry fun reclaim(arg0: &Tournament, arg1: &mut EntryPass, arg2: Play, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 13906838203025653806);
        assert!(arg2.owner == arg1.owner, 13906838207320621102);
        assert!(arg2.tournament == arg1.tournament, 13906838211615195176);
        assert!(arg2.tournament == 0x2::object::id<Tournament>(arg0), 13906838215910162472);
        let Play {
            id         : v0,
            tournament : v1,
            owner      : v2,
            index      : _,
            agent      : _,
        } = arg2;
        let v5 = v0;
        0x2::object::delete(v5);
        arg1.plays_left = arg1.plays_left + 1;
        let v6 = PlayDeleted{
            tournament_id : v1,
            play_id       : 0x2::object::uid_to_inner(&v5),
            owner         : v2,
            redeemed      : false,
            plays_left    : 0x1::option::some<u64>(arg1.plays_left),
        };
        0x2::event::emit<PlayDeleted>(v6);
    }

    public fun redeem(arg0: &mut Tournament, arg1: &mut 0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::ChipTreasury, arg2: Play, arg3: 0x2::coin::Coin<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP> {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(in_play_window(&arg0.definition, v1), 13906838555213234226);
        assert!(arg2.tournament == 0x2::object::id<Tournament>(arg0), 13906838559507546152);
        assert!(arg2.agent == 0x1::option::some<address>(v0), 13906838563802775596);
        let v2 = arg2.owner;
        let v3 = 0x1::option::none<u64>();
        if (!0x2::table::contains<address, Entry>(&arg0.entries, v0)) {
            let v4 = Entry{
                owner            : v2,
                balance          : 0,
                state            : 0,
                tickets_redeemed : 0,
                last_settle_ms   : 0,
                joined_at_ms     : 0,
                tunnel           : 0x1::option::none<0x2::object::ID>(),
            };
            0x2::table::add<address, Entry>(&mut arg0.entries, v0, v4);
            0x2::table_vec::push_back<address>(&mut arg0.entry_order, v0);
            v3 = 0x1::option::some<u64>(0x2::table_vec::length<address>(&arg0.entry_order));
        };
        let v5 = arg0.definition.chips_per_ticket;
        let v6 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, v0);
        assert!(v6.owner == v2, 13906838649702383664);
        assert!(v6.state == 0, 13906838653997875256);
        assert!(v6.balance < big_blind_at(&arg0.definition, v1), 13906838658292973626);
        assert!(0x2::coin::value<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&arg3) == v6.balance, 13906838662588071996);
        let v7 = 0x2::coin::value<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&arg3);
        0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::burn(arg1, 0x2::coin::into_balance<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg3));
        let Play {
            id         : v8,
            tournament : v9,
            owner      : v10,
            index      : _,
            agent      : _,
        } = arg2;
        let v13 = v8;
        let v14 = 0x2::object::uid_to_inner(&v13);
        0x2::object::delete(v13);
        v6.balance = v5;
        v6.tickets_redeemed = v6.tickets_redeemed + 1;
        let v15 = v6.tickets_redeemed;
        arg0.burned = arg0.burned + v7;
        arg0.minted = arg0.minted + v5;
        let v16 = bump_event_seq(arg0);
        let v17 = PlayDeleted{
            tournament_id : v9,
            play_id       : v14,
            owner         : v10,
            redeemed      : true,
            plays_left    : 0x1::option::none<u64>(),
        };
        0x2::event::emit<PlayDeleted>(v17);
        let v18 = ChipsRedeemed{
            tournament_id    : 0x2::object::id<Tournament>(arg0),
            event_seq        : v16,
            agent            : v0,
            owner            : v2,
            play_id          : v14,
            burned           : v7,
            minted           : v5,
            balance          : v5,
            tickets_redeemed : v15,
            entry_index      : v3,
            redeemed_at_ms   : v1,
        };
        0x2::event::emit<ChipsRedeemed>(v18);
        0x2::coin::from_balance<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::mint(arg1, v5), arg5)
    }

    entry fun register_eligibility_key(arg0: &TournamentOperatorCap, arg1: &mut Tournament, arg2: u8, arg3: vector<u8>) {
        assert_version(arg1);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg2) && 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg2, &arg3), 13906837575959773220);
        assert!(!0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg3), 13906837584549838886);
        let v0 = EligibilityKey{
            revoked        : false,
            signature_type : arg2,
        };
        0x2::table::add<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg3, v0);
        let v1 = EligibilityKeyChanged{
            tournament_id  : 0x2::object::id<Tournament>(arg1),
            public_key     : arg3,
            revoked        : false,
            signature_type : arg2,
        };
        0x2::event::emit<EligibilityKeyChanged>(v1);
    }

    fun resolution_policy_digest_for(arg0: 0x2::object::ID, arg1: &TournamentDefinition) : vector<u8> {
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&arg0), arg1.dispute_window_ms, arg1.referee_signature_type, &arg1.referee_public_key);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_resolution_policy(&v0)
    }

    entry fun revoke_eligibility_key(arg0: &TournamentOperatorCap, arg1: &mut Tournament, arg2: vector<u8>) {
        assert_version(arg1);
        assert!(0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg2), 13906837657563627548);
        let v0 = 0x2::table::borrow_mut<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg2);
        if (!v0.revoked) {
            v0.revoked = true;
            let v1 = EligibilityKeyChanged{
                tournament_id  : 0x2::object::id<Tournament>(arg1),
                public_key     : arg2,
                revoked        : true,
                signature_type : v0.signature_type,
            };
            0x2::event::emit<EligibilityKeyChanged>(v1);
        };
    }

    public fun row_agent(arg0: &LeaderboardRow) : address {
        arg0.agent
    }

    public fun row_balance(arg0: &LeaderboardRow) : u64 {
        arg0.balance
    }

    public fun row_last_settle_ms(arg0: &LeaderboardRow) : u64 {
        arg0.last_settle_ms
    }

    public fun row_tickets_redeemed(arg0: &LeaderboardRow) : u64 {
        arg0.tickets_redeemed
    }

    public fun seated_count(arg0: &Tournament) : u64 {
        arg0.seated_count
    }

    entry fun set_paused(arg0: &TournamentOperatorCap, arg1: &mut Tournament, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        let v0 = TournamentPauseChanged{
            tournament_id : 0x2::object::id<Tournament>(arg1),
            paused        : arg2,
        };
        0x2::event::emit<TournamentPauseChanged>(v0);
    }

    entry fun settle_from_record(arg0: &mut Tournament, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord) {
        assert_version(arg0);
        assert!(!is_refund_disposition(arg1), 13906839723447484514);
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_tunnel_id(arg1);
        assert!(holds_table(arg0, v0), 13906839732037025884);
        assert_record_binds_table(arg0, arg1, v0);
        book_table(arg0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_tunnel_id(arg1), 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord>(arg1), 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_settled_at_ms(arg1), 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_entitlements(arg1), false);
    }

    public fun settle_refund_from_record(arg0: &mut Tournament, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord, arg2: 0x2::coin::Coin<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.definition.funder, 13906839899539308614);
        assert!(is_refund_disposition(arg1), 13906839903836242020);
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_tunnel_id(arg1);
        assert!(holds_table(arg0, v0), 13906839912425652316);
        assert_record_binds_table(arg0, arg1, v0);
        let v1 = table_record(arg0, v0);
        let v2 = v1.seats;
        let v3 = v1.deposits;
        assert!(0x2::coin::value<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&arg2) == sum(&v3), 13906839933901406314);
        let v4 = 0x2::coin::into_balance<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v2)) {
            0x2::balance::send_funds<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(0x2::balance::split<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(&mut v4, *0x1::vector::borrow<u64>(&v3, v5)), *0x1::vector::borrow<address>(&v2, v5));
            v5 = v5 + 1;
        };
        0x2::balance::destroy_zero<0x5d66f30b511d11e37fc8c5f7e42fde1dae249d85f48d51700e90078ec5469aeb::chip::CHIP>(v4);
        book_table(arg0, v0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::SettledOutcomeRecord>(arg1), 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor::record_settled_at_ms(arg1), v3, true);
    }

    public fun state_idle() : u8 {
        0
    }

    public fun state_queued() : u8 {
        1
    }

    public fun state_seated() : u8 {
        2
    }

    fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun table_record(arg0: &Tournament, arg1: 0x2::object::ID) : &TableRecord {
        if (0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.tables, arg1)) {
            0x2::table::borrow<0x2::object::ID, TableRecord>(&arg0.tables, arg1)
        } else {
            0x2::table::borrow<0x2::object::ID, TableRecord>(&arg0.drained_tables, arg1)
        }
    }

    fun take_table(arg0: &mut Tournament, arg1: 0x2::object::ID) : TableRecord {
        if (0x2::table::contains<0x2::object::ID, TableRecord>(&arg0.tables, arg1)) {
            0x2::table::remove<0x2::object::ID, TableRecord>(&mut arg0.tables, arg1)
        } else {
            0x2::table::remove<0x2::object::ID, TableRecord>(&mut arg0.drained_tables, arg1)
        }
    }

    public fun transfer_operator_cap(arg0: TournamentOperatorCap, arg1: address) {
        0x2::transfer::transfer<TournamentOperatorCap>(arg0, arg1);
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 == arg0 || arg0 > 1 && arg1 == arg0 - 1
    }

    // decompiled from Move bytecode v7
}

