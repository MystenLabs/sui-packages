module 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::authority {
    struct Authority has store {
        whitelist: 0x2::linked_table::LinkedTable<address, bool>,
    }

    public fun new(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : Authority {
        let v0 = 0x2::linked_table::new<address, bool>(arg1);
        if (0x1::vector::is_empty<address>(&arg0)) {
            abort 0
        };
        while (!0x1::vector::is_empty<address>(&arg0)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg0);
            if (!0x2::linked_table::contains<address, bool>(&v0, v1)) {
                0x2::linked_table::push_back<address, bool>(&mut v0, v1, true);
            };
        };
        Authority{whitelist: v0}
    }

    public fun add_authorized_user(arg0: &mut Authority, arg1: address) {
        if (!0x2::linked_table::contains<address, bool>(&arg0.whitelist, arg1)) {
            0x2::linked_table::push_back<address, bool>(&mut arg0.whitelist, arg1, true);
        };
    }

    public fun destroy(arg0: Authority) {
        let Authority { whitelist: v0 } = arg0;
        while (0x2::linked_table::length<address, bool>(&v0) > 0) {
            let (_, _) = 0x2::linked_table::pop_front<address, bool>(&mut v0);
        };
        0x2::linked_table::destroy_empty<address, bool>(v0);
    }

    public fun remove_authorized_user(arg0: &mut Authority, arg1: address) {
        if (0x2::linked_table::contains<address, bool>(&arg0.whitelist, arg1)) {
            0x2::linked_table::remove<address, bool>(&mut arg0.whitelist, arg1);
        };
        if (0x2::linked_table::is_empty<address, bool>(&arg0.whitelist)) {
            abort 0
        };
    }

    public fun verify(arg0: &Authority, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::linked_table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg1))
    }

    public fun whitelist(arg0: &Authority) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::linked_table::front<address, bool>(&arg0.whitelist);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = 0x1::option::borrow<address>(v1);
            0x1::vector::push_back<address>(&mut v0, *v2);
            v1 = 0x2::linked_table::next<address, bool>(&arg0.whitelist, *v2);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

