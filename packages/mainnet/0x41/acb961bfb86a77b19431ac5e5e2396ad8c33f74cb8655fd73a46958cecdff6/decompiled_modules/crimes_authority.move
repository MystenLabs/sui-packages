module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority {
    struct CrimesCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameOperatorCap has store, key {
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
        let v0 = CrimesCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CrimesCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun initialize_cap_bag(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCapsBag{
            id   : 0x2::object::new(arg1),
            caps : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<OperatorCapsBag>(v0);
    }

    public(friend) fun is_operator(arg0: &GameOperatorCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 1);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 2);
    }

    entry fun issue_operator_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GameOperatorCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<GameOperatorCap>(&v0);
        0x2::transfer::public_transfer<GameOperatorCap>(v0, arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.caps, v1, true);
        let v2 = OperatorCapIssuedEvent{
            cap_id    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v2);
    }

    entry fun revoke_operator_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) {
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

