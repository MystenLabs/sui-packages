module 0x203b6511b9fc1aaa448875bbd10b6cf10c3000790c72a9c4538b85d60cba26d6::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        version: u64,
        positive_slippage_fee_bps: u64,
    }

    struct UpdatedConfig has copy, drop {
        sender: address,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        positive_slippage_fee_bps: u64,
    }

    struct UpdatedVersion has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun assert_commission_bps(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.max_commission_bps, 3);
    }

    public fun check_version(arg0: &Config) {
        assert!(arg0.version == 1, 1000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                        : 0x2::object::new(arg0),
            max_commission_bps        : 500,
            protocol_fee_bps          : 2000,
            version                   : 1,
            positive_slippage_fee_bps : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_commission_bps(arg0: &Config) : u64 {
        arg0.max_commission_bps
    }

    public fun positive_slippage_fee_bps(arg0: &Config) : u64 {
        arg0.positive_slippage_fee_bps
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun update(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &0x203b6511b9fc1aaa448875bbd10b6cf10c3000790c72a9c4538b85d60cba26d6::admin::AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000 && arg1 > 0, 0);
        assert!(arg2 <= 5000, 1);
        assert!(arg3 <= 500, 2);
        arg0.max_commission_bps = arg1;
        arg0.protocol_fee_bps = arg2;
        arg0.positive_slippage_fee_bps = arg3;
        let v0 = UpdatedConfig{
            sender                    : 0x2::tx_context::sender(arg5),
            max_commission_bps        : arg1,
            protocol_fee_bps          : arg2,
            positive_slippage_fee_bps : arg3,
        };
        0x2::event::emit<UpdatedConfig>(v0);
    }

    public fun update_version(arg0: &0x203b6511b9fc1aaa448875bbd10b6cf10c3000790c72a9c4538b85d60cba26d6::admin::AdminCap, arg1: &mut Config, arg2: u64) {
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

