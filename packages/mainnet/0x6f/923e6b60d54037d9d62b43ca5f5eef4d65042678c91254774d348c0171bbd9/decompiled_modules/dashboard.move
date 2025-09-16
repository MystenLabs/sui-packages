module 0x6f923e6b60d54037d9d62b43ca5f5eef4d65042678c91254774d348c0171bbd9::dashboard {
    struct Dashboard has key {
        id: 0x2::object::UID,
        proposal_ids: vector<0x2::object::ID>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DASHBOARD has drop {
        dummy_field: bool,
    }

    public fun new(arg0: DASHBOARD, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<DASHBOARD>(&arg0), 2);
        let v0 = Dashboard{
            id           : 0x2::object::new(arg1),
            proposal_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Dashboard>(v0);
    }

    fun init(arg0: DASHBOARD, arg1: &mut 0x2::tx_context::TxContext) {
        new(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun proposal_ids(arg0: &Dashboard) : vector<0x2::object::ID> {
        arg0.proposal_ids
    }

    public fun register_proposal(arg0: &mut Dashboard, arg1: 0x2::object::ID, arg2: &AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.proposal_ids, &arg1), 0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.proposal_ids, arg1);
    }

    public fun unregister_proposal(arg0: &mut Dashboard, arg1: 0x2::object::ID, arg2: &AdminCap) {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.proposal_ids, &arg1), 1);
        let (_, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.proposal_ids, &arg1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.proposal_ids, v1);
    }

    // decompiled from Move bytecode v6
}

