module 0xffc0dc48299849fd5908430f2be338a9d07e7a91c2a5457c82050f5bb490ddaf::denylist_rule {
    struct Denylist has store, key {
        id: 0x2::object::UID,
        denied: vector<address>,
    }

    public entry fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Denylist{
            id     : 0x2::object::new(arg0),
            denied : 0x1::vector::empty<address>(),
        };
        0x2::transfer::transfer<Denylist>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun add_to_denylist(arg0: &mut Denylist, arg1: address) {
        if (!0x1::vector::contains<address>(&arg0.denied, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.denied, arg1);
        };
    }

    public fun is_denied(arg0: &Denylist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.denied, &arg1)
    }

    public entry fun remove_from_denylist(arg0: &mut Denylist, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.denied, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.denied, v1);
        };
    }

    // decompiled from Move bytecode v6
}

