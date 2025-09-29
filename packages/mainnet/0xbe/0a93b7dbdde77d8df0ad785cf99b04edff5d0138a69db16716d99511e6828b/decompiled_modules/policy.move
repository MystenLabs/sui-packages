module 0xbe0a93b7dbdde77d8df0ad785cf99b04edff5d0138a69db16716d99511e6828b::policy {
    struct AllowList has store, key {
        id: 0x2::object::UID,
        members: vector<address>,
    }

    public entry fun add_member(arg0: &mut AllowList, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.members, arg1);
    }

    public entry fun create_allowlist_shared(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowList{
            id      : 0x2::object::new(arg0),
            members : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<AllowList>(v0);
    }

    public entry fun seal_approve_read(arg0: vector<u8>, arg1: &AllowList, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg1.members)) {
            if (*0x1::vector::borrow<address>(&arg1.members, v0) == 0x2::tx_context::sender(arg2)) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 1);
    }

    // decompiled from Move bytecode v6
}

