module 0x7e2ce6142fd6eb027c410a4c2f08b1ec7880df5030fd685985d124defb72064c::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        launch_fee: u64,
        start_mcap_mist: u64,
        paused: bool,
    }

    struct ConfigChanged has copy, drop {
        treasury: address,
        launch_fee: u64,
        start_mcap_mist: u64,
        paused: bool,
    }

    fun emit_changed(arg0: &Config) {
        let v0 = ConfigChanged{
            treasury        : arg0.treasury,
            launch_fee      : arg0.launch_fee,
            start_mcap_mist : arg0.start_mcap_mist,
            paused          : arg0.paused,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::tx_context::sender(arg0),
            launch_fee      : 1000000000,
            start_mcap_mist : 2000000000000,
            paused          : false,
        };
        emit_changed(&v0);
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public fun set_launch_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100000000000, 1);
        arg1.launch_fee = arg2;
        emit_changed(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        emit_changed(arg1);
    }

    public fun set_start_mcap(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 >= 1000000000 && arg2 <= 100000000000000000, 2);
        arg1.start_mcap_mist = arg2;
        emit_changed(arg1);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
        emit_changed(arg1);
    }

    public fun start_mcap_mist(arg0: &Config) : u64 {
        arg0.start_mcap_mist
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

