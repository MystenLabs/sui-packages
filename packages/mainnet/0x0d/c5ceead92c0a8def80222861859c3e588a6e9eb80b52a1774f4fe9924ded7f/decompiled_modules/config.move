module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        paused: bool,
        min_profit_floor: u64,
        max_principal: u64,
        grid_size: u64,
    }

    public fun assert_operational(arg0: &Config) {
        assert!(!arg0.paused, 1);
    }

    public fun grid_size(arg0: &Config) : u64 {
        arg0.grid_size
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            paused           : false,
            min_profit_floor : 0,
            max_principal    : 0,
            grid_size        : 6,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun max_principal(arg0: &Config) : u64 {
        arg0.max_principal
    }

    public fun min_profit_floor(arg0: &Config) : u64 {
        arg0.min_profit_floor
    }

    public fun set_grid_size(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 16, 2);
        arg1.grid_size = arg2;
    }

    public fun set_max_principal(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.max_principal = arg2;
    }

    public fun set_min_profit_floor(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.min_profit_floor = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

