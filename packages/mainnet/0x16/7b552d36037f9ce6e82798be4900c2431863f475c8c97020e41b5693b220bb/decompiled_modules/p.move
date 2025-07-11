module 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p {
    struct A has store {
        a: 0x2::linked_table::LinkedTable<address, u128>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : A {
        A{a: 0x2::linked_table::new<address, u128>(arg0)}
    }

    public fun remove(arg0: &mut A, arg1: address) {
        if (0x2::linked_table::contains<address, u128>(&arg0.a, arg1)) {
            0x2::linked_table::remove<address, u128>(&mut arg0.a, arg1);
        };
    }

    public fun add(arg0: &mut A, arg1: address, arg2: u128) {
        if (0x2::linked_table::contains<address, u128>(&arg0.a, arg1)) {
            *0x2::linked_table::borrow_mut<address, u128>(&mut arg0.a, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<address, u128>(&mut arg0.a, arg1, arg2);
        };
    }

    public fun has(arg0: &A, arg1: address, arg2: u8) : bool {
        0x2::linked_table::contains<address, u128>(&arg0.a, arg1) && *0x2::linked_table::borrow<address, u128>(&arg0.a, arg1) & 1 << arg2 > 0
    }

    // decompiled from Move bytecode v6
}

