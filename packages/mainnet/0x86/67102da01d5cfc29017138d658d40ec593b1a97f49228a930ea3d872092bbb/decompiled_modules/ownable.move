module 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::ownable {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PoolAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct LiquidityOperatorCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PusherCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public fun assert_liquidity_operator_cap_matches<T0, T1>(arg0: &LiquidityOperatorCap<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 2);
    }

    public fun assert_pool_admin_cap_matches<T0, T1>(arg0: &PoolAdminCap<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 2);
    }

    public fun assert_pusher_cap_matches<T0, T1>(arg0: &PusherCap<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 2);
    }

    public fun assert_version(arg0: &AdminCap) {
        assert!(arg0.version == 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::version::get_program_version(), 1);
    }

    public(friend) fun grant_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(new_admin_cap_for_testing(arg1), arg0);
    }

    public(friend) fun grant_liquidity_operator_cap<T0, T1>(arg0: address, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityOperatorCap<T0, T1>{
            id      : 0x2::object::new(arg2),
            pool_id : arg1,
        };
        0x2::transfer::transfer<LiquidityOperatorCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun grant_pool_admin_cap<T0, T1>(arg0: address, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap<T0, T1>{
            id      : 0x2::object::new(arg2),
            pool_id : arg1,
        };
        0x2::transfer::transfer<PoolAdminCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun grant_pusher_cap<T0, T1>(arg0: address, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PusherCap<T0, T1>{
            id      : 0x2::object::new(arg2),
            pool_id : arg1,
        };
        0x2::transfer::transfer<PusherCap<T0, T1>>(v0, arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            version : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::version::get_program_version(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun liquidity_operator_cap_pool_id<T0, T1>(arg0: &LiquidityOperatorCap<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun migrate_admin_cap_version(arg0: &mut AdminCap) {
        arg0.version = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::version::get_program_version();
    }

    public(friend) fun new_admin_cap_for_testing(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id      : 0x2::object::new(arg0),
            version : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::version::get_program_version(),
        }
    }

    public fun pool_admin_cap_pool_id<T0, T1>(arg0: &PoolAdminCap<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pusher_cap_pool_id<T0, T1>(arg0: &PusherCap<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v7
}

