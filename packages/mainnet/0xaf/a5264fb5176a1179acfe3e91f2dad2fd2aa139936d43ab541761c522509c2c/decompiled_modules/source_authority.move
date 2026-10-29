module 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority {
    struct Revision has copy, drop, store {
        original: 0x2::object::ID,
        callable: 0x2::object::ID,
        marker: 0x1::type_name::TypeName,
        version: u64,
    }

    public fun version(arg0: &Revision) : u64 {
        arg0.version
    }

    public fun advance<T0: drop, T1: drop, T2: key>(arg0: 0x1::option::Option<Revision>, arg1: T0, arg2: T1, arg3: &0x2::package::Publisher, arg4: &0x2::package::UpgradeCap) : Revision {
        names<T0, T1, T2>();
        assert!(0x2::package::from_module<T0>(arg3), 2);
        let v0 = 0x2::object::id_from_address(0x1::type_name::original_id<T0>());
        let v1 = 0x2::object::id_from_address(0x1::type_name::defining_id<T1>());
        let v2 = 0x2::package::version(arg4);
        let v3 = 0x2::package::upgrade_package(arg4);
        let v4 = if (v2 > 0) {
            if (0x2::object::id_to_address(&v3) != @0x0) {
                v3 == v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 2);
        let v5 = if (v2 == 1) {
            v3
        } else {
            0x2::package::original_package_id(arg4)
        };
        assert!(v5 == v0, 2);
        let v6 = 0x1::type_name::with_defining_ids<T1>();
        if (0x1::option::is_some<Revision>(&arg0)) {
            let v7 = 0x1::option::destroy_some<Revision>(arg0);
            let v8 = if (v7.original == v0) {
                if (v2 > v7.version) {
                    if (v1 != v7.callable) {
                        v6 != v7.marker
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v8, 3);
        };
        Revision{
            original : v0,
            callable : v1,
            marker   : v6,
            version  : v2,
        }
    }

    public fun assert_types<T0, T1, T2>(arg0: &Revision) {
        names<T0, T1, T2>();
        let v0 = if (arg0.original == 0x2::object::id_from_address(0x1::type_name::original_id<T0>())) {
            if (arg0.callable == 0x2::object::id_from_address(0x1::type_name::defining_id<T1>())) {
                arg0.marker == 0x1::type_name::with_defining_ids<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public fun callable(arg0: &Revision) : 0x2::object::ID {
        arg0.callable
    }

    public fun marker(arg0: &Revision) : 0x1::type_name::TypeName {
        arg0.marker
    }

    fun names<T0, T1, T2>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T2>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                !0x1::type_name::is_primitive(&v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let v4 = if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
            if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                let v5 = 0x1::type_name::datatype_string(&v0);
                if (*0x1::ascii::as_bytes(&v5) == b"SoulProducer") {
                    0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 1);
        let v6 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v2));
        let v7 = b"SourceRevision";
        assert!(0x1::vector::length<u8>(&v6) > 0x1::vector::length<u8>(&v7), 1);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(&v7)) {
            assert!(*0x1::vector::borrow<u8>(&v6, v8) == *0x1::vector::borrow<u8>(&v7, v8), 1);
            v8 = v8 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&v6, v8) >= 49 && *0x1::vector::borrow<u8>(&v6, v8) <= 57, 1);
        while (v8 < 0x1::vector::length<u8>(&v6)) {
            assert!(*0x1::vector::borrow<u8>(&v6, v8) >= 48 && *0x1::vector::borrow<u8>(&v6, v8) <= 57, 1);
            v8 = v8 + 1;
        };
    }

    public fun original(arg0: &Revision) : 0x2::object::ID {
        arg0.original
    }

    // decompiled from Move bytecode v7
}

