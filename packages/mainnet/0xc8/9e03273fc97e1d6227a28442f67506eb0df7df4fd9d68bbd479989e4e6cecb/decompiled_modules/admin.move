module 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCapTransferEvent has copy, drop {
        from: address,
        to: address,
    }

    struct UpgradeRequestEvent has copy, drop {
        admin: address,
        policy: u8,
        package_id: 0x2::object::ID,
    }

    struct UpgradeCompletedEvent has copy, drop {
        admin: address,
        package_id: 0x2::object::ID,
    }

    struct MinStakeAmountUpdatedEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct AdminCapVersionUpdated has copy, drop {
        old_version: u64,
        new_version: u64,
        operator: address,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun get_version(arg0: &AdminCap) : u64 {
        arg0.version
    }

    public(friend) fun grant_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg1),
            version : 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::version::get_program_version(),
        };
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg1),
            version : 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::version::get_program_version(),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun migrate(arg0: &mut AdminCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::version::get_program_version();
        assert!(arg0.version < v0, 1);
        let v1 = AdminCapVersionUpdated{
            old_version : arg0.version,
            new_version : v0,
            operator    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminCapVersionUpdated>(v1);
        arg0.version = v0;
    }

    public entry fun set_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::staking_pool::set_min_stake_amount<T0>(arg1, arg2);
        let v0 = MinStakeAmountUpdatedEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<MinStakeAmountUpdatedEvent>(v0);
    }

    public entry fun set_upgrade_policy(arg0: &mut 0x2::package::UpgradeCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 1) {
            0x2::package::only_additive_upgrades(arg0);
        } else if (arg1 == 0 || arg1 == 2) {
            let v0 = UpgradeRequestEvent{
                admin      : 0x2::tx_context::sender(arg2),
                policy     : arg1,
                package_id : 0x2::package::upgrade_package(arg0),
            };
            0x2::event::emit<UpgradeRequestEvent>(v0);
        };
        let v1 = UpgradeCompletedEvent{
            admin      : 0x2::tx_context::sender(arg2),
            package_id : 0x2::package::upgrade_package(arg0),
        };
        0x2::event::emit<UpgradeCompletedEvent>(v1);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminCapTransferEvent>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

