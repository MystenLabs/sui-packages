module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        marketplace_fee_bps: u16,
        max_royalty_bps: u16,
        paused: bool,
        version: u16,
    }

    struct BootstrapRegistry has key {
        id: 0x2::object::UID,
        done: bool,
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_paused());
    }

    public fun bootstrap(arg0: &mut BootstrapRegistry, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(!arg0.done, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_already_bootstrapped());
        arg0.done = true;
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Config{
            id                  : 0x2::object::new(arg1),
            marketplace_fee_bps : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::default_marketplace_fee_bps(),
            max_royalty_bps     : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::default_max_royalty_bps(),
            paused              : false,
            version             : 1,
        };
        0x2::transfer::share_object<Config>(v1);
        v0
    }

    public entry fun bootstrap_v2_state(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = BootstrapRegistry{
            id   : 0x2::object::new(arg1),
            done : false,
        };
        let v1 = &mut v0;
        0x2::transfer::share_object<BootstrapRegistry>(v0);
        bootstrap(v1, arg1)
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun marketplace_fee_bps(arg0: &Config) : u16 {
        arg0.marketplace_fee_bps
    }

    public fun max_royalty_bps(arg0: &Config) : u16 {
        arg0.max_royalty_bps
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        arg1.marketplace_fee_bps = arg2;
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_config_updated(b"marketplace_fee_bps", (arg1.marketplace_fee_bps as u64), (arg2 as u64));
    }

    public fun set_max_royalty_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        arg1.max_royalty_bps = arg2;
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_config_updated(b"max_royalty_bps", (arg1.max_royalty_bps as u64), (arg2 as u64));
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        let v0 = if (arg1.paused) {
            1
        } else {
            0
        };
        arg1.paused = arg2;
        let v1 = if (arg2) {
            1
        } else {
            0
        };
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_config_updated(b"paused", v0, v1);
    }

    // decompiled from Move bytecode v7
}

