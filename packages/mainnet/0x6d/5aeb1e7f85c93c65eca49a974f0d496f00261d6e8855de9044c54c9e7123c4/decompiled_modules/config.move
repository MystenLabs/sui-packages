module 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        swap_slippages: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fee_rate: u64,
        last_version: u64,
        acl: 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::ACL,
    }

    struct InitConfigEvent has copy, drop {
        global_config: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct SetSwapSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct EmergencyPauseEvent has copy, drop {
        version: u64,
    }

    struct EmergencyUnpauseEvent has copy, drop {
        version: u64,
    }

    struct SetAumSafetyMarginBpsEvent has copy, drop {
        old: u64,
        new: u64,
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::admin_cap::AdminCap, arg2: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg3: address) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg2);
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::remove_member(&mut arg0.acl, arg3);
        let v0 = RemoveMemberEvent{member: arg3};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::admin_cap::AdminCap, arg2: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg3: address, arg4: u128) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg2);
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::set_roles(&mut arg0.acl, arg3, arg4);
        let v0 = SetRolesEvent{
            member : arg3,
            roles  : arg4,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun aum_safety_margin_denominator() : u64 {
        1000000000
    }

    public fun check_config_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 5), 13837874591757697056);
    }

    public fun check_emergency_pause_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 4), 13837593039471443998);
    }

    public fun check_keeper_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 1), 13836748240878764056);
    }

    public fun check_oracle_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 3), 13837311487185190940);
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 0), 13836466903340875798);
    }

    public fun check_vault_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 2), 13837029934898937882);
    }

    public fun emergency_pause(arg0: &mut GlobalConfig, arg1: &mut 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg2: &0x2::tx_context::TxContext) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg1);
        check_emergency_pause_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::version(arg1) != 1844674407370955161, 13835058922866278412);
        arg0.last_version = 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::version(arg1);
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::set_version(arg1, 1844674407370955161);
        let v0 = EmergencyPauseEvent{version: 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::version(arg1)};
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public fun emergency_unpause(arg0: &mut GlobalConfig, arg1: &mut 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg2: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::admin_cap::AdminCap, arg3: u64) {
        assert!(0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::version(arg1) == 1844674407370955161, 13835340479447498766);
        assert!(arg3 <= 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::current_version() && arg3 >= arg0.last_version, 13835621971604209680);
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::set_version(arg1, arg3);
        let v0 = EmergencyUnpauseEvent{version: arg3};
        0x2::event::emit<EmergencyUnpauseEvent>(v0);
    }

    public fun get_aum_safety_margin_bps(arg0: &GlobalConfig) : u64 {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg0.id, b"aum_safety_margin_bps")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"aum_safety_margin_bps")
        } else {
            10000
        }
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_swap_slippage<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)
        } else {
            50
        }
    }

    public fun has_keeper_manager_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::has_role(&arg0.acl, arg1, 1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            swap_slippages    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fee_rate : 0,
            last_version      : 0,
            acl               : 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::acl::new(arg0),
        };
        let v1 = InitConfigEvent{global_config: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::event::emit<InitConfigEvent>(v1);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun set_aum_safety_margin_bps(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg2);
        check_config_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1 <= 5000000, 13838154829783957538);
        let v0 = 0;
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, u64>(&arg0.id, b"aum_safety_margin_bps")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"aum_safety_margin_bps", arg1);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"aum_safety_margin_bps");
            v0 = *v1;
            *v1 = arg1;
        };
        let v2 = SetAumSafetyMarginBpsEvent{
            old : v0,
            new : arg1,
        };
        0x2::event::emit<SetAumSafetyMarginBpsEvent>(v2);
    }

    public fun set_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg1);
        check_config_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0;
        assert!(arg2 <= 500, 13835903678509285394);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0);
            v1 = *v2;
            *v2 = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, v0, arg2);
        };
        assert!(v1 != arg2, 13835903717163991058);
        let v3 = SetSwapSlippageEvent{
            type_name    : v0,
            old_slippage : v1,
            new_slippage : arg2,
        };
        0x2::event::emit<SetSwapSlippageEvent>(v3);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::Versioned, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned::check_version(arg1);
        check_config_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 13836185016047173652);
        let v0 = arg0.protocol_fee_rate;
        assert!(v0 != arg2, 13836185024637108244);
        arg0.protocol_fee_rate = arg2;
        let v1 = UpdateFeeRateEvent{
            old_fee_rate : v0,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

