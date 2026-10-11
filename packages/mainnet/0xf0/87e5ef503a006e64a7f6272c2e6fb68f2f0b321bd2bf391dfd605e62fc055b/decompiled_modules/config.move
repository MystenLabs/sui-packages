module 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        launch_fee: u64,
        graduation_fee_bps: u64,
        initial_virtual_sui: u64,
        initial_virtual_tokens: u64,
        curve_supply: u64,
        router_fee_bps: u64,
        tick_spacing: u32,
        fee_recipient: address,
    }

    struct ConfigUpdated has copy, drop {
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        launch_fee: u64,
        graduation_fee_bps: u64,
        initial_virtual_sui: u64,
        initial_virtual_tokens: u64,
        curve_supply: u64,
        router_fee_bps: u64,
        tick_spacing: u32,
        fee_recipient: address,
        paused: bool,
    }

    public(friend) fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 2);
    }

    public(friend) fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun bps() : u64 {
        10000
    }

    public fun creator_fee_bps(arg0: &Config) : u64 {
        arg0.creator_fee_bps
    }

    public fun curve_supply(arg0: &Config) : u64 {
        arg0.curve_supply
    }

    public fun decimals() : u8 {
        6
    }

    fun default_config(arg0: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            paused                 : false,
            trade_fee_bps          : 100,
            creator_fee_bps        : 50,
            launch_fee             : 1000000000,
            graduation_fee_bps     : 500,
            initial_virtual_sui    : 1500000000000,
            initial_virtual_tokens : 1073000000000000,
            curve_supply           : 793100000000000,
            router_fee_bps         : 50,
            tick_spacing           : 60,
            fee_recipient          : 0x2::tx_context::sender(arg0),
        }
    }

    fun emit_updated(arg0: &Config) {
        let v0 = ConfigUpdated{
            trade_fee_bps          : arg0.trade_fee_bps,
            creator_fee_bps        : arg0.creator_fee_bps,
            launch_fee             : arg0.launch_fee,
            graduation_fee_bps     : arg0.graduation_fee_bps,
            initial_virtual_sui    : arg0.initial_virtual_sui,
            initial_virtual_tokens : arg0.initial_virtual_tokens,
            curve_supply           : arg0.curve_supply,
            router_fee_bps         : arg0.router_fee_bps,
            tick_spacing           : arg0.tick_spacing,
            fee_recipient          : arg0.fee_recipient,
            paused                 : arg0.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun graduation_fee_bps(arg0: &Config) : u64 {
        arg0.graduation_fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = default_config(arg0);
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initial_virtual_sui(arg0: &Config) : u64 {
        arg0.initial_virtual_sui
    }

    public fun initial_virtual_tokens(arg0: &Config) : u64 {
        arg0.initial_virtual_tokens
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun router_fee_bps(arg0: &Config) : u64 {
        arg0.router_fee_bps
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        emit_updated(arg1);
    }

    public fun tick_spacing(arg0: &Config) : u32 {
        arg0.tick_spacing
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun trade_fee_bps(arg0: &Config) : u64 {
        arg0.trade_fee_bps
    }

    public fun update(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u32, arg11: address) {
        assert_version(arg1);
        assert!(arg2 <= 200, 1);
        assert!(arg3 <= arg2, 1);
        assert!(arg5 <= 1000, 1);
        assert!(arg6 > 0, 1);
        assert!(arg8 > 0 && arg8 < 1000000000000000, 1);
        assert!(arg7 > arg8, 1);
        assert!(arg9 <= 200, 1);
        assert!(arg10 > 0, 1);
        arg1.trade_fee_bps = arg2;
        arg1.creator_fee_bps = arg3;
        arg1.launch_fee = arg4;
        arg1.graduation_fee_bps = arg5;
        arg1.initial_virtual_sui = arg6;
        arg1.initial_virtual_tokens = arg7;
        arg1.curve_supply = arg8;
        arg1.router_fee_bps = arg9;
        arg1.tick_spacing = arg10;
        arg1.fee_recipient = arg11;
        emit_updated(arg1);
    }

    // decompiled from Move bytecode v7
}

