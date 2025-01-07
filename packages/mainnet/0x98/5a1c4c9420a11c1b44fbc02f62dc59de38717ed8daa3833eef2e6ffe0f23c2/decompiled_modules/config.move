module 0x985a1c4c9420a11c1b44fbc02f62dc59de38717ed8daa3833eef2e6ffe0f23c2::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        a_g: u64,
        a_s: u64,
    }

    struct ConfigCap has store, key {
        id: 0x2::object::UID,
    }

    public fun a_g(arg0: &Config) : u64 {
        arg0.a_g
    }

    public fun a_s(arg0: &Config) : u64 {
        arg0.a_s
    }

    public fun burn_config_cap(arg0: ConfigCap) {
        let ConfigCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ConfigCap>(v0, @0x13);
        let v1 = Config{
            id  : 0x2::object::new(arg0),
            a_g : 31250000000,
            a_s : 8000000000,
        };
        0x2::transfer::public_share_object<Config>(v1);
    }

    public fun set_a_g(arg0: &ConfigCap, arg1: &mut Config, arg2: u64) {
        arg1.a_g = arg2;
    }

    public fun set_a_s(arg0: &ConfigCap, arg1: &mut Config, arg2: u64) {
        arg1.a_s = arg2;
    }

    // decompiled from Move bytecode v6
}

