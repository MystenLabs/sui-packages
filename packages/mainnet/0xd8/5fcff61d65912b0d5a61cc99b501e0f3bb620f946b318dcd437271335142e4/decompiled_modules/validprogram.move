module 0xd85fcff61d65912b0d5a61cc99b501e0f3bb620f946b318dcd437271335142e4::validprogram {
    struct Whitelist has key {
        id: 0x2::object::UID,
        creator: address,
        approved_ids: vector<0x2::object::ID>,
    }

    public entry fun add_to_whitelist(arg0: &mut Whitelist, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.approved_ids, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Whitelist{
            id           : 0x2::object::new(arg0),
            creator      : v0,
            approved_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<Whitelist>(v1, v0);
    }

    public fun is_valid(arg0: &Whitelist, arg1: &0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.approved_ids, arg1)
    }

    // decompiled from Move bytecode v6
}

