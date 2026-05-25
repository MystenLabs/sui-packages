module 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::ACL,
        package_version: u64,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
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

    struct AddExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionConfigEvent has copy, drop, store {
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
    }

    public fun acl(arg0: &GlobalConfig) : &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::ACL {
        &arg0.acl
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::Member> {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        check_package_version(arg1);
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        check_package_version(arg1);
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_or_update_extension_config(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        check_package_version(arg1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.extension_fields, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.extension_fields, &arg2);
            *v0 = arg3;
            let v1 = UpdateExtensionConfigEvent{
                old_value : *v0,
                new_value : arg3,
            };
            0x2::event::emit<UpdateExtensionConfigEvent>(v1);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.extension_fields, arg2, arg3);
            let v2 = AddExtensionConfigEvent{
                key   : arg2,
                value : arg3,
            };
            0x2::event::emit<AddExtensionConfigEvent>(v2);
        };
    }

    public fun check_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 3);
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    public fun check_rebate_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            acl              : 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::acl::new(arg0),
            package_version  : 1,
            extension_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        let v3 = &mut v1;
        set_roles(&v2, v3, v0, 15);
        0x2::transfer::transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<GlobalConfig>(v1);
        let v4 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v2),
            global_config_id : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_extension_config(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        check_package_version(arg1);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.extension_fields, &arg2), 4);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.extension_fields, &arg2);
        let v2 = RemoveExtensionConfigEvent{key: arg2};
        0x2::event::emit<RemoveExtensionConfigEvent>(v2);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > arg1.package_version && arg2 <= 1, 3);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

