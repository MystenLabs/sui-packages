module 0xeee6812f2041ee8b85f628a393185dcb68cb05f9ea0aedd4ef06e93a7fefacf7::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ACL has store {
        members: 0x2::table::Table<address, vector<u64>>,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_bond: u64,
        commit_duration_ms: u64,
        grace_period_ms: u64,
        protocol_fee_bps: u64,
        solver_surplus_share_bps: u64,
        total_solver_reward_cap_bps: u64,
        score_tolerance_bps: u64,
        acl: ACL,
        version: u64,
    }

    struct UpdateMinBondEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct UpdateCommitDurationEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct UpdateGracePeriodEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct UpdateProtocolFeeEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct UpdateScoreToleranceEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct RoleGrantedEvent has copy, drop {
        address: address,
        role: u64,
    }

    struct RoleRevokedEvent has copy, drop {
        address: address,
        role: u64,
    }

    struct SolverSurplusShareUpdatedEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct SolverRewardCapUpdatedEvent has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    public fun assert_config_admin(arg0: &GlobalConfig, arg1: address) {
        assert!(has_role(arg0, arg1, 0), 0);
    }

    public fun commit_duration_ms(arg0: &GlobalConfig) : u64 {
        arg0.commit_duration_ms
    }

    public fun grace_period_ms(arg0: &GlobalConfig) : u64 {
        arg0.grace_period_ms
    }

    public fun grant_role(arg0: &mut GlobalConfig, arg1: address, arg2: u64, arg3: &AdminCap) {
        assert!(arg2 == 0, 0);
        let v0 = &mut arg0.acl;
        if (!0x2::table::contains<address, vector<u64>>(&v0.members, arg1)) {
            0x2::table::add<address, vector<u64>>(&mut v0.members, arg1, 0x1::vector::empty<u64>());
        };
        let v1 = 0x2::table::borrow_mut<address, vector<u64>>(&mut v0.members, arg1);
        if (!0x1::vector::contains<u64>(v1, &arg2)) {
            0x1::vector::push_back<u64>(v1, arg2);
        };
        let v2 = RoleGrantedEvent{
            address : arg1,
            role    : arg2,
        };
        0x2::event::emit<RoleGrantedEvent>(v2);
    }

    public fun has_role(arg0: &GlobalConfig, arg1: address, arg2: u64) : bool {
        let v0 = &arg0.acl;
        if (!0x2::table::contains<address, vector<u64>>(&v0.members, arg1)) {
            return false
        };
        0x1::vector::contains<u64>(0x2::table::borrow<address, vector<u64>>(&v0.members, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ACL{members: 0x2::table::new<address, vector<u64>>(arg0)};
        let v2 = GlobalConfig{
            id                          : 0x2::object::new(arg0),
            min_bond                    : 1000,
            commit_duration_ms          : 15000,
            grace_period_ms             : 30000,
            protocol_fee_bps            : 15,
            solver_surplus_share_bps    : 2000,
            total_solver_reward_cap_bps : 100,
            score_tolerance_bps         : 9500,
            acl                         : v1,
            version                     : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun min_bond(arg0: &GlobalConfig) : u64 {
        arg0.min_bond
    }

    public fun protocol_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public fun revoke_role(arg0: &mut GlobalConfig, arg1: address, arg2: u64, arg3: &AdminCap) {
        assert!(arg2 == 0, 0);
        let v0 = &mut arg0.acl;
        if (!0x2::table::contains<address, vector<u64>>(&v0.members, arg1)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<address, vector<u64>>(&mut v0.members, arg1);
        let v2 = 0;
        let v3 = 0x1::vector::length<u64>(v1);
        let v4 = v3;
        while (v2 < v3) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg2) {
                v4 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v4 < v3) {
            0x1::vector::remove<u64>(v1, v4);
        };
        let v5 = RoleRevokedEvent{
            address : arg1,
            role    : arg2,
        };
        0x2::event::emit<RoleRevokedEvent>(v5);
    }

    public fun role_config_admin() : u64 {
        0
    }

    public fun score_tolerance_bps(arg0: &GlobalConfig) : u64 {
        arg0.score_tolerance_bps
    }

    public fun set_commit_duration(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 604800000, 3);
        arg0.commit_duration_ms = arg1;
        let v0 = UpdateCommitDurationEvent{
            old_value : arg0.commit_duration_ms,
            new_value : arg1,
        };
        0x2::event::emit<UpdateCommitDurationEvent>(v0);
    }

    public fun set_grace_period(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 604800000, 3);
        arg0.grace_period_ms = arg1;
        let v0 = UpdateGracePeriodEvent{
            old_value : arg0.grace_period_ms,
            new_value : arg1,
        };
        0x2::event::emit<UpdateGracePeriodEvent>(v0);
    }

    public fun set_min_bond(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= 1000000000000, 2);
        arg0.min_bond = arg1;
        let v0 = UpdateMinBondEvent{
            old_value : arg0.min_bond,
            new_value : arg1,
        };
        0x2::event::emit<UpdateMinBondEvent>(v0);
    }

    public fun set_protocol_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 1000, 1);
        arg0.protocol_fee_bps = arg1;
        let v0 = UpdateProtocolFeeEvent{
            old_value : arg0.protocol_fee_bps,
            new_value : arg1,
        };
        0x2::event::emit<UpdateProtocolFeeEvent>(v0);
    }

    public fun set_score_tolerance(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 10000, 4);
        arg0.score_tolerance_bps = arg1;
        let v0 = UpdateScoreToleranceEvent{
            old_value : arg0.score_tolerance_bps,
            new_value : arg1,
        };
        0x2::event::emit<UpdateScoreToleranceEvent>(v0);
    }

    public fun set_solver_reward_cap(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 1000, 1);
        arg0.total_solver_reward_cap_bps = arg1;
        let v0 = SolverRewardCapUpdatedEvent{
            old_value : arg0.total_solver_reward_cap_bps,
            new_value : arg1,
        };
        0x2::event::emit<SolverRewardCapUpdatedEvent>(v0);
    }

    public fun set_solver_surplus_share(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 2000, 1);
        arg0.solver_surplus_share_bps = arg1;
        let v0 = SolverSurplusShareUpdatedEvent{
            old_value : arg0.solver_surplus_share_bps,
            new_value : arg1,
        };
        0x2::event::emit<SolverSurplusShareUpdatedEvent>(v0);
    }

    public fun solver_surplus_share_bps(arg0: &GlobalConfig) : u64 {
        arg0.solver_surplus_share_bps
    }

    public fun total_solver_reward_cap_bps(arg0: &GlobalConfig) : u64 {
        arg0.total_solver_reward_cap_bps
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

