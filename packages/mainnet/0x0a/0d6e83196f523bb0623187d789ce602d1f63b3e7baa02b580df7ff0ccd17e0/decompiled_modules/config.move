module 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct Tier has copy, drop, store {
        rebate: u64,
        discount: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::ACL,
        package_version: u64,
        user_tiers: 0x2::vec_map::VecMap<address, Tier>,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct AddOperatorEvent has copy, drop {
        operator_cap_id: 0x2::object::ID,
        recipient: address,
        roles: u128,
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

    struct SetTierEvent has copy, drop {
        user: address,
        rebate: u64,
        discount: u64,
    }

    public(friend) fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::Member> {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::get_members(&arg0.acl)
    }

    public(friend) fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public(friend) fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public(friend) fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public(friend) fun add_operator(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg4)};
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::set_roles(&mut arg1.acl, 0x2::object::id_address<OperatorCap>(&v0), arg2);
        0x2::transfer::transfer<OperatorCap>(v0, arg3);
        let v1 = AddOperatorEvent{
            operator_cap_id : 0x2::object::id<OperatorCap>(&v0),
            recipient       : arg3,
            roles           : arg2,
        };
        0x2::event::emit<AddOperatorEvent>(v1);
    }

    public fun check_rebalance_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::has_role(&arg0.acl, arg1, 2), 3);
    }

    public fun check_reward_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    public fun check_vault_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 0);
    }

    public fun get_tier(arg0: &GlobalConfig, arg1: address) : (u64, u64) {
        if (0x2::vec_map::contains<address, Tier>(&arg0.user_tiers, &arg1)) {
            let v2 = 0x2::vec_map::get<address, Tier>(&arg0.user_tiers, &arg1);
            (v2.rebate, v2.discount)
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            acl             : 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::acl::new(arg0),
            package_version : 1,
            user_tiers      : 0x2::vec_map::empty<address, Tier>(),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<GlobalConfig>(v1);
        let v2 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v0),
            global_config_id : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
    }

    public(friend) fun set_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public(friend) fun set_tier(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 1000000, 4);
        assert!(arg4 <= 1000000, 5);
        if (0x2::vec_map::contains<address, Tier>(&arg1.user_tiers, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<address, Tier>(&mut arg1.user_tiers, &arg2);
            v0.rebate = arg3;
            v0.discount = arg4;
        } else {
            let v1 = Tier{
                rebate   : arg3,
                discount : arg4,
            };
            0x2::vec_map::insert<address, Tier>(&mut arg1.user_tiers, arg2, v1);
        };
        let v2 = SetTierEvent{
            user     : arg2,
            rebate   : arg3,
            discount : arg4,
        };
        0x2::event::emit<SetTierEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

