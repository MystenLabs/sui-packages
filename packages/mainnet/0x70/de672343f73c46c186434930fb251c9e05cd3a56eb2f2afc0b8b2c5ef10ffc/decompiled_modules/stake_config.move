module 0x70de672343f73c46c186434930fb251c9e05cd3a56eb2f2afc0b8b2c5ef10ffc::stake_config {
    struct STAKE_CONFIG has drop {
        dummy_field: bool,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        emergency_admin_address: address,
        treasury_admin_address: address,
        global_emergency_locked: bool,
    }

    public fun enable_global_emergency(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.emergency_admin_address, 200);
        assert!(!arg0.global_emergency_locked, 202);
        arg0.global_emergency_locked = true;
    }

    public fun get_emergency_admin_address(arg0: &GlobalConfig) : address {
        arg0.emergency_admin_address
    }

    public fun get_treasury_admin_address(arg0: &GlobalConfig) : address {
        arg0.treasury_admin_address
    }

    fun init(arg0: STAKE_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x98a890e3a370a3e4005460bfcd31dd4adf0f36af6d760bfd2c7014ac6ee2b17e, 200);
        let v0 = GlobalConfig{
            id                      : 0x2::object::new(arg1),
            emergency_admin_address : @0x98a890e3a370a3e4005460bfcd31dd4adf0f36af6d760bfd2c7014ac6ee2b17e,
            treasury_admin_address  : @0x98a890e3a370a3e4005460bfcd31dd4adf0f36af6d760bfd2c7014ac6ee2b17e,
            global_emergency_locked : false,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun is_global_emergency(arg0: &GlobalConfig) : bool {
        arg0.global_emergency_locked
    }

    public fun set_emergency_admin_address(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.emergency_admin_address, 200);
        arg0.emergency_admin_address = arg1;
    }

    public fun set_treasury_admin_address(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury_admin_address, 200);
        arg0.treasury_admin_address = arg1;
    }

    // decompiled from Move bytecode v6
}

