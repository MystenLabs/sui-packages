module 0xad6000e8078594c123c94017ada887feaa6a2a6e4581de376ac9bd42b13511d3::authority {
    struct Authority has store {
        whitelist: 0x2::linked_table::LinkedTable<address, bool>,
    }

    public fun destroy_empty(arg0: Authority, arg1: &0x2::tx_context::TxContext) {
        verify(&arg0, arg1);
        let Authority { whitelist: v0 } = arg0;
        0x2::linked_table::destroy_empty<address, bool>(v0);
    }

    public fun new(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : Authority {
        let v0 = 0x2::linked_table::new<address, bool>(arg1);
        if (0x1::vector::is_empty<address>(&arg0)) {
            abort 1
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

    public fun destroy(arg0: Authority, arg1: &0x2::tx_context::TxContext) {
        verify(&arg0, arg1);
        let Authority { whitelist: v0 } = arg0;
        while (0x2::linked_table::length<address, bool>(&v0) > 0) {
            let (_, _) = 0x2::linked_table::pop_front<address, bool>(&mut v0);
        };
        0x2::linked_table::destroy_empty<address, bool>(v0);
    }

    public fun double_verify(arg0: &Authority, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::linked_table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg2)) || 0x2::linked_table::contains<address, bool>(&arg1.whitelist, 0x2::tx_context::sender(arg2)), 0);
    }

    public fun remove_all(arg0: &mut Authority, arg1: &0x2::tx_context::TxContext) : vector<address> {
        verify(arg0, arg1);
        let v0 = 0x1::vector::empty<address>();
        while (0x2::linked_table::length<address, bool>(&arg0.whitelist) > 0) {
            let (v1, _) = 0x2::linked_table::pop_front<address, bool>(&mut arg0.whitelist);
            0x1::vector::push_back<address>(&mut v0, v1);
        };
        v0
    }

    public fun remove_authorized_user(arg0: &mut Authority, arg1: address) {
        if (0x2::linked_table::contains<address, bool>(&arg0.whitelist, arg1)) {
            0x2::linked_table::remove<address, bool>(&mut arg0.whitelist, arg1);
        };
    }

    public fun verify(arg0: &Authority, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::linked_table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg1)), 0);
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

