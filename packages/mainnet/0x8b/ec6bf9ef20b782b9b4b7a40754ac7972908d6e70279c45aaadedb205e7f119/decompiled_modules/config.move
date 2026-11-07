module 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        package_version: u64,
        protocol_fee_bps: u64,
        max_swap_slippage_bps: u64,
        treasury: address,
    }

    struct MigrateEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct SetProtocolFeeEvent has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct SetMaxSwapSlippageEvent has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct SetTreasuryEvent has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    public fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun bps() : u64 {
        10000
    }

    public(friend) fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg1),
            package_version       : 1,
            protocol_fee_bps      : 3000,
            max_swap_slippage_bps : 100,
            treasury              : arg0,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun max_protocol_fee_bps() : u64 {
        5000
    }

    public fun max_slippage_cap_bps() : u64 {
        1000
    }

    public fun max_swap_slippage_bps(arg0: &GlobalConfig) : u64 {
        arg0.max_swap_slippage_bps
    }

    public(friend) fun migrate(arg0: &mut GlobalConfig) {
        assert!(arg0.package_version < 1, 2);
        arg0.package_version = 1;
        let v0 = MigrateEvent{
            old_version : arg0.package_version,
            new_version : 1,
        };
        0x2::event::emit<MigrateEvent>(v0);
    }

    public fun package_version(arg0: &GlobalConfig) : u64 {
        arg0.package_version
    }

    public fun protocol_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public(friend) fun set_max_swap_slippage_bps(arg0: &mut GlobalConfig, arg1: u64) {
        assert!(arg1 <= 1000, 4);
        let v0 = SetMaxSwapSlippageEvent{
            old_bps : arg0.max_swap_slippage_bps,
            new_bps : arg1,
        };
        0x2::event::emit<SetMaxSwapSlippageEvent>(v0);
        arg0.max_swap_slippage_bps = arg1;
    }

    public(friend) fun set_protocol_fee_bps(arg0: &mut GlobalConfig, arg1: u64) {
        assert!(arg1 <= 5000, 3);
        let v0 = SetProtocolFeeEvent{
            old_bps : arg0.protocol_fee_bps,
            new_bps : arg1,
        };
        0x2::event::emit<SetProtocolFeeEvent>(v0);
        arg0.protocol_fee_bps = arg1;
    }

    public(friend) fun set_treasury(arg0: &mut GlobalConfig, arg1: address) {
        assert!(arg1 != @0x0, 5);
        let v0 = SetTreasuryEvent{
            old_treasury : arg0.treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<SetTreasuryEvent>(v0);
        arg0.treasury = arg1;
    }

    public fun treasury(arg0: &GlobalConfig) : address {
        arg0.treasury
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

