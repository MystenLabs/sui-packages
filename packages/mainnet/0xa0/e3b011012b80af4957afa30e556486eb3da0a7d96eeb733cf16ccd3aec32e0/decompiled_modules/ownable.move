module 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable {
    struct AdminCapVersionUpdated has copy, drop {
        operator: address,
        old_version: u64,
        new_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pools: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        version: u64,
    }

    struct PoolAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidityOperatorCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun assert_version(arg0: &AdminCap) {
        assert!(arg0.version == 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::version::get_program_version(), 2);
    }

    public entry fun destroy_liquidity_operator_cap<T0, T1>(arg0: LiquidityOperatorCap<T0, T1>) {
        let LiquidityOperatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun destroy_pool(arg0: &mut AdminCap, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, &arg1);
    }

    public entry fun destroy_pool_admin_cap<T0, T1>(arg0: PoolAdminCap<T0, T1>) {
        let PoolAdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun grant_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg1),
            pools   : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
            version : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::version::get_program_version(),
        };
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public(friend) fun grant_liquidity_operator_cap<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityOperatorCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LiquidityOperatorCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun grant_pool_admin_cap<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PoolAdminCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun migrate(arg0: &mut AdminCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::version::get_program_version();
        assert!(arg0.version < v0, 2);
        let v1 = AdminCapVersionUpdated{
            operator    : 0x2::tx_context::sender(arg1),
            old_version : arg0.version,
            new_version : v0,
        };
        0x2::event::emit<AdminCapVersionUpdated>(v1);
        arg0.version = v0;
    }

    public(friend) fun register_pool(arg0: &mut AdminCap, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, &arg1), 1);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

