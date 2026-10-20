module 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena {
    struct RecordsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RecordsRegistry has key {
        id: 0x2::object::UID,
    }

    struct ArenaKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordKey<phantom T0> has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
    }

    struct Arena<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        ruleset_hash: vector<u8>,
        settle_window_ms: u64,
        verifiers: 0x2::vec_set::VecSet<0x2::object::ID>,
        matchmaker_key: 0x1::option::Option<vector<u8>>,
    }

    struct CharacterRecord<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        character_id: 0x2::object::ID,
        attacks: u64,
        wins: u64,
        draws: u64,
        losses: u64,
        defenses: u64,
        defenses_won: u64,
        points: u64,
        last_challenge_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ArenaCreated has copy, drop {
        arena_id: 0x2::object::ID,
        ruleset_hash: vector<u8>,
        settle_window_ms: u64,
    }

    struct VerifierIssued has copy, drop {
        arena_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct VerifierRevoked has copy, drop {
        arena_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct ArenaUpdated has copy, drop {
        arena_id: 0x2::object::ID,
        paused: bool,
        ruleset_hash: vector<u8>,
        settle_window_ms: u64,
    }

    struct RecordOpened has copy, drop {
        record_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
    }

    struct MatchmakerKeySet has copy, drop {
        arena_id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    public(friend) fun assert_accepting_challenges<T0>(arg0: &Arena<T0>) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 13906835772071870475);
    }

    fun assert_record_version<T0>(arg0: &CharacterRecord<T0>) {
        assert!(arg0.version == 1, 13906836051244613641);
    }

    fun assert_ruleset(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906836068424876047);
    }

    fun assert_settle_window(arg0: u64) {
        assert!(arg0 >= 600000 && arg0 <= 604800000, 13906836210158927889);
    }

    public(friend) fun assert_ticket<T0>(arg0: &Arena<T0>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.matchmaker_key), 13906835815022854175);
        assert!(0x2::ed25519::ed25519_verify(arg2, 0x1::option::borrow<vector<u8>>(&arg0.matchmaker_key), arg1), 13906835827907887137);
    }

    public(friend) fun assert_verifier<T0>(arg0: &Arena<T0>, arg1: &VerifierCap) {
        assert_version<T0>(arg0);
        let v0 = 0x2::object::id<VerifierCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &v0), 13906835857971347469);
    }

    fun assert_version<T0>(arg0: &Arena<T0>) {
        assert!(arg0.version == 1, 13906836034064744457);
    }

    public fun attacks<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.attacks
    }

    public fun create_arena<T0>(arg0: &mut RecordsRegistry, arg1: &RecordsAdminCap, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_ruleset(&arg2);
        assert_settle_window(arg3);
        let v0 = ArenaKey<T0>{dummy_field: false};
        let v1 = Arena<T0>{
            id               : 0x2::derived_object::claim<ArenaKey<T0>>(&mut arg0.id, v0),
            version          : 1,
            paused           : false,
            ruleset_hash     : arg2,
            settle_window_ms : arg3,
            verifiers        : 0x2::vec_set::empty<0x2::object::ID>(),
            matchmaker_key   : 0x1::option::none<vector<u8>>(),
        };
        let v2 = ArenaCreated{
            arena_id         : 0x2::object::id<Arena<T0>>(&v1),
            ruleset_hash     : arg2,
            settle_window_ms : arg3,
        };
        0x2::event::emit<ArenaCreated>(v2);
        0x2::transfer::share_object<Arena<T0>>(v1);
    }

    public fun defenses<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.defenses
    }

    public fun defenses_won<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.defenses_won
    }

    public fun draws<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.draws
    }

    fun emit_updated<T0>(arg0: &Arena<T0>) {
        let v0 = ArenaUpdated{
            arena_id         : 0x2::object::id<Arena<T0>>(arg0),
            paused           : arg0.paused,
            ruleset_hash     : arg0.ruleset_hash,
            settle_window_ms : arg0.settle_window_ms,
        };
        0x2::event::emit<ArenaUpdated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecordsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RecordsAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RecordsRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RecordsRegistry>(v1);
    }

    public fun is_paused<T0>(arg0: &Arena<T0>) : bool {
        arg0.paused
    }

    fun is_small_order_ed25519_key(arg0: &vector<u8>) : bool {
        let v0 = vector[x"0100000000000000000000000000000000000000000000000000000000000000", x"ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"0000000000000000000000000000000000000000000000000000000000000000", x"0000000000000000000000000000000000000000000000000000000000000080", x"26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc05", x"26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc85", x"c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac037a", x"c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac03fa", x"0100000000000000000000000000000000000000000000000000000000000080", x"ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", x"edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", x"eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"];
        0x1::vector::contains<vector<u8>>(&v0, arg0)
    }

    public fun is_verifier<T0>(arg0: &Arena<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg1)
    }

    public fun issue_verifier_cap<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : VerifierCap {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.verifiers) < 8, 13906835024748216341);
        let v0 = VerifierCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<VerifierCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.verifiers, v1);
        let v2 = VerifierIssued{
            arena_id : 0x2::object::id<Arena<T0>>(arg0),
            cap_id   : v1,
        };
        0x2::event::emit<VerifierIssued>(v2);
        v0
    }

    public fun last_challenge_id<T0>(arg0: &CharacterRecord<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.last_challenge_id
    }

    public fun losses<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.losses
    }

    public fun matchmaker_key<T0>(arg0: &Arena<T0>) : 0x1::option::Option<vector<u8>> {
        arg0.matchmaker_key
    }

    public fun migrate<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap) {
        assert!(arg0.version < 1, 13906835321101221913);
        arg0.version = 1;
    }

    public fun migrate_record<T0>(arg0: &mut CharacterRecord<T0>) {
        assert!(arg0.version < 1, 13906835449950240793);
        arg0.version = 1;
    }

    public(friend) fun new_record<T0>(arg0: &mut RecordsRegistry, arg1: 0x2::object::ID) : CharacterRecord<T0> {
        let v0 = RecordKey<T0>{pos0: arg1};
        CharacterRecord<T0>{
            id                : 0x2::derived_object::claim<RecordKey<T0>>(&mut arg0.id, v0),
            version           : 1,
            character_id      : arg1,
            attacks           : 0,
            wins              : 0,
            draws             : 0,
            losses            : 0,
            defenses          : 0,
            defenses_won      : 0,
            points            : 0,
            last_challenge_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun open_record<T0>(arg0: &mut RecordsRegistry, arg1: &0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item_with_type<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg1, arg2), 13906835402705207315);
        let v0 = new_record<T0>(arg0, arg2);
        share_record<T0>(v0);
        0x2::object::id<CharacterRecord<T0>>(&v0)
    }

    public fun points<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.points
    }

    public fun record_address<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = RecordKey<T0>{pos0: arg1};
        0x2::derived_object::derive_address<RecordKey<T0>>(arg0, v0)
    }

    public(friend) fun record_attack<T0>(arg0: &mut CharacterRecord<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        assert_record_version<T0>(arg0);
        if (arg2 == 0) {
            arg0.wins = arg0.wins + 1;
        } else if (arg2 == 1) {
            arg0.draws = arg0.draws + 1;
        } else {
            assert!(arg2 == 2, 13906835922396512279);
            arg0.losses = arg0.losses + 1;
        };
        arg0.attacks = arg0.attacks + 1;
        arg0.points = arg0.points + arg3;
        arg0.last_challenge_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun record_character_id<T0>(arg0: &CharacterRecord<T0>) : 0x2::object::ID {
        arg0.character_id
    }

    public(friend) fun record_defense<T0>(arg0: &mut CharacterRecord<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        assert_record_version<T0>(arg0);
        assert!(arg2 <= 2, 13906835986821021719);
        if (arg2 == 2) {
            arg0.defenses_won = arg0.defenses_won + 1;
        };
        arg0.defenses = arg0.defenses + 1;
        arg0.points = arg0.points + arg3;
        arg0.last_challenge_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun revoke_verifier_cap<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: 0x2::object::ID) {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg2), 13906835084877234189);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.verifiers, &arg2);
        let v0 = VerifierRevoked{
            arena_id : 0x2::object::id<Arena<T0>>(arg0),
            cap_id   : arg2,
        };
        0x2::event::emit<VerifierRevoked>(v0);
    }

    public fun ruleset_hash<T0>(arg0: &Arena<T0>) : vector<u8> {
        arg0.ruleset_hash
    }

    public fun set_matchmaker_key<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: vector<u8>) {
        assert_version<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835273856712731);
        assert!(!is_small_order_ed25519_key(&arg2), 13906835278151811101);
        arg0.matchmaker_key = 0x1::option::some<vector<u8>>(arg2);
        let v0 = MatchmakerKeySet{
            arena_id   : 0x2::object::id<Arena<T0>>(arg0),
            public_key : arg2,
        };
        0x2::event::emit<MatchmakerKeySet>(v0);
    }

    public fun set_paused<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        arg0.paused = arg2;
        emit_updated<T0>(arg0);
    }

    public fun set_ruleset<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: vector<u8>) {
        assert_version<T0>(arg0);
        assert_ruleset(&arg2);
        arg0.ruleset_hash = arg2;
        emit_updated<T0>(arg0);
    }

    public fun set_settle_window<T0>(arg0: &mut Arena<T0>, arg1: &RecordsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_settle_window(arg2);
        arg0.settle_window_ms = arg2;
        emit_updated<T0>(arg0);
    }

    public fun settle_window_ms<T0>(arg0: &Arena<T0>) : u64 {
        arg0.settle_window_ms
    }

    public(friend) fun share_record<T0>(arg0: CharacterRecord<T0>) {
        let v0 = RecordOpened{
            record_id    : 0x2::object::id<CharacterRecord<T0>>(&arg0),
            character_id : arg0.character_id,
        };
        0x2::event::emit<RecordOpened>(v0);
        0x2::transfer::share_object<CharacterRecord<T0>>(arg0);
    }

    public fun wins<T0>(arg0: &CharacterRecord<T0>) : u64 {
        arg0.wins
    }

    // decompiled from Move bytecode v7
}

