module 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PoolAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidityOperatorCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct PusherCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_version(arg0: &AdminCap) {
        assert!(arg0.version == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::version::get_program_version(), 1);
    }

    public(friend) fun grant_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(new_admin_cap_for_testing(arg1), arg0);
    }

    public(friend) fun grant_liquidity_operator_cap<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityOperatorCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LiquidityOperatorCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun grant_pool_admin_cap<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PoolAdminCap<T0, T1>>(v0, arg0);
    }

    public(friend) fun grant_pusher_cap<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PusherCap<T0, T1>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PusherCap<T0, T1>>(v0, arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            version : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::version::get_program_version(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun migrate_admin_cap_version(arg0: &mut AdminCap) {
        arg0.version = 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::version::get_program_version();
    }

    public(friend) fun new_admin_cap_for_testing(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id      : 0x2::object::new(arg0),
            version : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::version::get_program_version(),
        }
    }

    // decompiled from Move bytecode v7
}

