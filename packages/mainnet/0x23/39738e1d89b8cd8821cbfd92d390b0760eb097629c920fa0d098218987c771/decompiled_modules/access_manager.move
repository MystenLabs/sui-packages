module 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::access_manager {
    struct AccessManager has store, key {
        id: 0x2::object::UID,
        grantors: 0x2::table::Table<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>,
        caps: 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x2::object::ID>,
    }

    struct RoleCap has store, key {
        id: 0x2::object::UID,
        role: 0x1::type_name::TypeName,
        owner: address,
    }

    struct ROLE<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AccessManager {
        AccessManager{
            id       : 0x2::object::new(arg0),
            grantors : 0x2::table::new<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(arg0),
            caps     : 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::new<0x2::object::ID>(arg0),
        }
    }

    public(friend) fun generate_role_cap<T0>(arg0: &mut AccessManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RoleCap {
        let v0 = RoleCap{
            id    : 0x2::object::new(arg2),
            role  : 0x1::type_name::get<T0>(),
            owner : arg1,
        };
        0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::insert<0x2::object::ID>(&mut arg0.caps, 0x2::object::uid_to_inner(&v0.id));
        v0
    }

    public(friend) fun grant_role<T0>(arg0: &mut AccessManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1)) {
            0x2::table::add<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::new<0x1::type_name::TypeName>(arg2));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1);
        if (0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::contains<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>())) {
            return
        };
        0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::insert<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>());
    }

    public(friend) fun revoke_role<T0>(arg0: &mut AccessManager, arg1: address) {
        if (!0x2::table::contains<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1);
        if (!0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::contains<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>())) {
            return
        };
        0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::remove<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>());
    }

    public(friend) fun revoke_role_cap(arg0: &mut AccessManager, arg1: 0x2::object::ID) {
        if (!role_cap_id_existed(arg0, arg1)) {
            return
        };
        0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::remove<0x2::object::ID>(&mut arg0.caps, arg1);
    }

    public(friend) fun role_cap_id_existed(arg0: &AccessManager, arg1: 0x2::object::ID) : bool {
        0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::contains<0x2::object::ID>(&arg0.caps, arg1)
    }

    public(friend) fun verify_role<T0>(arg0: &AccessManager, arg1: address) : bool {
        0x2::table::contains<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1) && 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::contains<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x2339738e1d89b8cd8821cbfd92d390b0760eb097629c920fa0d098218987c771::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1), 0x1::type_name::get<T0>())
    }

    public(friend) fun verify_role_cap<T0>(arg0: &AccessManager, arg1: &RoleCap) : bool {
        role_cap_id_existed(arg0, 0x2::object::uid_to_inner(&arg1.id)) && arg1.role == 0x1::type_name::get<T0>()
    }

    // decompiled from Move bytecode v6
}

