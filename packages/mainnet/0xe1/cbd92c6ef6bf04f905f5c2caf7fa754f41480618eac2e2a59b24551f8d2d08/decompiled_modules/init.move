module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    struct InitCap has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<INIT>(arg0, arg1),
        };
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_walrus(arg0: InitCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: u16, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::upgrade::EmergencyUpgradeCap {
        let InitCap {
            id        : v0,
            publisher : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::package::upgrade_package(&arg1);
        let v3 = 0x1::type_name::get<InitCap>();
        assert!(0x1::type_name::get_address(&v3) == 0x2::address::to_ascii_string(0x2::object::id_to_address(&v2)), 1);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::create_empty(arg5, v2, arg7);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::create(arg2, arg3, arg4, v2, arg6, arg7);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::display::create(v1, arg7);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::upgrade::new(arg1, arg7)
    }

    public fun migrate(arg0: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::Staking, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System) {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::migrate(arg0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::migrate(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::package_id(arg0) == 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::package_id(arg1), 0);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::version(arg0) == 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::version(arg1), 0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_contract_upgraded(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::epoch(arg0), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::package_id(arg0), 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::version(arg0));
    }

    // decompiled from Move bytecode v6
}

