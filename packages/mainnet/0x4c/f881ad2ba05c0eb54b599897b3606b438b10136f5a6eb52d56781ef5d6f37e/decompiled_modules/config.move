module 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchConfig has store, key {
        id: 0x2::object::UID,
        minimum_version: u64,
        is_create_enabled: bool,
        are_swaps_enabled: bool,
        withdraw_enabled: bool,
        update_enabled: bool,
        virtual_sui_amount: u64,
        curve_supply_bps: u64,
        listing_fee: u64,
        swap_fee_bps: u64,
        creator_fee_bps: u64,
        migration_fee_bps: u64,
        treasury: address,
    }

    struct CONFIG has drop {
        dummy_field: bool,
    }

    public fun are_swaps_enabled(arg0: &LaunchConfig) : bool {
        arg0.are_swaps_enabled
    }

    public fun creator_fee_bps(arg0: &LaunchConfig) : u64 {
        arg0.creator_fee_bps
    }

    public fun curve_supply_bps(arg0: &LaunchConfig) : u64 {
        arg0.curve_supply_bps
    }

    fun emit_update(arg0: &LaunchConfig) {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_config_update(id(arg0));
    }

    public fun enforce_create_enabled(arg0: &LaunchConfig) {
        assert!(arg0.is_create_enabled, 1);
    }

    public fun enforce_swaps_enabled(arg0: &LaunchConfig) {
        assert!(arg0.are_swaps_enabled, 2);
    }

    public fun enforce_update_enabled(arg0: &LaunchConfig) {
        assert!(arg0.update_enabled, 6);
    }

    public fun enforce_version(arg0: &LaunchConfig) {
        assert!(0 >= arg0.minimum_version, 0);
    }

    public fun enforce_withdraw_enabled(arg0: &LaunchConfig) {
        assert!(arg0.withdraw_enabled, 5);
    }

    public fun id(arg0: &LaunchConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = LaunchConfig{
            id                 : 0x2::object::new(arg1),
            minimum_version    : 0,
            is_create_enabled  : false,
            are_swaps_enabled  : false,
            withdraw_enabled   : true,
            update_enabled     : false,
            virtual_sui_amount : 1600000000000,
            curve_supply_bps   : 8000,
            listing_fee        : 2000000000,
            swap_fee_bps       : 70,
            creator_fee_bps    : 30,
            migration_fee_bps  : 100,
            treasury           : @0x5ee40460b6aa6a5c20964d11cd3c78c85875776728949883fbc5aad229aa0802,
        };
        0x2::transfer::share_object<LaunchConfig>(v1);
    }

    public fun is_create_enabled(arg0: &LaunchConfig) : bool {
        arg0.is_create_enabled
    }

    public fun listing_fee(arg0: &LaunchConfig) : u64 {
        arg0.listing_fee
    }

    public fun migration_fee_bps(arg0: &LaunchConfig) : u64 {
        arg0.migration_fee_bps
    }

    public fun minimum_version(arg0: &LaunchConfig) : u64 {
        arg0.minimum_version
    }

    public fun set_create_enabled(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: bool) {
        enforce_version(arg1);
        arg1.is_create_enabled = arg2;
        emit_update(arg1);
    }

    public fun set_swaps_enabled(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: bool) {
        enforce_version(arg1);
        arg1.are_swaps_enabled = arg2;
        emit_update(arg1);
    }

    public fun set_update_enabled(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: bool) {
        enforce_version(arg1);
        arg1.update_enabled = arg2;
        emit_update(arg1);
    }

    public fun set_withdraw_enabled(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: bool) {
        enforce_version(arg1);
        arg1.withdraw_enabled = arg2;
        emit_update(arg1);
    }

    public fun swap_fee_bps(arg0: &LaunchConfig) : u64 {
        arg0.swap_fee_bps
    }

    public fun treasury_address(arg0: &LaunchConfig) : address {
        arg0.treasury
    }

    public fun update_creator_fee_bps(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        enforce_version(arg1);
        assert!(arg2 < 10000, 3);
        arg1.creator_fee_bps = arg2;
        emit_update(arg1);
    }

    public fun update_enabled(arg0: &LaunchConfig) : bool {
        arg0.update_enabled
    }

    public fun update_listing_fee(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        enforce_version(arg1);
        arg1.listing_fee = arg2;
        emit_update(arg1);
    }

    public fun update_migration_fee_bps(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        enforce_version(arg1);
        assert!(arg2 < 10000, 3);
        arg1.migration_fee_bps = arg2;
        emit_update(arg1);
    }

    public fun update_minimum_version(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        enforce_version(arg1);
        assert!(arg2 >= arg1.minimum_version, 0);
        arg1.minimum_version = arg2;
        emit_update(arg1);
    }

    public fun update_swap_fee_bps(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        enforce_version(arg1);
        assert!(arg2 < 10000, 3);
        arg1.swap_fee_bps = arg2;
        emit_update(arg1);
    }

    public fun update_treasury(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: address) {
        assert!(arg2 != @0x0, 4);
        enforce_version(arg1);
        arg1.treasury = arg2;
        emit_update(arg1);
    }

    public fun update_virtual_sui_amount(arg0: &AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        assert!(arg2 > 0, 4);
        enforce_version(arg1);
        arg1.virtual_sui_amount = arg2;
        emit_update(arg1);
    }

    public fun virtual_sui_amount(arg0: &LaunchConfig) : u64 {
        arg0.virtual_sui_amount
    }

    public fun withdraw_enabled(arg0: &LaunchConfig) : bool {
        arg0.withdraw_enabled
    }

    // decompiled from Move bytecode v6
}

