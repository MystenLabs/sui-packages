module 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        virtual_sui_reserve: u64,
        initial_token_reserve: u64,
        lp_token_reserve: u64,
        graduation_sui_threshold: u64,
        creation_fee_mist: u64,
        trade_fee_bps: u64,
        creator_fee_pct: u64,
        protocol_fee_pct: u64,
        lp_fee_pct: u64,
        treasury: address,
        launch_paused: bool,
    }

    public fun creation_fee_mist(arg0: &LaunchpadConfig) : u64 {
        arg0.creation_fee_mist
    }

    public fun creator_fee_pct(arg0: &LaunchpadConfig) : u64 {
        arg0.creator_fee_pct
    }

    public fun graduation_sui_threshold(arg0: &LaunchpadConfig) : u64 {
        arg0.graduation_sui_threshold
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LaunchpadConfig{
            id                       : 0x2::object::new(arg0),
            virtual_sui_reserve      : 1000000000000,
            initial_token_reserve    : 800000000000000,
            lp_token_reserve         : 200000000000000,
            graduation_sui_threshold : 3000000000000,
            creation_fee_mist        : 0,
            trade_fee_bps            : 100,
            creator_fee_pct          : 40,
            protocol_fee_pct         : 50,
            lp_fee_pct               : 10,
            treasury                 : 0x2::tx_context::sender(arg0),
            launch_paused            : false,
        };
        0x2::transfer::share_object<LaunchpadConfig>(v1);
    }

    public fun initial_token_reserve(arg0: &LaunchpadConfig) : u64 {
        arg0.initial_token_reserve
    }

    public fun launch_paused(arg0: &LaunchpadConfig) : bool {
        arg0.launch_paused
    }

    public fun lp_fee_pct(arg0: &LaunchpadConfig) : u64 {
        arg0.lp_fee_pct
    }

    public fun lp_token_reserve(arg0: &LaunchpadConfig) : u64 {
        arg0.lp_token_reserve
    }

    public fun protocol_fee_pct(arg0: &LaunchpadConfig) : u64 {
        arg0.protocol_fee_pct
    }

    public fun set_creation_fee(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        arg1.creation_fee_mist = arg2;
    }

    public fun set_fee_distribution(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 + arg3 + arg4 == 100, 1);
        arg1.creator_fee_pct = arg2;
        arg1.protocol_fee_pct = arg3;
        arg1.lp_fee_pct = arg4;
    }

    public fun set_graduation_threshold(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        assert!(arg2 > 0, 2);
        arg1.graduation_sui_threshold = arg2;
    }

    public fun set_launch_paused(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: bool) {
        arg1.launch_paused = arg2;
    }

    public fun set_trade_fee_bps(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        arg1.trade_fee_bps = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun set_virtual_sui_reserve(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        assert!(arg2 > 0, 2);
        arg1.virtual_sui_reserve = arg2;
    }

    public fun trade_fee_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.trade_fee_bps
    }

    public fun treasury(arg0: &LaunchpadConfig) : address {
        arg0.treasury
    }

    public fun virtual_sui_reserve(arg0: &LaunchpadConfig) : u64 {
        arg0.virtual_sui_reserve
    }

    // decompiled from Move bytecode v7
}

