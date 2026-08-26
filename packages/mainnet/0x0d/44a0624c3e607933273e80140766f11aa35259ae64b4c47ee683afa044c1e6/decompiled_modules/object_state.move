module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state {
    struct Inner has copy, drop, store {
        dummy_field: bool,
    }

    struct Witness has copy, drop, store {
        dummy_field: bool,
    }

    public fun add<T0: store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        let v0 = Inner{dummy_field: false};
        0x2::dynamic_field::add<Inner, T1>(arg0, v0, arg2);
        let v1 = Witness{dummy_field: false};
        0x2::dynamic_field::add<Witness, T0>(arg0, v1, arg1);
    }

    public fun add_inner<T0: store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        let v0 = Inner{dummy_field: false};
        0x2::dynamic_field::add<Inner, T0>(arg0, v0, arg1);
    }

    public fun assert_upgrade_cap<T0>(arg0: &0x2::package::UpgradeCap) {
        let v0 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::defining_id<T0>(), 13906834590955339779);
    }

    public fun assert_witness<T0: store>(arg0: &0x2::object::UID) {
        assert!(has_witness<T0>(arg0), 13906834427746451457);
    }

    public fun destroy<T0: drop + store, T1: store>(arg0: 0x2::object::UID) : T1 {
        assert_witness<T0>(&arg0);
        let v0 = &mut arg0;
        let v1 = Witness{dummy_field: false};
        0x2::dynamic_field::remove<Witness, T0>(&mut arg0, v1);
        0x2::object::delete(arg0);
        take_inner<T1>(v0)
    }

    public fun has_witness<T0: store>(arg0: &0x2::object::UID) : bool {
        let v0 = Witness{dummy_field: false};
        0x2::dynamic_field::exists_with_type<Witness, T0>(arg0, v0)
    }

    public fun inner<T0: store>(arg0: &0x2::object::UID) : &T0 {
        let v0 = Inner{dummy_field: false};
        0x2::dynamic_field::borrow<Inner, T0>(arg0, v0)
    }

    public fun inner_mut<T0: store, T1: store>(arg0: &mut 0x2::object::UID) : &mut T1 {
        assert_witness<T0>(arg0);
        let v0 = Inner{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Inner, T1>(arg0, v0)
    }

    public fun replace_witness<T0: drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T1) {
        assert_witness<T0>(arg0);
        let v0 = Witness{dummy_field: false};
        0x2::dynamic_field::remove<Witness, T0>(arg0, v0);
        let v1 = Witness{dummy_field: false};
        0x2::dynamic_field::add<Witness, T1>(arg0, v1, arg1);
    }

    public fun take_inner<T0: store>(arg0: &mut 0x2::object::UID) : T0 {
        let v0 = Inner{dummy_field: false};
        0x2::dynamic_field::remove<Inner, T0>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

