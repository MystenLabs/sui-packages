module 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::acl {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has store, key {
        id: 0x2::object::UID,
    }

    struct GaugeAdminKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GaugeOperatorKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_gauge_admin(arg0: &Acl, arg1: &0x2::tx_context::TxContext) {
        let v0 = GaugeAdminKey{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(get_acl_<GaugeAdminKey>(arg0, v0) == &v1, 1);
    }

    public(friend) fun assert_gauge_operator(arg0: &Acl, arg1: &0x2::tx_context::TxContext) {
        let v0 = GaugeOperatorKey{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(get_acl_<GaugeOperatorKey>(arg0, v0) == &v1, 2);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, Acl) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Acl{id: 0x2::object::new(arg0)};
        let v2 = GaugeAdminKey{dummy_field: false};
        0x2::dynamic_field::add<GaugeAdminKey, address>(&mut v1.id, v2, 0x2::tx_context::sender(arg0));
        let v3 = GaugeOperatorKey{dummy_field: false};
        0x2::dynamic_field::add<GaugeOperatorKey, address>(&mut v1.id, v3, 0x2::tx_context::sender(arg0));
        (v0, v1)
    }

    fun get_acl_<T0: copy + drop + store>(arg0: &Acl, arg1: T0) : &address {
        0x2::dynamic_field::borrow<T0, address>(&arg0.id, arg1)
    }

    fun set_acl_<T0: copy + drop + store>(arg0: &AdminCap, arg1: &mut Acl, arg2: T0, arg3: address) : 0x1::option::Option<address> {
        0x2::dynamic_field::add<T0, address>(&mut arg1.id, arg2, arg3);
        0x2::dynamic_field::remove_if_exists<T0, address>(&mut arg1.id, arg2)
    }

    public(friend) fun set_gauge_admin(arg0: &mut Acl, arg1: &AdminCap, arg2: address) : 0x1::option::Option<address> {
        let v0 = GaugeAdminKey{dummy_field: false};
        set_acl_<GaugeAdminKey>(arg1, arg0, v0, arg2)
    }

    public(friend) fun set_gauge_operator(arg0: &mut Acl, arg1: &AdminCap, arg2: address) : 0x1::option::Option<address> {
        let v0 = GaugeOperatorKey{dummy_field: false};
        set_acl_<GaugeOperatorKey>(arg1, arg0, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

