module 0x2::scratch {
    struct Permit<phantom T0: copy + drop> has copy, drop {
        dummy_field: bool,
    }

    fun hash_type_and_key<T0: copy + drop>(arg0: T0) : address {
        0x2::dynamic_field::hash_type_and_key<T0>(@0x0, arg0)
    }

    public fun add<T0: copy + drop, T1: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0, arg3: T1) {
        add_impl<T1>(hash_type_and_key<T0>(arg2), arg3);
    }

    native fun add_impl<T0: drop>(arg0: address, arg1: T0);
    public fun exists<T0: copy + drop>(arg0: &0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : bool {
        exists_impl(hash_type_and_key<T0>(arg2))
    }

    native fun exists_impl(arg0: address) : bool;
    public fun exists_with_type<T0: copy + drop, T1: drop>(arg0: &0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : bool {
        exists_with_type_impl<T1>(hash_type_and_key<T0>(arg2))
    }

    native fun exists_with_type_impl<T0: drop>(arg0: address) : bool;
    public fun permit<T0: copy + drop>(arg0: 0x1::internal::Permit<T0>) : Permit<T0> {
        Permit<T0>{dummy_field: false}
    }

    public fun read<T0: copy + drop, T1: copy + drop>(arg0: &0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : T1 {
        read_impl<T1>(hash_type_and_key<T0>(arg2))
    }

    native fun read_impl<T0: copy + drop>(arg0: address) : T0;
    public fun read_opt<T0: copy + drop, T1: copy + drop>(arg0: &0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : 0x1::option::Option<T1> {
        if (exists<T0>(arg0, arg1, arg2)) {
            0x1::option::some<T1>(read<T0, T1>(arg0, arg1, arg2))
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun remove<T0: copy + drop, T1: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : T1 {
        remove_impl<T1>(hash_type_and_key<T0>(arg2))
    }

    native fun remove_impl<T0: drop>(arg0: address) : T0;
    public fun remove_opt<T0: copy + drop, T1: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0) : 0x1::option::Option<T1> {
        if (exists<T0>(arg0, arg1, arg2)) {
            0x1::option::some<T1>(remove<T0, T1>(arg0, arg1, arg2))
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun replace<T0: copy + drop, T1: drop, T2: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: Permit<T0>, arg2: T0, arg3: T1) : 0x1::option::Option<T2> {
        let v0 = remove_opt<T0, T2>(arg0, arg1, arg2);
        add<T0, T1>(arg0, arg1, arg2, arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

