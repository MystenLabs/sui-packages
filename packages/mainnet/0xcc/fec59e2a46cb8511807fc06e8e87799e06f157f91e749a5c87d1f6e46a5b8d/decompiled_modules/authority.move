module 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority {
    struct Authority<phantom T0> has store {
        whitelist: 0x2::linked_table::LinkedTable<address, bool>,
    }

    public fun destroy_empty<T0>(arg0: Authority<T0>) {
        let Authority { whitelist: v0 } = arg0;
        0x2::linked_table::destroy_empty<address, bool>(v0);
    }

    public fun new<T0>(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : Authority<T0> {
        let v0 = 0x2::linked_table::new<address, bool>(arg1);
        0x2::linked_table::push_back<address, bool>(&mut v0, 0x2::tx_context::sender(arg1), true);
        while (!0x1::vector::is_empty<address>(&arg0)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg0);
            if (!0x2::linked_table::contains<address, bool>(&v0, v1)) {
                0x2::linked_table::push_back<address, bool>(&mut v0, v1, true);
            };
        };
        Authority<T0>{whitelist: v0}
    }

    public fun add_authorized_user<T0>(arg0: &T0, arg1: &mut Authority<T0>, arg2: address) {
        if (!0x2::linked_table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::linked_table::push_back<address, bool>(&mut arg1.whitelist, arg2, true);
        };
    }

    public fun remove_all<T0>(arg0: &mut Authority<T0>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        while (0x2::linked_table::length<address, bool>(&arg0.whitelist) > 0) {
            let (v1, _) = 0x2::linked_table::pop_front<address, bool>(&mut arg0.whitelist);
            0x1::vector::push_back<address>(&mut v0, v1);
        };
        v0
    }

    public fun remove_authorized_user<T0>(arg0: &T0, arg1: &mut Authority<T0>, arg2: address) {
        if (0x2::linked_table::contains<address, bool>(&arg1.whitelist, arg2)) {
            0x2::linked_table::remove<address, bool>(&mut arg1.whitelist, arg2);
        };
    }

    public fun verify<T0>(arg0: &Authority<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::linked_table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg1)), 0);
    }

    public fun whitelist<T0>(arg0: &Authority<T0>) : vector<address> {
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

