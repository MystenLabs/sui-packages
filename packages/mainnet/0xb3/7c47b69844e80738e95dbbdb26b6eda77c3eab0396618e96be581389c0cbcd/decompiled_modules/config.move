module 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        unstaked_liquidity_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        acl: 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::ACL,
        package_version: u64,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateUnstakedLiquidityFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct AddFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct UpdateFeeTierEvent has copy, drop {
        tick_spacing: u32,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct DeleteFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun acl(arg0: &GlobalConfig) : &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::ACL {
        &arg0.acl
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::Member> {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= max_fee_rate(), 3);
        assert!(!0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 1);
        checked_package_version(arg0);
        check_fee_tier_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = FeeTier{
            tick_spacing : arg1,
            fee_rate     : arg2,
        };
        0x2::vec_map::insert<u32, FeeTier>(&mut arg0.fee_tiers, arg1, v0);
        let v1 = AddFeeTierEvent{
            tick_spacing : arg1,
            fee_rate     : arg2,
        };
        0x2::event::emit<AddFeeTierEvent>(v1);
    }

    public fun check_fee_tier_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::has_role(&arg0.acl, arg1, 1), 6);
    }

    public fun check_partner_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::has_role(&arg0.acl, arg1, 3), 7);
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::has_role(&arg0.acl, arg1, 0), 5);
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::has_role(&arg0.acl, arg1, 2), 9);
    }

    public fun check_rewarder_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::has_role(&arg0.acl, arg1, 4), 8);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 10);
    }

    public fun delete_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 2);
        checked_package_version(arg0);
        check_fee_tier_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let (_, v1) = 0x2::vec_map::remove<u32, FeeTier>(&mut arg0.fee_tiers, &arg1);
        let v2 = v1;
        let v3 = DeleteFeeTierEvent{
            tick_spacing : arg1,
            fee_rate     : v2.fee_rate,
        };
        0x2::event::emit<DeleteFeeTierEvent>(v3);
    }

    public fun epoch_next(arg0: u64) : u64 {
        arg0 - arg0 % 604800 + 604800
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 - arg0 % 604800
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        arg0.fee_rate
    }

    public fun fee_rate_denom() : u64 {
        1000000
    }

    public fun fee_tiers(arg0: &GlobalConfig) : &0x2::vec_map::VecMap<u32, FeeTier> {
        &arg0.fee_tiers
    }

    public fun get_fee_rate(arg0: u32, arg1: &GlobalConfig) : u64 {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg1.fee_tiers, &arg0), 2);
        0x2::vec_map::get<u32, FeeTier>(&arg1.fee_tiers, &arg0).fee_rate
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                          : 0x2::object::new(arg0),
            protocol_fee_rate           : 0,
            unstaked_liquidity_fee_rate : 1000,
            fee_tiers                   : 0x2::vec_map::empty<u32, FeeTier>(),
            acl                         : 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::acl::new(arg0),
            package_version             : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = &mut v0;
        set_roles(&v1, v2, 0x2::tx_context::sender(arg0), 27);
        let v3 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v3);
    }

    public fun max_fee_rate() : u64 {
        200000
    }

    public fun max_protocol_fee_rate() : u64 {
        3000
    }

    public fun max_unstaked_liquidity_fee_rate() : u64 {
        10000
    }

    public fun protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun protocol_fee_rate_denom() : u64 {
        10000
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        arg0.tick_spacing
    }

    public fun unstaked_liquidity_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.unstaked_liquidity_fee_rate
    }

    public fun unstaked_liquidity_fee_rate_denom() : u64 {
        10000
    }

    public fun update_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 2);
        assert!(arg2 <= max_fee_rate(), 3);
        checked_package_version(arg0);
        check_fee_tier_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::vec_map::get_mut<u32, FeeTier>(&mut arg0.fee_tiers, &arg1);
        v0.fee_rate = arg2;
        let v1 = UpdateFeeTierEvent{
            tick_spacing : arg1,
            old_fee_rate : v0.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeTierEvent>(v1);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 3000, 4);
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun update_unstaked_liquidity_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= max_unstaked_liquidity_fee_rate(), 11);
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.unstaked_liquidity_fee_rate = arg1;
        let v0 = UpdateUnstakedLiquidityFeeRateEvent{
            old_fee_rate : arg0.unstaked_liquidity_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateUnstakedLiquidityFeeRateEvent>(v0);
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

