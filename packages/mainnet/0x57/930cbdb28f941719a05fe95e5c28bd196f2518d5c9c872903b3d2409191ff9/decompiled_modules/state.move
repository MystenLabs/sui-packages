module 0x57930cbdb28f941719a05fe95e5c28bd196f2518d5c9c872903b3d2409191ff9::state {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintState has key {
        id: 0x2::object::UID,
        min_version: u64,
        minting_enabled: bool,
        supply_available: u64,
        current_number: u64,
    }

    public fun current_number(arg0: &MintState) : u64 {
        arg0.current_number
    }

    public(friend) fun decrease_supply(arg0: &mut MintState) {
        enforce_version(arg0);
        arg0.supply_available = arg0.supply_available - 1;
        arg0.current_number = arg0.current_number + 1;
    }

    public fun enforce_minting_enabled(arg0: &MintState) {
        assert!(arg0.minting_enabled, 0);
    }

    public fun enforce_supply_available(arg0: &MintState) {
        assert!(arg0.supply_available > 0, 1);
    }

    public fun enforce_version(arg0: &MintState) {
        assert!(0 >= arg0.min_version, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = MintState{
            id               : 0x2::object::new(arg0),
            min_version      : 0,
            minting_enabled  : true,
            supply_available : 50000,
            current_number   : 1,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<MintState>(v1);
    }

    public fun set_min_version(arg0: &AdminCap, arg1: &mut MintState, arg2: u64) {
        enforce_version(arg1);
        assert!(arg2 >= arg1.min_version, 2);
        arg1.min_version = arg2;
    }

    public fun set_minting_enabled(arg0: &AdminCap, arg1: &mut MintState, arg2: bool) {
        enforce_version(arg1);
        arg1.minting_enabled = arg2;
    }

    public fun set_supply_available(arg0: &AdminCap, arg1: &mut MintState, arg2: u64) {
        enforce_version(arg1);
        arg1.supply_available = arg2;
    }

    public fun supply_available(arg0: &MintState) : u64 {
        arg0.supply_available
    }

    // decompiled from Move bytecode v6
}

