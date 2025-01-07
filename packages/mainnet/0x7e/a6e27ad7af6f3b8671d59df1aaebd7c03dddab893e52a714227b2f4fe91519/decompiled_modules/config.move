module 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        version: u64,
        allow_positive_slippage: bool,
    }

    struct UpdatedConfig has copy, drop {
        sender: address,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        allow_positive_slippage: bool,
    }

    struct UpdatedVersion has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun allow_positive_slippage(arg0: &Config) : bool {
        arg0.allow_positive_slippage
    }

    public fun check_version(arg0: &Config) {
        assert!(arg0.version == 1, 1000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                      : 0x2::object::new(arg0),
            max_commission_bps      : 500,
            protocol_fee_bps        : 2000,
            version                 : 1,
            allow_positive_slippage : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_commission_bps(arg0: &Config) : u64 {
        arg0.max_commission_bps
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun update(arg0: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000 && arg2 > 0, 0);
        assert!(arg3 <= 5000 && arg3 >= 0, 0);
        arg1.max_commission_bps = arg2;
        arg1.protocol_fee_bps = arg3;
        arg1.allow_positive_slippage = arg4;
        let v0 = UpdatedConfig{
            sender                  : 0x2::tx_context::sender(arg5),
            max_commission_bps      : arg2,
            protocol_fee_bps        : arg3,
            allow_positive_slippage : arg4,
        };
        0x2::event::emit<UpdatedConfig>(v0);
    }

    public fun update_version(arg0: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        let v0 = UpdatedVersion{
            old_version : arg1.version,
            new_version : arg2,
        };
        arg1.version = arg2;
        0x2::event::emit<UpdatedVersion>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

