module 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global {
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

    public(friend) fun update_object_raw(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: 0x2::object::ID) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, 0x2::object::ID>(&mut arg0.id, arg1);
        add_object_raw(arg0, arg1, arg2);
    }

    public(friend) fun update_shared_object_id<T0: key>(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: &T0) {
        update_object_raw(arg0, arg1, 0x2::object::id<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

