module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates {
    struct PAS {
        dummy_field: bool,
    }

    struct Templates has key {
        id: 0x2::object::UID,
    }

    public fun set_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>, arg2: 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Command) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Command>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Command>(&mut arg0.id, v0, arg2);
    }

    entry fun setup(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace) {
        let v0 = Templates{id: 0x2::derived_object::claim<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::TemplateKey>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::uid_mut(arg0), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::template_key())};
        0x2::transfer::share_object<Templates>(v0);
    }

    public fun unset_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 13835058248555692033);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Command>(&mut arg0.id, v0);
    }

    // decompiled from Move bytecode v7
}

