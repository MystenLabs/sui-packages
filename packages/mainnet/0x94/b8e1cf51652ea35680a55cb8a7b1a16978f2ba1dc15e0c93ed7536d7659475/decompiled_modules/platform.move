module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Queued has copy, drop, store {
        ready_ms: u64,
        treasury: address,
        fee_bps: u16,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        fee_bps: u16,
        queued: 0x1::option::Option<Queued>,
        paused: bool,
        version: u64,
    }

    public fun apply(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Queued>(&arg0.queued), 104);
        let Queued {
            ready_ms : v0,
            treasury : v1,
            fee_bps  : v2,
        } = 0x1::option::extract<Queued>(&mut arg0.queued);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0, 105);
        arg0.treasury = v1;
        arg0.fee_bps = v2;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::config_applied(0x2::object::id<Config>(arg0), v1, v2);
    }

    public(friend) fun assert_object(arg0: u64) {
        assert!(arg0 <= 1, 102);
    }

    public(friend) fun assert_open(arg0: &Config) {
        assert!(arg0.version == 1, 102);
        assert!(!arg0.paused, 101);
    }

    public(friend) fun current() : u64 {
        1
    }

    public fun delay_ms() : u64 {
        172800000
    }

    public fun discard(arg0: &AdminCap, arg1: &mut Config) {
        assert!(0x1::option::is_some<Queued>(&arg1.queued), 104);
        arg1.queued = 0x1::option::none<Queued>();
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::config_discarded(0x2::object::id<Config>(arg1));
    }

    public fun fee_bps(arg0: &Config) : u16 {
        arg0.fee_bps
    }

    public fun fee_ceiling_bps() : u16 {
        500
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::tx_context::sender(arg0),
            fee_bps  : 10,
            queued   : 0x1::option::none<Queued>(),
            paused   : false,
            version  : 1,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 106);
        arg1.version = 1;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::config_migrated(0x2::object::id<Config>(arg1), 1);
    }

    public fun portion(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun queue(arg0: &AdminCap, arg1: &mut Config, arg2: u16, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 102);
        assert!(arg2 <= 500, 103);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 172800000;
        let v1 = Queued{
            ready_ms : v0,
            treasury : arg3,
            fee_bps  : arg2,
        };
        arg1.queued = 0x1::option::some<Queued>(v1);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::config_queued(0x2::object::id<Config>(arg1), v0, arg3, arg2);
    }

    public fun queued_ready_ms(arg0: &Config) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<Queued>(&arg0.queued)) {
            0x1::option::some<u64>(0x1::option::borrow<Queued>(&arg0.queued).ready_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::config_paused(0x2::object::id<Config>(arg1), arg2);
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

