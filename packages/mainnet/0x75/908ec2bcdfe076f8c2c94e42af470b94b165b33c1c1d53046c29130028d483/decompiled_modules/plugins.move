module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::plugins {
    struct Plugins<phantom T0> has store {
        generator: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::WitnessGenerator<T0>,
        packages: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun delegate<T0, T1>(arg0: &T1, arg1: &mut Plugins<T0>) : 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0> {
        assert_plugin<T0, T1>(arg1);
        0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::delegate<T0>(&arg1.generator)
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: Plugins<T0>) {
        assert_no_plugins<T0>(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Plugins<T0>>(), arg1);
    }

    public fun add_plugin<T0, T1>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Plugins<T0>) {
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
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Plugins<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut Plugins<T0> {
        assert_plugins<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Plugins<T0>>())
    }

    public fun contains_plugin<T0, T1>(arg0: &Plugins<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.packages, &v0)
    }

    public fun get_plugins<T0>(arg0: &mut Plugins<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.packages
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Plugins<T0>>())
    }

    fun new<T0, T1: drop>(arg0: T1) : Plugins<T0> {
        Plugins<T0>{
            generator : 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::generator<T0, T1>(arg0),
            packages  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : Plugins<T0> {
        assert_plugins<T0>(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<Plugins<T0>>, Plugins<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<Plugins<T0>>())
    }

    public fun remove_plugin<T0, T1>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut Plugins<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.packages, &v0);
    }

    // decompiled from Move bytecode v6
}

