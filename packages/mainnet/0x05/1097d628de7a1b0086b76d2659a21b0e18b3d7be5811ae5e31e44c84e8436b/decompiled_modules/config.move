module 0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct UpdatedVersion has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun check_version(arg0: &Config) {
        assert!(arg0.version == 1, 1000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun update_version(arg0: &mut Config, arg1: &0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::admin::AdminCap, arg2: u64) {
        let v0 = UpdatedVersion{
            old_version : arg0.version,
            new_version : arg2,
        };
        arg0.version = arg2;
        0x2::event::emit<UpdatedVersion>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

