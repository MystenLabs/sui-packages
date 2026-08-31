module 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad {
    struct LaunchpadConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        trading_paused: bool,
        claiming_paused: bool,
        platform_fee_bps: u64,
        gift_grace_period_ms: u64,
        attestation_signer: vector<u8>,
    }

    public fun assert_admin_cap(arg0: &LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::assert_admin(arg1, arg0.admin);
    }

    public fun assert_claiming_enabled(arg0: &LaunchpadConfig) {
        assert!(!arg0.claiming_paused, 201);
    }

    public fun assert_trading_enabled(arg0: &LaunchpadConfig) {
        assert!(!arg0.trading_paused, 200);
    }

    public fun assert_valid_creator_fee_bps(arg0: u64) {
        assert!(arg0 <= 300, 202);
        assert!(arg0 % 25 == 0, 203);
    }

    public fun attestation_signer(arg0: &LaunchpadConfig) : &vector<u8> {
        &arg0.attestation_signer
    }

    public fun claiming_paused(arg0: &LaunchpadConfig) : bool {
        arg0.claiming_paused
    }

    public fun creator_fee_step_bps() : u64 {
        25
    }

    public fun gift_grace_period_ms(arg0: &LaunchpadConfig) : u64 {
        arg0.gift_grace_period_ms
    }

    entry fun initialize(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = LaunchpadConfig{
            id                   : 0x2::object::new(arg2),
            admin                : v0,
            treasury             : arg0,
            trading_paused       : false,
            claiming_paused      : false,
            platform_fee_bps     : 100,
            gift_grace_period_ms : 604800000,
            attestation_signer   : arg1,
        };
        0x2::transfer::share_object<LaunchpadConfig>(v1);
        0x2::transfer::public_transfer<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap>(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::new(v0, arg2), v0);
    }

    public fun max_creator_fee_bps() : u64 {
        300
    }

    public fun platform_fee_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun set_attestation_signer(arg0: &mut LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: vector<u8>) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::assert_admin(arg1, arg0.admin);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 204);
        arg0.attestation_signer = arg2;
    }

    public fun set_claiming_paused(arg0: &mut LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: bool) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::assert_admin(arg1, arg0.admin);
        arg0.claiming_paused = arg2;
    }

    public fun set_trading_paused(arg0: &mut LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: bool) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::assert_admin(arg1, arg0.admin);
        arg0.trading_paused = arg2;
    }

    public fun trading_paused(arg0: &LaunchpadConfig) : bool {
        arg0.trading_paused
    }

    public fun treasury(arg0: &LaunchpadConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

