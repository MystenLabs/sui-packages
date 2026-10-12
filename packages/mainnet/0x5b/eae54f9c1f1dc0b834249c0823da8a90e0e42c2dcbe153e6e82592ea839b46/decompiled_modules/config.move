module 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_bps: u64,
        fee_recipient: address,
        keepers: vector<address>,
        reporters: vector<vector<u8>>,
        require_quote: bool,
        quote_slack_bps: u64,
    }

    struct Quote has copy, drop, store {
        quoted: bool,
        out: u64,
        peak_out: u64,
        slack_bps: u64,
    }

    struct FeeChanged has copy, drop {
        config: 0x2::object::ID,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct PauseChanged has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct KeeperChanged has copy, drop {
        config: 0x2::object::ID,
        keeper: address,
        added: bool,
    }

    struct ReporterChanged has copy, drop {
        config: 0x2::object::ID,
        reporter: vector<u8>,
        added: bool,
    }

    struct QuoteRuleChanged has copy, drop {
        config: 0x2::object::ID,
        require_quote: bool,
        quote_slack_bps: u64,
    }

    struct Migrated has copy, drop {
        config: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct Halted has copy, drop {
        config: 0x2::object::ID,
        from: u64,
    }

    public fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    public fun add_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        owns(arg0, arg1);
        assert_version(arg1);
        assert!(!0x1::vector::contains<address>(&arg1.keepers, &arg2), 5);
        assert!(0x1::vector::length<address>(&arg1.keepers) < 16, 15);
        0x1::vector::push_back<address>(&mut arg1.keepers, arg2);
        let v0 = KeeperChanged{
            config : 0x2::object::id<Config>(arg1),
            keeper : arg2,
            added  : true,
        };
        0x2::event::emit<KeeperChanged>(v0);
    }

    public fun add_reporter(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        owns(arg0, arg1);
        assert_version(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9);
        assert!(!0x1::vector::contains<vector<u8>>(&arg1.reporters, &arg2), 7);
        assert!(0x1::vector::length<vector<u8>>(&arg1.reporters) < 8, 15);
        0x1::vector::push_back<vector<u8>>(&mut arg1.reporters, arg2);
        let v0 = ReporterChanged{
            config   : 0x2::object::id<Config>(arg1),
            reporter : arg2,
            added    : true,
        };
        0x2::event::emit<ReporterChanged>(v0);
    }

    public fun assert_keeper(arg0: &Config, arg1: address) {
        assert!(arg1 == @0x0 || 0x1::vector::contains<address>(&arg0.keepers, &arg1), 11);
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun check_quote(arg0: &Config, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : Quote {
        assert_version(arg0);
        if (!arg0.require_quote || 0x2::tx_context::sender(arg10) == @0x0) {
            return Quote{
                quoted    : false,
                out       : 0,
                peak_out  : 0,
                slack_bps : 0,
            }
        };
        assert!(arg4 > 0, 12);
        assert!(0x1::vector::contains<vector<u8>>(&arg0.reporters, &arg7), 8);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg6 <= v0 + 10000 && v0 <= arg6 + 60000, 13);
        let v1 = quote_message(arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg7, &v1), 14);
        Quote{
            quoted    : true,
            out       : arg4,
            peak_out  : arg5,
            slack_bps : arg0.quote_slack_bps,
        }
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_for(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun halt(arg0: &AdminCap, arg1: &mut Config) {
        owns(arg0, arg1);
        let v0 = Halted{
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
        };
        0x2::event::emit<Halted>(v0);
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id              : 0x2::object::new(arg0),
            version         : 1,
            paused          : false,
            fee_bps         : 0,
            fee_recipient   : 0x2::tx_context::sender(arg0),
            keepers         : vector[],
            reporters       : vector[],
            require_quote   : true,
            quote_slack_bps : 300,
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            config : 0x2::object::id<Config>(&v0),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper(arg0: &Config, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_probe(arg0: address) : bool {
        arg0 == @0x0
    }

    public fun is_reporter(arg0: &Config, arg1: &vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.reporters, arg1)
    }

    public fun keepers(arg0: &Config) : vector<address> {
        arg0.keepers
    }

    public fun max_fee_bps() : u64 {
        100
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        owns(arg0, arg1);
        assert!(arg1.version < 1, 1);
        let v0 = Migrated{
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    fun owns(arg0: &AdminCap, arg1: &Config) {
        assert!(arg0.config == 0x2::object::id<Config>(arg1), 16);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun quote_max_age_ms() : u64 {
        60000
    }

    public fun quote_message(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = b"PPX_ORDERS_QUOTE_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        v0
    }

    public fun quote_out(arg0: &Quote) : u64 {
        arg0.out
    }

    public fun quote_peak_out(arg0: &Quote) : u64 {
        arg0.peak_out
    }

    public fun quote_slack(arg0: &Quote) : u64 {
        arg0.slack_bps
    }

    public fun quote_slack_bps(arg0: &Config) : u64 {
        arg0.quote_slack_bps
    }

    public fun quoted(arg0: &Quote) : bool {
        arg0.quoted
    }

    public fun remove_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        owns(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.keepers, &arg2);
        assert!(v0, 6);
        0x1::vector::remove<address>(&mut arg1.keepers, v1);
        let v2 = KeeperChanged{
            config : 0x2::object::id<Config>(arg1),
            keeper : arg2,
            added  : false,
        };
        0x2::event::emit<KeeperChanged>(v2);
    }

    public fun remove_reporter(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        owns(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg1.reporters, &arg2);
        assert!(v0, 8);
        0x1::vector::remove<vector<u8>>(&mut arg1.reporters, v1);
        let v2 = ReporterChanged{
            config   : 0x2::object::id<Config>(arg1),
            reporter : arg2,
            added    : false,
        };
        0x2::event::emit<ReporterChanged>(v2);
    }

    public fun reporters(arg0: &Config) : vector<vector<u8>> {
        arg0.reporters
    }

    public fun require_quote(arg0: &Config) : bool {
        arg0.require_quote
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        owns(arg0, arg1);
        assert_version(arg1);
        assert!(arg2 <= 100, 3);
        arg1.fee_bps = arg2;
        let v0 = FeeChanged{
            config        : 0x2::object::id<Config>(arg1),
            fee_bps       : arg2,
            fee_recipient : arg1.fee_recipient,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        owns(arg0, arg1);
        assert_version(arg1);
        assert!(arg2 != @0x0, 4);
        arg1.fee_recipient = arg2;
        let v0 = FeeChanged{
            config        : 0x2::object::id<Config>(arg1),
            fee_bps       : arg1.fee_bps,
            fee_recipient : arg2,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        owns(arg0, arg1);
        assert_version(arg1);
        arg1.paused = arg2;
        let v0 = PauseChanged{
            config : 0x2::object::id<Config>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_quote_rule(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: u64) {
        owns(arg0, arg1);
        assert_version(arg1);
        assert!(arg3 <= 1000, 10);
        arg1.require_quote = arg2;
        arg1.quote_slack_bps = arg3;
        let v0 = QuoteRuleChanged{
            config          : 0x2::object::id<Config>(arg1),
            require_quote   : arg2,
            quote_slack_bps : arg3,
        };
        0x2::event::emit<QuoteRuleChanged>(v0);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

