module 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config {
    struct RoomsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoomVerifierCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoomConfig<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        tiers: vector<u64>,
        rake_bps: u64,
        house: address,
        leg_window_ms: u64,
        settle_grace_ms: u64,
        open_expiry_ms: u64,
        pair_daily_limit: u64,
        verifiers: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PairKey has copy, drop, store {
        pos0: address,
        pos1: address,
    }

    struct PairCount has drop, store {
        day: u64,
        count: u64,
    }

    struct RoomConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        tiers: vector<u64>,
        rake_bps: u64,
        house: address,
        leg_window_ms: u64,
        settle_grace_ms: u64,
        open_expiry_ms: u64,
        pair_daily_limit: u64,
    }

    struct RoomConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        field: vector<u8>,
    }

    struct RoomVerifierIssued has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct RoomVerifierRevoked has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public(friend) fun assert_accepting_rooms<T0>(arg0: &RoomConfig<T0>) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 13906835935281020945);
    }

    fun assert_house(arg0: address) {
        assert!(arg0 != @0x0, 13906836257403961367);
    }

    fun assert_leg_window_ms(arg0: u64) {
        assert!(arg0 >= 300000 && arg0 <= 86400000, 13906836283173896217);
    }

    fun assert_open_expiry_ms(arg0: u64) {
        assert!(arg0 >= 600000 && arg0 <= 604800000, 13906836343303438361);
    }

    fun assert_pair_daily_limit(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 20, 13906836373368209433);
    }

    public(friend) fun assert_pair_room_allowed<T0>(arg0: &RoomConfig<T0>, arg1: address, arg2: address, arg3: u64) {
        assert!(pair_count_on<T0>(arg0, pair_key(arg1, arg2), arg3 / 86400000) < arg0.pair_daily_limit, 13906836008296513569);
    }

    fun assert_rake_bps(arg0: u64) {
        assert!(arg0 <= 1000, 13906836240223961109);
    }

    fun assert_settle_grace_ms(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 3600000, 13906836313238667289);
    }

    fun assert_tiers(arg0: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0 && v0 <= 8, 13906836197274157075);
        assert!(*0x1::vector::borrow<u64>(arg0, 0) > 0 && *0x1::vector::borrow<u64>(arg0, v0 - 1) <= 4611686018427387904, 13906836201569124371);
        let v1 = 1;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(arg0, v1) > *0x1::vector::borrow<u64>(arg0, v1 - 1), 13906836214454026259);
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_verifier<T0>(arg0: &RoomConfig<T0>, arg1: &RoomVerifierCap) {
        let v0 = 0x2::object::id<RoomVerifierCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &v0), 13906835956756643869);
    }

    public(friend) fun assert_version<T0>(arg0: &RoomConfig<T0>) {
        assert!(arg0.version == 1, 13906835909510955021);
    }

    public fun create_config<T0>(arg0: &RoomsAdminCap, arg1: vector<u64>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_tiers(&arg1);
        assert_rake_bps(arg2);
        assert_house(arg3);
        assert_leg_window_ms(arg4);
        assert_settle_grace_ms(arg5);
        assert_open_expiry_ms(arg6);
        assert_pair_daily_limit(arg7);
        let v0 = RoomConfig<T0>{
            id               : 0x2::object::new(arg8),
            version          : 1,
            paused           : false,
            tiers            : arg1,
            rake_bps         : arg2,
            house            : arg3,
            leg_window_ms    : arg4,
            settle_grace_ms  : arg5,
            open_expiry_ms   : arg6,
            pair_daily_limit : arg7,
            verifiers        : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v1 = 0x2::object::id<RoomConfig<T0>>(&v0);
        let v2 = RoomConfigCreated{
            config_id        : v1,
            tiers            : arg1,
            rake_bps         : arg2,
            house            : arg3,
            leg_window_ms    : arg4,
            settle_grace_ms  : arg5,
            open_expiry_ms   : arg6,
            pair_daily_limit : arg7,
        };
        0x2::event::emit<RoomConfigCreated>(v2);
        0x2::transfer::share_object<RoomConfig<T0>>(v0);
        v1
    }

    fun emit_updated<T0>(arg0: &RoomConfig<T0>, arg1: vector<u8>) {
        let v0 = RoomConfigUpdated{
            config_id : 0x2::object::id<RoomConfig<T0>>(arg0),
            field     : arg1,
        };
        0x2::event::emit<RoomConfigUpdated>(v0);
    }

    public fun house<T0>(arg0: &RoomConfig<T0>) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoomsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RoomsAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &RoomConfig<T0>) : bool {
        arg0.paused
    }

    public fun is_tier<T0>(arg0: &RoomConfig<T0>, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.tiers, &arg1)
    }

    public fun is_verifier<T0>(arg0: &RoomConfig<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg1)
    }

    public fun issue_verifier_cap<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : RoomVerifierCap {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.verifiers) < 4, 13906835540144947231);
        let v0 = RoomVerifierCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<RoomVerifierCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.verifiers, v1);
        let v2 = RoomVerifierIssued{
            config_id : 0x2::object::id<RoomConfig<T0>>(arg0),
            cap_id    : v1,
        };
        0x2::event::emit<RoomVerifierIssued>(v2);
        v0
    }

    public fun leg_window_ms<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.leg_window_ms
    }

    public fun migrate<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap) {
        assert!(arg0.version < 1, 13906835638928146447);
        arg0.version = 1;
        emit_updated<T0>(arg0, b"version");
    }

    public fun open_expiry_ms<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.open_expiry_ms
    }

    fun pair_count_on<T0>(arg0: &RoomConfig<T0>, arg1: PairKey, arg2: u64) : u64 {
        if (!0x2::dynamic_field::exists<PairKey>(&arg0.id, arg1)) {
            return 0
        };
        let v0 = 0x2::dynamic_field::borrow<PairKey, PairCount>(&arg0.id, arg1);
        if (v0.day == arg2) {
            v0.count
        } else {
            0
        }
    }

    public fun pair_daily_limit<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.pair_daily_limit
    }

    fun pair_key(arg0: address, arg1: address) : PairKey {
        if (0x2::address::to_u256(arg0) <= 0x2::address::to_u256(arg1)) {
            PairKey{pos0: arg0, pos1: arg1}
        } else {
            PairKey{pos0: arg1, pos1: arg0}
        }
    }

    public fun pair_rooms_today<T0>(arg0: &RoomConfig<T0>, arg1: address, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        pair_count_on<T0>(arg0, pair_key(arg1, arg2), 0x2::clock::timestamp_ms(arg3) / 86400000)
    }

    public fun prune_pair_count<T0>(arg0: &mut RoomConfig<T0>, arg1: address, arg2: address, arg3: &0x2::clock::Clock) : bool {
        assert_version<T0>(arg0);
        let v0 = pair_key(arg1, arg2);
        let v1 = 0x2::dynamic_field::exists<PairKey>(&arg0.id, v0) && 0x2::dynamic_field::borrow<PairKey, PairCount>(&arg0.id, v0).day < 0x2::clock::timestamp_ms(arg3) / 86400000;
        if (v1) {
            0x2::dynamic_field::remove<PairKey, PairCount>(&mut arg0.id, v0);
        };
        v1
    }

    public fun rake_bps<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.rake_bps
    }

    public(friend) fun record_pair_room<T0>(arg0: &mut RoomConfig<T0>, arg1: address, arg2: address, arg3: u64) {
        let v0 = pair_key(arg1, arg2);
        let v1 = arg3 / 86400000;
        if (!0x2::dynamic_field::exists<PairKey>(&arg0.id, v0)) {
            let v2 = PairCount{
                day   : v1,
                count : 1,
            };
            0x2::dynamic_field::add<PairKey, PairCount>(&mut arg0.id, v0, v2);
            return
        };
        let v3 = 0x2::dynamic_field::borrow_mut<PairKey, PairCount>(&mut arg0.id, v0);
        if (v3.day == v1) {
            v3.count = v3.count + 1;
        } else {
            v3.day = v1;
            v3.count = 1;
        };
    }

    public fun revoke_verifier_cap<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: 0x2::object::ID) {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg2), 13906835600274358301);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.verifiers, &arg2);
        let v0 = RoomVerifierRevoked{
            config_id : 0x2::object::id<RoomConfig<T0>>(arg0),
            cap_id    : arg2,
        };
        0x2::event::emit<RoomVerifierRevoked>(v0);
    }

    public fun set_house<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: address) {
        assert_version<T0>(arg0);
        assert_house(arg2);
        assert!(arg2 != arg0.house, 13906835200842268699);
        arg0.house = arg2;
        emit_updated<T0>(arg0, b"house");
    }

    public fun set_leg_window_ms<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_leg_window_ms(arg2);
        assert!(arg2 != arg0.leg_window_ms, 13906835260971810843);
        arg0.leg_window_ms = arg2;
        emit_updated<T0>(arg0, b"leg_window_ms");
    }

    public fun set_open_expiry_ms<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_open_expiry_ms(arg2);
        assert!(arg2 != arg0.open_expiry_ms, 13906835381230895131);
        arg0.open_expiry_ms = arg2;
        emit_updated<T0>(arg0, b"open_expiry_ms");
    }

    public fun set_pair_daily_limit<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_pair_daily_limit(arg2);
        assert!(arg2 != arg0.pair_daily_limit, 13906835441360437275);
        arg0.pair_daily_limit = arg2;
        emit_updated<T0>(arg0, b"pair_daily_limit");
    }

    public fun set_paused<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert!(arg2 != arg0.paused, 13906835480015142939);
        arg0.paused = arg2;
        emit_updated<T0>(arg0, b"paused");
    }

    public fun set_rake_bps<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_rake_bps(arg2);
        assert!(arg2 != arg0.rake_bps, 13906835157892595739);
        arg0.rake_bps = arg2;
        emit_updated<T0>(arg0, b"rake_bps");
    }

    public fun set_settle_grace_ms<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_settle_grace_ms(arg2);
        assert!(arg2 != arg0.settle_grace_ms, 13906835321101352987);
        arg0.settle_grace_ms = arg2;
        emit_updated<T0>(arg0, b"settle_grace_ms");
    }

    public fun set_tiers<T0>(arg0: &mut RoomConfig<T0>, arg1: &RoomsAdminCap, arg2: vector<u64>) {
        assert_version<T0>(arg0);
        assert_tiers(&arg2);
        assert!(arg2 != arg0.tiers, 13906835114942922779);
        arg0.tiers = arg2;
        emit_updated<T0>(arg0, b"tiers");
    }

    public fun settle_grace_ms<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.settle_grace_ms
    }

    public fun tiers<T0>(arg0: &RoomConfig<T0>) : vector<u64> {
        arg0.tiers
    }

    public fun verifier_count<T0>(arg0: &RoomConfig<T0>) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.verifiers)
    }

    public fun version<T0>(arg0: &RoomConfig<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

