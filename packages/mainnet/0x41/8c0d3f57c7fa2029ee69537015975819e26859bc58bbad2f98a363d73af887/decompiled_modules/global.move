module 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global {
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

