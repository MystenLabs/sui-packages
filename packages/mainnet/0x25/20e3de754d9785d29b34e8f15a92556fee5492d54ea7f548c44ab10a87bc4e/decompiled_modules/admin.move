module 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin {
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

    struct ACL has store, key {
        id: 0x2::object::UID,
        minor_signs: vector<address>,
        breakers: vector<address>,
        robots: vector<address>,
    }

    public entry fun add_minor_signs_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.minor_signs, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg1.minor_signs, arg2);
    }

    public entry fun del_minor_signs(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.minor_signs, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.minor_signs, v1);
    }

    public fun get_version(arg0: &AdminCap) : u64 {
        arg0.version
    }

    public(friend) fun grant_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg1),
            version : 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::version::get_program_version(),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::set_min_stake_amount<T0>(arg1, arg2);
        let v0 = MinStakeAmountUpdatedEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<MinStakeAmountUpdatedEvent>(v0);
    }

    public entry fun set_min_stake_amount_v2<T0>(arg0: &mut ACL, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.minor_signs, &v0), 3);
        0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::set_min_stake_amount<T0>(arg1, arg2);
        let v1 = MinStakeAmountUpdatedEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<MinStakeAmountUpdatedEvent>(v1);
    }

    public entry fun share_acl(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id          : 0x2::object::new(arg1),
            minor_signs : 0x1::vector::empty<address>(),
            breakers    : 0x1::vector::empty<address>(),
            robots      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<ACL>(v0);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminCapTransferEvent>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_pool_version<T0>(arg0: &AdminCap, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &0x2::tx_context::TxContext) {
        0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::update_version<T0>(arg1);
        let v0 = PoolVersionUpdatedEvent{
            admin       : 0x2::tx_context::sender(arg2),
            old_version : 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::get_version<T0>(arg1),
            new_version : 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::get_version<T0>(arg1),
        };
        0x2::event::emit<PoolVersionUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

