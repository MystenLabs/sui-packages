module 0x5d7badf86f51bba99c3f0c5581a289caf3c5a0ed1b51b0147946b42539081e3d::dvd_authority {
    struct GovernorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct OperatorCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        operator_address: address,
        timestamp: u64,
    }

    struct OperatorCapRevokedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        operator_address: address,
        timestamp: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GovernorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OperatorCapsBag{
            id   : 0x2::object::new(arg0),
            caps : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<OperatorCapsBag>(v1);
    }

    public(friend) fun is_valid_operator(arg0: &OperatorCap, arg1: address, arg2: &OperatorCapsBag) {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg2.caps, arg1), 1);
        assert!(*0x2::table::borrow<address, 0x2::object::ID>(&arg2.caps, arg1) == 0x2::object::id<OperatorCap>(arg0), 2);
    }

    public fun issue_operator_cap(arg0: &GovernorCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<OperatorCap>(&v0);
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.caps, arg2, v1);
        let v2 = OperatorCapIssuedEvent{
            cap_id           : v1,
            operator_address : 0x2::tx_context::sender(arg4),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v2);
    }

    public fun revoke_operator_cap(arg0: &GovernorCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID) {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.caps, arg2), 0);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg1.caps, arg2);
        let v0 = OperatorCapRevokedEvent{
            cap_id           : arg4,
            operator_address : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperatorCapRevokedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

