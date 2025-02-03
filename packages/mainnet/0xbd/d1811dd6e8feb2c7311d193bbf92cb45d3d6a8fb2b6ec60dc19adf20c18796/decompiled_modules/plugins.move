module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::plugins {
    struct Plugins<phantom T0> has store {
        generator: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::WitnessGenerator<T0>,
        packages: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun delegate<T0, T1>(arg0: &T1, arg1: &mut Plugins<T0>) : 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0> {
        assert_plugin<T0, T1>(arg1);
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::delegate<T0>(&arg1.generator)
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: Plugins<T0>) {
        assert_no_plugins<T0>(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Plugins<T0>>(), arg1);
    }

    public fun add_plugin<T0, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Plugins<T0>) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.packages, 0x1::type_name::get<T1>());
    }

    public fun assert_no_plugins<T0>(arg0: &0x2::object::UID) {
        assert!(!has_domain<T0>(arg0), 2);
    }

    public fun assert_plugin<T0, T1>(arg0: &Plugins<T0>) {
        assert!(contains_plugin<T0, T1>(arg0), 3);
    }

    public fun assert_plugins<T0>(arg0: &0x2::object::UID) {
        assert!(has_domain<T0>(arg0), 1);
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &Plugins<T0> {
        assert_plugins<T0>(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Plugins<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut Plugins<T0> {
        assert_plugins<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Plugins<T0>>())
    }

    public fun contains_plugin<T0, T1>(arg0: &Plugins<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.packages, &v0)
    }

    public fun get_plugins<T0>(arg0: &mut Plugins<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.packages
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Plugins<T0>>())
    }

    fun new<T0, T1: drop>(arg0: T1) : Plugins<T0> {
        Plugins<T0>{
            generator : 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::generator<T0, T1>(arg0),
            packages  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : Plugins<T0> {
        assert_plugins<T0>(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Plugins<T0>>())
    }

    public fun remove_plugin<T0, T1>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Plugins<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.packages, &v0);
    }

    // decompiled from Move bytecode v6
}

