module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Global has copy, drop, store {
        fee_recipient: address,
        change_delay_ms: u64,
        settle_delay_ms: u64,
        lending_market: 0x1::option::Option<0x2::object::ID>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        keeper: address,
        paused: bool,
        global: Global,
        pending: 0x1::option::Option<PendingGlobal>,
    }

    struct PendingGlobal has copy, drop, store {
        global: Global,
        effective_ms: u64,
    }

    struct ConfigCreated has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        keeper: address,
        global: Global,
    }

    struct KeeperChanged has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        keeper: address,
    }

    struct PauseAllChanged has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        paused: bool,
        by: address,
    }

    struct GlobalProposed has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        global: Global,
        effective_ms: u64,
    }

    struct GlobalChanged has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        global: Global,
    }

    struct GlobalCancelled has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        schema: u8,
        config: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    public fun admin_pause_all(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        set_paused(arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun apply(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<PendingGlobal>(&arg0.pending), 4);
        let PendingGlobal {
            global       : v0,
            effective_ms : v1,
        } = 0x1::option::extract<PendingGlobal>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1, 5);
        arg0.global = v0;
        let v2 = GlobalChanged{
            schema : 1,
            config : 0x2::object::id<Config>(arg0),
            global : v0,
        };
        0x2::event::emit<GlobalChanged>(v2);
    }

    public fun assert_buying(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 6);
    }

    public fun assert_keeper(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.keeper, 3);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 2, 1);
    }

    public fun cancel(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        assert!(0x1::option::is_some<PendingGlobal>(&arg1.pending), 4);
        arg1.pending = 0x1::option::none<PendingGlobal>();
        let v0 = GlobalCancelled{
            schema : 1,
            config : 0x2::object::id<Config>(arg1),
        };
        0x2::event::emit<GlobalCancelled>(v0);
    }

    public fun change_delay_ms(arg0: &Config) : u64 {
        arg0.global.change_delay_ms
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.global.fee_recipient
    }

    public fun global(arg0: &Config) : Global {
        arg0.global
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            fee_recipient   : 0x2::tx_context::sender(arg0),
            change_delay_ms : 24 * 3600000,
            settle_delay_ms : 24 * 3600000,
            lending_market  : 0x1::option::none<0x2::object::ID>(),
        };
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            version : 2,
            keeper  : 0x2::tx_context::sender(arg0),
            paused  : false,
            global  : v0,
            pending : 0x1::option::none<PendingGlobal>(),
        };
        let v2 = ConfigCreated{
            schema : 1,
            config : 0x2::object::id<Config>(&v1),
            keeper : v1.keeper,
            global : v0,
        };
        0x2::event::emit<ConfigCreated>(v2);
        0x2::transfer::share_object<Config>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun keeper(arg0: &Config) : address {
        arg0.keeper
    }

    public fun lending_market(arg0: &Config) : 0x1::option::Option<0x2::object::ID> {
        arg0.global.lending_market
    }

    public fun lending_off(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.global.lending_market = 0x1::option::none<0x2::object::ID>();
        let v0 = GlobalChanged{
            schema : 1,
            config : 0x2::object::id<Config>(arg1),
            global : arg1.global,
        };
        0x2::event::emit<GlobalChanged>(v0);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 2, 1);
        let v0 = Migrated{
            schema : 1,
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
            to     : 2,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 2;
    }

    public fun new_global(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>) : Global {
        let v0 = Global{
            fee_recipient   : arg0,
            change_delay_ms : arg1,
            settle_delay_ms : arg2,
            lending_market  : arg3,
        };
        validate(&v0);
        v0
    }

    public fun pause_all(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg1);
        set_paused(arg0, true, 0x2::tx_context::sender(arg1));
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun pending(arg0: &Config) : (bool, Global, u64) {
        if (0x1::option::is_some<PendingGlobal>(&arg0.pending)) {
            let v3 = 0x1::option::borrow<PendingGlobal>(&arg0.pending);
            (true, v3.global, v3.effective_ms)
        } else {
            (false, arg0.global, 0)
        }
    }

    public fun propose(arg0: &AdminCap, arg1: &mut Config, arg2: Global, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        validate(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.global.change_delay_ms;
        let v1 = PendingGlobal{
            global       : arg2,
            effective_ms : v0,
        };
        arg1.pending = 0x1::option::some<PendingGlobal>(v1);
        let v2 = GlobalProposed{
            schema       : 1,
            config       : 0x2::object::id<Config>(arg1),
            global       : arg2,
            effective_ms : v0,
        };
        0x2::event::emit<GlobalProposed>(v2);
    }

    public fun schema() : u8 {
        1
    }

    public fun set_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.keeper = arg2;
        let v0 = KeeperChanged{
            schema : 1,
            config : 0x2::object::id<Config>(arg1),
            keeper : arg2,
        };
        0x2::event::emit<KeeperChanged>(v0);
    }

    fun set_paused(arg0: &mut Config, arg1: bool, arg2: address) {
        arg0.paused = arg1;
        let v0 = PauseAllChanged{
            schema : 1,
            config : 0x2::object::id<Config>(arg0),
            paused : arg1,
            by     : arg2,
        };
        0x2::event::emit<PauseAllChanged>(v0);
    }

    public fun settle_delay_ms(arg0: &Config) : u64 {
        arg0.global.settle_delay_ms
    }

    public fun validate(arg0: &Global) {
        assert!(arg0.fee_recipient != @0x0, 2);
        assert!(arg0.change_delay_ms >= 3600000 && arg0.change_delay_ms <= 1209600000, 2);
        assert!(arg0.settle_delay_ms >= 3600000 && arg0.settle_delay_ms <= 2592000000, 2);
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

