module 0x49d525986b52160298166c58009937c1d63f361c298579cd061e8d778e410532::open_demo {
    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        admin: address,
    }

    public fun fee(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            fee_bps : 30,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun set_fee_safe(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.fee_bps = arg1;
    }

    public fun set_fee_vuln(arg0: &mut Config, arg1: u64) {
        arg0.fee_bps = arg1;
    }

    // decompiled from Move bytecode v7
}

