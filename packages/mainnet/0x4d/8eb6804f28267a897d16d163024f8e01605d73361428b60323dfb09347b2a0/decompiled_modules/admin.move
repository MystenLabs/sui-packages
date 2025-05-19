module 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCapTransferEvent has copy, drop {
        from: address,
        to: address,
    }

    struct MinStakeAmountUpdatedEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct PoolVersionUpdatedEvent has copy, drop {
        admin: address,
        old_version: u64,
        new_version: u64,
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
            version : 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::version::get_program_version(),
        };
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg1),
            version : 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::version::get_program_version(),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::set_min_stake_amount<T0>(arg1, arg2);
        let v0 = MinStakeAmountUpdatedEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<MinStakeAmountUpdatedEvent>(v0);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminCapTransferEvent>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_pool_version<T0>(arg0: &AdminCap, arg1: &mut 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::StakingPool<T0>, arg2: &0x2::tx_context::TxContext) {
        0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::update_version<T0>(arg1);
        let v0 = PoolVersionUpdatedEvent{
            admin       : 0x2::tx_context::sender(arg2),
            old_version : 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::get_version<T0>(arg1),
            new_version : 0x7cc9a32c987938e8bf295ca54a31d829593efe55cb26e2a204cee6e45f276104::staking_pool::get_version<T0>(arg1),
        };
        0x2::event::emit<PoolVersionUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

