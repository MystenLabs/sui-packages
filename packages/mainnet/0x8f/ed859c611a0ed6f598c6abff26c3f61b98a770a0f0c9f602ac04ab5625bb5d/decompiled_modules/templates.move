module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::templates {
    struct PAS {
        dummy_field: bool,
    }

    struct Templates has key {
        id: 0x2::object::UID,
    }

    public fun set_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>, arg2: 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Command) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Command>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Command>(&mut arg0.id, v0, arg2);
    }

    entry fun setup(arg0: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::Namespace) {
        let v0 = Templates{id: 0x2::derived_object::claim<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::TemplateKey>(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::uid_mut(arg0), 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::template_key())};
        0x2::transfer::share_object<Templates>(v0);
    }

    public fun unset_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 13835058248555692033);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Command>(&mut arg0.id, v0);
    }

    // decompiled from Move bytecode v7
}

