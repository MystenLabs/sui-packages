module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::capability_admin_copy {
    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Config{
            id      : 0x2::object::new(arg1),
            fee_bps : arg0,
        };
        let v2 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun update_fee(arg0: &mut Config, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 0);
        arg0.fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

