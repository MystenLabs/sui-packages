module 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct ACL has store, key {
        id: 0x2::object::UID,
        minor_signs: vector<address>,
        breakers: vector<address>,
        robots: vector<address>,
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting) {
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::migrate(arg1);
    }

    public fun add_breaker_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.breakers, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg1.breakers, arg2);
    }

    public fun add_minor_signs_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.minor_signs, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg1.minor_signs, arg2);
    }

    public fun add_robot_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.robots, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg1.robots, arg2);
    }

    public fun del_breaker_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.breakers, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.breakers, v1);
    }

    public fun del_minor_signs(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.minor_signs, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.minor_signs, v1);
    }

    public fun del_robot_to_acl(arg0: &AdminCap, arg1: &mut ACL, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.robots, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.robots, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_breaker(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.breakers, &arg1)
    }

    public fun is_minor_sign(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.minor_signs, &arg1)
    }

    public fun is_robot(arg0: &ACL, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.robots, &arg1)
    }

    public fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public fun share_acl(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id          : 0x2::object::new(arg1),
            minor_signs : 0x1::vector::empty<address>(),
            breakers    : 0x1::vector::empty<address>(),
            robots      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<ACL>(v0);
    }

    // decompiled from Move bytecode v6
}

