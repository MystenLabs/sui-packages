module 0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control {
    struct SRoles<phantom T0> has key {
        id: 0x2::object::UID,
        role: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
    }

    struct RoleCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct OwnerCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct NewCreatedSharedRolesEvent has copy, drop {
        owner_cap_id: 0x2::object::ID,
        s_roles_id: 0x2::object::ID,
    }

    struct RoleAddedEvent has copy, drop {
        owner: address,
        roleId: 0x2::object::ID,
    }

    struct RoleRevokedEvent has copy, drop {
        owner: address,
        roleId: 0x2::object::ID,
    }

    struct RoleDeletedEvent has copy, drop {
        owner: address,
        roleId: 0x2::object::ID,
    }

    public fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        let v0 = 0x2::object::new(arg1);
        let v1 = SRoles<T0>{
            id   : v0,
            role : 0x2::vec_map::empty<0x2::object::ID, bool>(),
        };
        0x2::transfer::share_object<SRoles<T0>>(v1);
        let v2 = 0x2::object::new(arg1);
        let v3 = OwnerCap<T0>{id: v2};
        0x2::transfer::transfer<OwnerCap<T0>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = NewCreatedSharedRolesEvent{
            owner_cap_id : 0x2::object::uid_to_inner(&v2),
            s_roles_id   : 0x2::object::uid_to_inner(&v0),
        };
        0x2::event::emit<NewCreatedSharedRolesEvent>(v4);
    }

    public fun add_role<T0, T1: key>(arg0: &OwnerCap<T0>, arg1: &mut SRoles<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoleCap<T1>{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<RoleCap<T1>>(&v0);
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.role, v1, true);
        0x2::transfer::transfer<RoleCap<T1>>(v0, arg2);
        let v2 = RoleAddedEvent{
            owner  : 0x2::tx_context::sender(arg3),
            roleId : v1,
        };
        0x2::event::emit<RoleAddedEvent>(v2);
    }

    public fun delete_cap<T0, T1: key>(arg0: &mut SRoles<T0>, arg1: RoleCap<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<RoleCap<T1>>(&arg1);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg0.role, &v0);
        let RoleCap { id: v3 } = arg1;
        0x2::object::delete(v3);
        let v4 = RoleDeletedEvent{
            owner  : 0x2::tx_context::sender(arg2),
            roleId : v0,
        };
        0x2::event::emit<RoleDeletedEvent>(v4);
    }

    public fun has_cap_access<T0, T1: key>(arg0: &SRoles<T0>, arg1: &RoleCap<T1>) : bool {
        let v0 = 0x2::object::id<RoleCap<T1>>(arg1);
        0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.role, &v0)
    }

    public fun revoke_role_access<T0>(arg0: &OwnerCap<T0>, arg1: &mut SRoles<T0>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg1.role, &arg2);
        let v2 = RoleRevokedEvent{
            owner  : 0x2::tx_context::sender(arg3),
            roleId : arg2,
        };
        0x2::event::emit<RoleRevokedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

