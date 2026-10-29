module 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles {
    struct Role has copy, drop, store {
        original: 0x2::object::ID,
        callable: 0x2::object::ID,
        marker: 0x1::option::Option<0x1::type_name::TypeName>,
        version: u64,
        pinned: bool,
        frozen: bool,
    }

    struct State has copy, drop, store {
        roles: vector<Role>,
    }

    struct RoleCertificate<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        kind: u8,
        role: Role,
    }

    public fun version(arg0: &Role) : u64 {
        arg0.version
    }

    public fun assert_certificate<T0, T1>(arg0: &RoleCertificate<T0, T1>, arg1: u8) {
        names<T0, T1>(arg1);
        let v0 = if (arg0.kind == arg1) {
            if (arg0.role.pinned) {
                if (!arg0.role.frozen) {
                    if (arg0.role.version > 0) {
                        if (arg0.role.original == 0x2::object::id_from_address(0x1::type_name::original_id<T0>())) {
                            if (arg0.role.callable == 0x2::object::id_from_address(0x1::type_name::defining_id<T1>())) {
                                arg0.role.marker == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public fun assert_identity(arg0: &State, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = role(arg0, arg1);
        assert!(v0.original == arg2 && v0.callable == arg3, 2);
    }

    public fun assert_types<T0, T1>(arg0: &State, arg1: u8) {
        names<T0, T1>(arg1);
        let v0 = role(arg0, arg1);
        let v1 = if (v0.original == 0x2::object::id_from_address(0x1::type_name::original_id<T0>())) {
            if (v0.callable == 0x2::object::id_from_address(0x1::type_name::defining_id<T1>())) {
                0x1::option::is_none<0x1::type_name::TypeName>(&v0.marker) || *0x1::option::borrow<0x1::type_name::TypeName>(&v0.marker) == 0x1::type_name::with_defining_ids<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
    }

    public fun attest_role<T0: drop, T1: drop>(arg0: u8, arg1: T0, arg2: T1, arg3: &0x2::package::Publisher, arg4: &0x2::package::UpgradeCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = RoleCertificate<T0, T1>{
            id   : 0x2::object::new(arg5),
            kind : arg0,
            role : proved_role<T0, T1>(arg0, arg3, arg4),
        };
        0x2::transfer::freeze_object<RoleCertificate<T0, T1>>(v0);
        0x2::object::id<RoleCertificate<T0, T1>>(&v0)
    }

    public fun callable(arg0: &Role) : 0x2::object::ID {
        arg0.callable
    }

    public fun certificate_kind<T0, T1>(arg0: &RoleCertificate<T0, T1>) : u8 {
        arg0.kind
    }

    public fun certificate_role<T0, T1>(arg0: &RoleCertificate<T0, T1>) : Role {
        arg0.role
    }

    public fun freeze_role(arg0: &mut State, arg1: u8) {
        let v0 = role(arg0, arg1);
        assert!(v0.pinned && !v0.frozen, 3);
        0x1::vector::borrow_mut<Role>(&mut arg0.roles, (arg1 as u64)).frozen = true;
    }

    public fun frozen(arg0: &Role) : bool {
        arg0.frozen
    }

    public fun initial(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : State {
        let v0 = Role{
            original : arg0,
            callable : arg1,
            marker   : 0x1::option::none<0x1::type_name::TypeName>(),
            version  : 1,
            pinned   : false,
            frozen   : false,
        };
        let v1 = 0x1::vector::empty<Role>();
        let v2 = &mut v1;
        0x1::vector::push_back<Role>(v2, v0);
        0x1::vector::push_back<Role>(v2, v0);
        0x1::vector::push_back<Role>(v2, v0);
        0x1::vector::push_back<Role>(v2, v0);
        0x1::vector::push_back<Role>(v2, v0);
        0x1::vector::push_back<Role>(v2, v0);
        State{roles: v1}
    }

    public fun marker(arg0: &Role) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.marker
    }

    fun names<T0, T1>(arg0: u8) {
        assert!(arg0 < 6, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x1::type_name::is_primitive(&v0) && !0x1::type_name::is_primitive(&v1), 1);
        let v2 = if (arg0 == 0) {
            b"native_binding"
        } else if (arg0 == 1) {
            b"maker_release"
        } else if (arg0 == 2) {
            b"maker_catalog"
        } else if (arg0 == 3) {
            b"market"
        } else if (arg0 == 4) {
            b"collection"
        } else {
            b"paid_access"
        };
        let v3 = if (arg0 == 0) {
            b"NativeInstaller1"
        } else if (arg0 == 1) {
            b"ReleaseInstaller1"
        } else if (arg0 == 2) {
            b"CreatorAuthority1"
        } else if (arg0 == 3) {
            b"MarketAuthority1"
        } else if (arg0 == 4) {
            b"CollectionAuthority1"
        } else {
            b"PaidAuthority1"
        };
        let v4 = if (arg0 == 0) {
            b"NativeRevision"
        } else if (arg0 == 1) {
            b"ReleaseRevision"
        } else if (arg0 == 2) {
            b"CreatorRevision"
        } else if (arg0 == 3) {
            b"MarketRevision"
        } else if (arg0 == 4) {
            b"CollectionRevision"
        } else {
            b"PaidRevision"
        };
        let v5 = v4;
        let v6 = 0x1::type_name::module_string(&v0);
        let v7 = if (*0x1::ascii::as_bytes(&v6) == v2) {
            let v8 = 0x1::type_name::datatype_string(&v0);
            if (*0x1::ascii::as_bytes(&v8) == v3) {
                let v9 = 0x1::type_name::module_string(&v1);
                *0x1::ascii::as_bytes(&v9) == v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 1);
        let v10 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v1));
        assert!(0x1::vector::length<u8>(&v10) > 0x1::vector::length<u8>(&v5), 1);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u8>(&v5)) {
            assert!(*0x1::vector::borrow<u8>(&v10, v11) == *0x1::vector::borrow<u8>(&v5, v11), 1);
            v11 = v11 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&v10, v11) >= 49 && *0x1::vector::borrow<u8>(&v10, v11) <= 57, 1);
        while (v11 < 0x1::vector::length<u8>(&v10)) {
            assert!(*0x1::vector::borrow<u8>(&v10, v11) >= 48 && *0x1::vector::borrow<u8>(&v10, v11) <= 57, 1);
            v11 = v11 + 1;
        };
    }

    public fun original(arg0: &Role) : 0x2::object::ID {
        arg0.original
    }

    public fun pin(arg0: &mut State, arg1: u8, arg2: 0x1::type_name::TypeName) {
        assert!(arg1 < 6, 1);
        let v0 = 0x1::vector::borrow_mut<Role>(&mut arg0.roles, (arg1 as u64));
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&v0.marker) || *0x1::option::borrow<0x1::type_name::TypeName>(&v0.marker) == arg2, 2);
        v0.marker = 0x1::option::some<0x1::type_name::TypeName>(arg2);
        v0.pinned = true;
    }

    public fun pinned(arg0: &Role) : bool {
        arg0.pinned
    }

    fun proved_role<T0, T1>(arg0: u8, arg1: &0x2::package::Publisher, arg2: &0x2::package::UpgradeCap) : Role {
        names<T0, T1>(arg0);
        assert!(0x2::package::from_module<T0>(arg1), 2);
        let v0 = 0x2::object::id_from_address(0x1::type_name::original_id<T0>());
        let v1 = 0x2::object::id_from_address(0x1::type_name::defining_id<T1>());
        let v2 = 0x2::package::upgrade_package(arg2);
        let v3 = 0x2::package::version(arg2);
        let v4 = if (0x2::object::id_to_address(&v2) != @0x0) {
            if (v3 > 0) {
                v2 == v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 2);
        let v5 = if (v3 == 1) {
            v2
        } else {
            0x2::package::original_package_id(arg2)
        };
        assert!(v5 == v0, 2);
        Role{
            original : v0,
            callable : v1,
            marker   : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()),
            version  : v3,
            pinned   : true,
            frozen   : false,
        }
    }

    public fun register<T0: drop, T1: drop>(arg0: &mut State, arg1: u8, arg2: T0, arg3: T1, arg4: &0x2::package::Publisher, arg5: &0x2::package::UpgradeCap) {
        select_role(arg0, arg1, proved_role<T0, T1>(arg1, arg4, arg5));
    }

    public fun register_from_certificate<T0: drop, T1: drop>(arg0: &mut State, arg1: u8, arg2: T0, arg3: T1, arg4: &RoleCertificate<T0, T1>) {
        assert_certificate<T0, T1>(arg4, arg1);
        select_role(arg0, arg1, arg4.role);
    }

    public fun role(arg0: &State, arg1: u8) : Role {
        assert!(arg1 < 6, 1);
        *0x1::vector::borrow<Role>(&arg0.roles, (arg1 as u64))
    }

    fun select_role(arg0: &mut State, arg1: u8, arg2: Role) {
        let v0 = role(arg0, arg1);
        assert!(!v0.frozen, 3);
        if (v0.pinned) {
            let v1 = if (arg2.original == v0.original) {
                if (arg2.version > v0.version) {
                    if (arg2.callable != v0.callable) {
                        arg2.marker != v0.marker
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 3);
        };
        *0x1::vector::borrow_mut<Role>(&mut arg0.roles, (arg1 as u64)) = arg2;
    }

    // decompiled from Move bytecode v7
}

