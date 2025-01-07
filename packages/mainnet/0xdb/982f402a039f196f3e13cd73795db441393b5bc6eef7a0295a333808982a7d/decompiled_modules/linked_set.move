module 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set {
    struct Null has drop, store {
        dummy_field: bool,
    }

    struct LinkedSet<T0: copy + drop + store> has store {
        contents: 0x2::linked_table::LinkedTable<T0, Null>,
    }

    public fun empty<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        LinkedSet<T0>{contents: 0x2::linked_table::new<T0, Null>(arg0)}
    }

    public fun length<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : u64 {
        0x2::linked_table::length<T0, Null>(&arg0.contents)
    }

    public fun push_back<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        0x2::linked_table::push_back<T0, Null>(&mut arg0.contents, arg1, null());
    }

    public fun pop_back<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>) : T0 {
        let (v0, _) = 0x2::linked_table::pop_back<T0, Null>(&mut arg0.contents);
        v0
    }

    public fun destroy_empty<T0: copy + drop + store>(arg0: LinkedSet<T0>) {
        let LinkedSet { contents: v0 } = arg0;
        0x2::linked_table::destroy_empty<T0, Null>(v0);
    }

    public fun back<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : &0x1::option::Option<T0> {
        0x2::linked_table::back<T0, Null>(&arg0.contents)
    }

    public fun contains<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : bool {
        0x2::linked_table::contains<T0, Null>(&arg0.contents, arg1)
    }

    public fun drop<T0: copy + drop + store>(arg0: LinkedSet<T0>) {
        let LinkedSet { contents: v0 } = arg0;
        0x2::linked_table::drop<T0, Null>(v0);
    }

    public fun front<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : &0x1::option::Option<T0> {
        0x2::linked_table::front<T0, Null>(&arg0.contents)
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : bool {
        0x2::linked_table::is_empty<T0, Null>(&arg0.contents)
    }

    public fun next<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : &0x1::option::Option<T0> {
        0x2::linked_table::next<T0, Null>(&arg0.contents, arg1)
    }

    public fun pop_front<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>) : T0 {
        let (v0, _) = 0x2::linked_table::pop_front<T0, Null>(&mut arg0.contents);
        v0
    }

    public fun prev<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : &0x1::option::Option<T0> {
        0x2::linked_table::prev<T0, Null>(&arg0.contents, arg1)
    }

    public fun push_front<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        0x2::linked_table::push_front<T0, Null>(&mut arg0.contents, arg1, null());
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        0x2::linked_table::remove<T0, Null>(&mut arg0.contents, arg1);
    }

    public fun clone<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        partial_clone<T0>(arg0, length<T0>(arg0), false, arg1)
    }

    public fun difference<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: &LinkedSet<T0>, arg2: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        let v0 = empty<T0>(arg2);
        let v1 = front<T0>(arg0);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            if (!contains<T0>(arg1, v2)) {
                let v3 = &mut v0;
                push_back<T0>(v3, v2);
            };
            v1 = next<T0>(arg0, v2);
        };
        v0
    }

    public fun from_vector<T0: copy + drop + store>(arg0: &vector<T0>, arg1: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        let v0 = empty<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            let v2 = &mut v0;
            push_back<T0>(v2, *0x1::vector::borrow<T0>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun intersection<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: &LinkedSet<T0>, arg2: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        let v0 = empty<T0>(arg2);
        let v1 = front<T0>(arg0);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            if (contains<T0>(arg1, v2)) {
                let v3 = &mut v0;
                push_back<T0>(v3, v2);
            };
            v1 = next<T0>(arg0, v2);
        };
        v0
    }

    public fun into_vector<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = front<T0>(arg0);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            0x1::vector::push_back<T0>(&mut v0, v2);
            v1 = next<T0>(arg0, v2);
        };
        v0
    }

    fun null() : Null {
        Null{dummy_field: false}
    }

    public fun partial_clone<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        let v0 = empty<T0>(arg3);
        let v1 = front<T0>(arg0);
        let v2 = 0;
        while (0x1::option::is_some<T0>(v1) && v2 < arg1) {
            let v3 = *0x1::option::borrow<T0>(v1);
            if (!arg2) {
                let v4 = &mut v0;
                push_back<T0>(v4, v3);
            } else {
                let v5 = &mut v0;
                push_front<T0>(v5, v3);
            };
            v1 = next<T0>(arg0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun union<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: &LinkedSet<T0>, arg2: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        let v0 = clone<T0>(arg0, arg2);
        let v1 = front<T0>(arg1);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            if (!contains<T0>(&v0, v2)) {
                let v3 = &mut v0;
                push_back<T0>(v3, v2);
            };
            v1 = next<T0>(arg1, v2);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

