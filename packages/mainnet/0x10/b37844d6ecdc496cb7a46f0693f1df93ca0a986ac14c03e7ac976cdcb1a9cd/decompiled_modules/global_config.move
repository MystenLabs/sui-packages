module 0x10b37844d6ecdc496cb7a46f0693f1df93ca0a986ac14c03e7ac976cdcb1a9cd::global_config {
    struct SetPackageVersion has copy, drop {
        sender: address,
        new_version: u64,
        old_version: u64,
    }

    struct SetProtocolFeePercent has copy, drop {
        sender: address,
        new_fee_percent: u64,
        old_fee_percent: u64,
    }

    struct SetShortfallFeePercent has copy, drop {
        sender: address,
        new_fee_percent: u64,
        old_fee_percent: u64,
    }

    struct SetLiquidationFeeWallet has copy, drop {
        sender: address,
        new_wallet: address,
        old_wallet: address,
    }

    struct SetActiveStatus has copy, drop {
        sender: address,
        new_status: bool,
        old_status: bool,
    }

    struct SetLiquidationThreshold has copy, drop {
        sender: address,
        new_threshold: u64,
        old_threshold: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        is_active: bool,
        protocol_fee_percent: u64,
        shortfall_fee_percent: u64,
        liquidation_fee_wallet: address,
        liquidation_threshold: u64,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                     : 0x2::object::new(arg4),
            package_version        : 1,
            is_active              : false,
            protocol_fee_percent   : arg0,
            shortfall_fee_percent  : arg1,
            liquidation_fee_wallet : arg2,
            liquidation_threshold  : arg3,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public(friend) fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 3);
    }

    public(friend) fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun get_liquidation_fee_wallet(arg0: &GlobalConfig) : address {
        arg0.liquidation_fee_wallet
    }

    public fun get_liquidation_threshold(arg0: &GlobalConfig) : u64 {
        arg0.liquidation_threshold
    }

    public fun info(arg0: &GlobalConfig) : (u64, bool, u64, u64, address, u64) {
        (arg0.package_version, arg0.is_active, arg0.protocol_fee_percent, arg0.shortfall_fee_percent, arg0.liquidation_fee_wallet, arg0.liquidation_threshold)
    }

    public(friend) fun max_percent() : u64 {
        10000
    }

    public(friend) fun set_active_status(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        arg0.is_active = arg1;
        let v0 = SetActiveStatus{
            sender     : 0x2::tx_context::sender(arg2),
            new_status : arg1,
            old_status : arg0.is_active,
        };
        0x2::event::emit<SetActiveStatus>(v0);
    }

    public(friend) fun set_liquidation_fee_wallet(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        arg0.liquidation_fee_wallet = arg1;
        let v0 = SetLiquidationFeeWallet{
            sender     : 0x2::tx_context::sender(arg2),
            new_wallet : arg1,
            old_wallet : arg0.liquidation_fee_wallet,
        };
        0x2::event::emit<SetLiquidationFeeWallet>(v0);
    }

    public(friend) fun set_liquidation_threshold(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.liquidation_threshold = arg1;
        let v0 = SetLiquidationThreshold{
            sender        : 0x2::tx_context::sender(arg2),
            new_threshold : arg1,
            old_threshold : arg0.liquidation_threshold,
        };
        0x2::event::emit<SetLiquidationThreshold>(v0);
    }

    public(friend) fun set_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.package_version;
        assert!(arg1 > v0, 2);
        arg0.package_version = arg1;
        let v1 = SetPackageVersion{
            sender      : 0x2::tx_context::sender(arg2),
            new_version : arg1,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public(friend) fun set_protocol_fee_percent(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.protocol_fee_percent = arg1;
        let v0 = SetProtocolFeePercent{
            sender          : 0x2::tx_context::sender(arg2),
            new_fee_percent : arg1,
            old_fee_percent : arg0.protocol_fee_percent,
        };
        0x2::event::emit<SetProtocolFeePercent>(v0);
    }

    public(friend) fun set_shortfall_fee_percent(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.shortfall_fee_percent = arg1;
        let v0 = SetShortfallFeePercent{
            sender          : 0x2::tx_context::sender(arg2),
            new_fee_percent : arg1,
            old_fee_percent : arg0.shortfall_fee_percent,
        };
        0x2::event::emit<SetShortfallFeePercent>(v0);
    }

    // decompiled from Move bytecode v6
}

