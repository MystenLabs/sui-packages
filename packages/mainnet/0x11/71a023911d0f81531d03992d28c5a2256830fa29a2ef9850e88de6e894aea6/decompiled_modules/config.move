module 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        swap_slippages: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fee_rate: u64,
        last_version: u64,
        acl: 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::ACL,
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

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::admin_cap::AdminCap, arg2: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg3: address) {
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::check_version(arg2);
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::remove_member(&mut arg0.acl, arg3);
        let v0 = RemoveMemberEvent{member: arg3};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::admin_cap::AdminCap, arg2: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg3: address, arg4: u128) {
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::check_version(arg2);
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::set_roles(&mut arg0.acl, arg3, arg4);
        let v0 = SetRolesEvent{
            member : arg3,
            roles  : arg4,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_config_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 5), 13837874377009135645);
    }

    public fun check_emergency_pause_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 4), 13837592824722882587);
    }

    public fun check_keeper_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 1), 13836748026130202645);
    }

    public fun check_oracle_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 3), 13837311272436629529);
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 0), 13836466688592314387);
    }

    public fun check_vault_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 2), 13837029720150376471);
    }

    public fun emergency_pause(arg0: &mut GlobalConfig, arg1: &mut 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg2: &0x2::tx_context::TxContext) {
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::check_version(arg1);
        check_emergency_pause_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::version(arg1) != 1844674407370955161, 13835058716707651593);
        arg0.last_version = 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::version(arg1);
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::set_version(arg1, 1844674407370955161);
    }

    public fun emergency_unpause(arg0: &mut GlobalConfig, arg1: &mut 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg2: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::admin_cap::AdminCap, arg3: u64) {
        assert!(0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::version(arg1) == 1844674407370955161, 13835340268993904651);
        assert!(arg3 <= 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::current_version() && arg3 >= arg0.last_version, 13835621761150615565);
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::set_version(arg1, arg3);
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
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::has_role(&arg0.acl, arg1, 1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            swap_slippages    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fee_rate : 0,
            last_version      : 0,
            acl               : 0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::acl::new(arg0),
        };
        let v1 = InitConfigEvent{global_config: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::event::emit<InitConfigEvent>(v1);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun set_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::check_version(arg1);
        check_config_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0;
        assert!(arg2 <= 500, 13835903463760723983);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0);
            v1 = *v2;
            *v2 = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, v0, arg2);
        };
        assert!(v1 != arg2, 13835903502415429647);
        let v3 = SetSwapSlippageEvent{
            type_name    : v0,
            old_slippage : v1,
            new_slippage : arg2,
        };
        0x2::event::emit<SetSwapSlippageEvent>(v3);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: &0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::Versioned, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x1171a023911d0f81531d03992d28c5a2256830fa29a2ef9850e88de6e894aea6::versioned::check_version(arg1);
        check_config_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 13836184801298612241);
        let v0 = arg0.protocol_fee_rate;
        assert!(v0 != arg2, 13836184809888546833);
        arg0.protocol_fee_rate = arg2;
        let v1 = UpdateFeeRateEvent{
            old_fee_rate : v0,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

