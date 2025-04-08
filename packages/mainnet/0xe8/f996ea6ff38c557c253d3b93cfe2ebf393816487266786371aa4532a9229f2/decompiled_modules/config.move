module 0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        version: u64,
    }

    struct UpdatedConfig has copy, drop {
        sender: address,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
    }

    struct UpdatedVersion has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun assert_commission_bps(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.max_commission_bps, 3);
    }

    public fun assert_positive_slippage_bps(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.max_commission_bps, 2);
    }

    public fun check_version(arg0: &Config) {
        assert!(arg0.version == 1, 1000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                 : 0x2::object::new(arg0),
            max_commission_bps : 500,
            protocol_fee_bps   : 2000,
            version            : 1,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_commission_bps(arg0: &Config) : u64 {
        arg0.max_commission_bps
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun update(arg0: &mut Config, arg1: u64, arg2: u64, arg3: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 500, 0);
        assert!(arg2 <= 5000, 1);
        arg0.max_commission_bps = arg1;
        arg0.protocol_fee_bps = arg2;
        let v0 = UpdatedConfig{
            sender             : 0x2::tx_context::sender(arg4),
            max_commission_bps : arg1,
            protocol_fee_bps   : arg2,
        };
        0x2::event::emit<UpdatedConfig>(v0);
    }

    public fun update_version(arg0: &0xe8f996ea6ff38c557c253d3b93cfe2ebf393816487266786371aa4532a9229f2::admin::AdminCap, arg1: &mut Config, arg2: u64) {
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

