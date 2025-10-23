module 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager {
    struct AccessManager has store, key {
        id: 0x2::object::UID,
        grantors: 0x2::table::Table<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>,
        caps: 0x2::table::Table<0x2::object::ID, address>,
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
            grantors : 0x2::table::new<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(arg0),
            caps     : 0x2::table::new<0x2::object::ID, address>(arg0),
        }
    }

    public(friend) fun generate_role_cap<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : RoleCap {
        RoleCap{
            id    : 0x2::object::new(arg1),
            role  : 0x1::type_name::get<T0>(),
            owner : arg0,
        }
    }

    public(friend) fun grant_role<T0>(arg0: &mut AccessManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1)) {
            0x2::table::add<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::new<0x1::type_name::TypeName>(arg2));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1);
        if (0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::contains<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>())) {
            return
        };
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::insert<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>());
    }

    public(friend) fun revoke_role<T0>(arg0: &mut AccessManager, arg1: address) {
        if (!0x2::table::contains<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&mut arg0.grantors, arg1);
        if (!0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::contains<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>())) {
            return
        };
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::remove<0x1::type_name::TypeName>(v0, 0x1::type_name::get<T0>());
    }

    public(friend) fun revoke_role_cap(arg0: &mut AccessManager, arg1: 0x2::object::ID) : address {
        if (!0x2::table::contains<0x2::object::ID, address>(&arg0.caps, arg1)) {
            @0x0
        } else {
            0x2::table::remove<0x2::object::ID, address>(&mut arg0.caps, arg1);
            *0x2::table::borrow<0x2::object::ID, address>(&arg0.caps, arg1)
        }
    }

    public(friend) fun verify_role<T0>(arg0: &AccessManager, arg1: address) : bool {
        0x2::table::contains<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1) && 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::contains<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<0x1::type_name::TypeName>>(&arg0.grantors, arg1), 0x1::type_name::get<T0>())
    }

    public(friend) fun verify_role_cap<T0>(arg0: &AccessManager, arg1: &RoleCap, arg2: address) : bool {
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.caps, 0x2::object::uid_to_inner(&arg1.id))) {
            if (arg1.role == 0x1::type_name::get<T0>()) {
                arg1.owner == arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

