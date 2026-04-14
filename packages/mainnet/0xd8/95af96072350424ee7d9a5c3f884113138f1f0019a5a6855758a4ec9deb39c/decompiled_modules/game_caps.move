module 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps {
    struct ExecutionBindingKey has copy, drop, store {
        pos0: address,
    }

    struct GameCapStore has key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_execution(arg0: &GameCapStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>) {
        if (0x1::option::is_none<0x2::object::ID>(&arg2)) {
            return
        };
        let v0 = ExecutionBindingKey{pos0: arg1};
        if (!0x2::dynamic_field::exists_<ExecutionBindingKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ExecutionBindingKey{pos0: arg1};
        assert!(*0x2::dynamic_field::borrow<ExecutionBindingKey, 0x2::object::ID>(&arg0.id, v1) == 0x1::option::destroy_some<0x2::object::ID>(arg2), 100);
    }

    public(friend) fun borrow_cap(arg0: &GameCapStore, arg1: address) : &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::GameCap {
        0x2::dynamic_object_field::borrow<address, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::GameCap>(&arg0.id, arg1)
    }

    public(friend) fun execution_id_from_worksheet(arg0: &0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamps(arg0);
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, v1);
            if (*v3 == b"pre_execution") {
                return 0x1::option::some<0x2::object::ID>(*v2)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0x2::object::ID>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCapStore{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GameCapStore>(v0);
    }

    public(friend) fun store_cap(arg0: &mut GameCapStore, arg1: address, arg2: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::GameCap, arg3: 0x1::option::Option<0x2::object::ID>) {
        0x2::dynamic_object_field::add<address, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::GameCap>(&mut arg0.id, arg1, arg2);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v0 = ExecutionBindingKey{pos0: arg1};
            0x2::dynamic_field::add<ExecutionBindingKey, 0x2::object::ID>(&mut arg0.id, v0, 0x1::option::destroy_some<0x2::object::ID>(arg3));
        };
    }

    // decompiled from Move bytecode v7
}

