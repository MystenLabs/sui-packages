module 0x5de2cf01feac4de63e94605f74830741d1a8d56efeccf7c9d795e18c4b95c183::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_recipient: address,
        launch_fee: u64,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        creator_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BrakeCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeadKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ShareKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RevokedBrakeKey has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_recipient: address,
        launch_fee: u64,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        creator_bps: u64,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct BrakeCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct CoinMarkedDead has copy, drop {
        coin: 0x1::ascii::String,
        at_ms: u64,
    }

    struct CoinRevived has copy, drop {
        coin: 0x1::ascii::String,
        at_ms: u64,
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 103);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun bps() : u64 {
        10000
    }

    public fun brake(arg0: &BrakeCap, arg1: &mut Config) {
        assert_version(arg1);
        assert!(!is_brake_revoked(arg1, 0x2::object::id<BrakeCap>(arg0)), 104);
        arg1.paused = true;
        let v0 = PauseChanged{paused: true};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun creator_bps(arg0: &Config) : u64 {
        arg0.creator_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg0),
            version        : 1,
            paused         : true,
            fee_recipient  : 0x2::tx_context::sender(arg0),
            launch_fee     : 1000000000,
            mint_fee_bps   : 30,
            redeem_fee_bps : 30,
            creator_bps    : 5000,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_brake_revoked(arg0: &Config, arg1: 0x2::object::ID) : bool {
        let v0 = RevokedBrakeKey{cap_id: arg1};
        0x2::dynamic_field::exists_<RevokedBrakeKey>(&arg0.id, v0)
    }

    public fun is_dead<T0>(arg0: &Config) : bool {
        let v0 = DeadKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<DeadKey<T0>>(&arg0.id, v0)
    }

    public fun is_share<T0>(arg0: &Config) : bool {
        let v0 = ShareKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<ShareKey<T0>>(&arg0.id, v0)
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public fun mark_dead<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(!is_dead<T0>(arg1), 106);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = DeadKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<DeadKey<T0>, u64>(&mut arg1.id, v1, v0);
        let v2 = CoinMarkedDead{
            coin  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            at_ms : v0,
        };
        0x2::event::emit<CoinMarkedDead>(v2);
    }

    public fun max_fee_bps() : u64 {
        100
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 101);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun mint_brake_cap(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = BrakeCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<BrakeCap>(v0, arg2);
    }

    public fun mint_fee_bps(arg0: &Config) : u64 {
        arg0.mint_fee_bps
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun redeem_fee_bps(arg0: &Config) : u64 {
        arg0.redeem_fee_bps
    }

    public(friend) fun register_share<T0>(arg0: &mut Config, arg1: 0x2::object::ID) {
        let v0 = ShareKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ShareKey<T0>, 0x2::object::ID>(&mut arg0.id, v0, arg1);
    }

    public fun revive<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(is_dead<T0>(arg1), 107);
        let v0 = DeadKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<DeadKey<T0>, u64>(&mut arg1.id, v0);
        let v1 = CoinRevived{
            coin  : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            at_ms : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<CoinRevived>(v1);
    }

    public fun revoke_brake_cap(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID) {
        assert_version(arg1);
        assert!(!is_brake_revoked(arg1, arg2), 105);
        let v0 = RevokedBrakeKey{cap_id: arg2};
        0x2::dynamic_field::add<RevokedBrakeKey, bool>(&mut arg1.id, v0, true);
        let v1 = BrakeCapRevoked{cap_id: arg2};
        0x2::event::emit<BrakeCapRevoked>(v1);
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 102);
        assert!(arg3 <= 100000000000, 102);
        assert!(arg4 <= 100 && arg5 <= 100, 102);
        assert!(arg6 >= 5000 && arg6 <= 10000, 102);
        arg1.fee_recipient = arg2;
        arg1.launch_fee = arg3;
        arg1.mint_fee_bps = arg4;
        arg1.redeem_fee_bps = arg5;
        arg1.creator_bps = arg6;
        let v0 = ParamsChanged{
            fee_recipient  : arg2,
            launch_fee     : arg3,
            mint_fee_bps   : arg4,
            redeem_fee_bps : arg5,
            creator_bps    : arg6,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

