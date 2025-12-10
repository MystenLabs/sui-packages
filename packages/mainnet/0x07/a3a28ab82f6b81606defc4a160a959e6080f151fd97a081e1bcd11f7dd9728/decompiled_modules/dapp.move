module 0x7a3a28ab82f6b81606defc4a160a959e6080f151fd97a081e1bcd11f7dd9728::dapp {
    struct GlobalState has store, key {
        id: 0x2::object::UID,
        version: u64,
        data: vector<u8>,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalState{
            id      : 0x2::object::new(arg0),
            version : 1,
            data    : 0x1::vector::empty<u8>(),
            admin   : v0,
        };
        0x2::transfer::share_object<GlobalState>(v1);
        let v2 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun upgrade(arg0: &AdminCap, arg1: &mut GlobalState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

