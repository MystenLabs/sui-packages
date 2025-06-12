module 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::global {
    struct GlobalInfo has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : GlobalInfo {
        GlobalInfo{id: 0x2::object::new(arg0)}
    }

    public(friend) fun share_object(arg0: GlobalInfo) {
        0x2::transfer::share_object<GlobalInfo>(arg0);
    }

    public(friend) fun add_object_raw(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1), 0);
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_shared_object_id<T0: key>(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: &T0) {
        add_object_raw(arg0, arg1, 0x2::object::id<T0>(arg2));
    }

    public(friend) fun uid(arg0: &GlobalInfo) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut GlobalInfo) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

