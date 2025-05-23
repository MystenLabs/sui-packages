module 0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::authority {
    struct GovernorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct OperatorCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct OperatorCapRevokedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GovernorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OperatorCapsBag{
            id   : 0x2::object::new(arg0),
            caps : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<OperatorCapsBag>(v1);
    }

    public(friend) fun is_operator(arg0: &OperatorCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<OperatorCap>(arg0)), 1);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<OperatorCap>(arg0)), 2);
    }

    public fun issue_operator_cap(arg0: &GovernorCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<OperatorCap>(&v0);
        0x2::transfer::public_transfer<OperatorCap>(v0, arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.caps, v1, true);
        let v2 = OperatorCapIssuedEvent{
            cap_id    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v2);
    }

    public fun revoke_operator_cap(arg0: &GovernorCap, arg1: &mut OperatorCapsBag, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, arg3), 0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.caps, arg3) = false;
        let v0 = OperatorCapRevokedEvent{
            cap_id    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OperatorCapRevokedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

