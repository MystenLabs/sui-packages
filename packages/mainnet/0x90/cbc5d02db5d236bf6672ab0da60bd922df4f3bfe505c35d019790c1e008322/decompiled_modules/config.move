module 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u16,
        platform_fee_bps: u64,
        referrer_share_bps: u64,
    }

    struct FeesUpdated has copy, drop {
        platform_fee_bps: u64,
        referrer_share_bps: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            platform_fee_bps   : 500,
            referrer_share_bps : 5000,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun platform_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun referrer_share_bps(arg0: &GlobalConfig) : u64 {
        arg0.referrer_share_bps
    }

    public fun update_fees(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        assert!(arg3 <= 10000, 0);
        arg1.platform_fee_bps = arg2;
        arg1.referrer_share_bps = arg3;
        let v0 = FeesUpdated{
            platform_fee_bps   : arg2,
            referrer_share_bps : arg3,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun version(arg0: &GlobalConfig) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

