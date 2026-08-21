module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates {
    struct PAS {
        dummy_field: bool,
    }

    struct Templates has key {
        id: 0x2::object::UID,
    }

    public fun set_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>, arg2: 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Command) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Command>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Command>(&mut arg0.id, v0, arg2);
    }

    entry fun setup(arg0: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::Namespace) {
        let v0 = Templates{id: 0x2::derived_object::claim<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::keys::TemplateKey>(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::uid_mut(arg0), 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::keys::template_key())};
        0x2::transfer::share_object<Templates>(v0);
    }

    public fun unset_template_command<T0: drop>(arg0: &mut Templates, arg1: 0x1::internal::Permit<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 13835058248555692033);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Command>(&mut arg0.id, v0);
    }

    // decompiled from Move bytecode v7
}

