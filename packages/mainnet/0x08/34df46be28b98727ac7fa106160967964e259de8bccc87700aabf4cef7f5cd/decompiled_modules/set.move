module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::set {
    struct Empty has drop, store {
        dummy_field: bool,
    }

    struct Set<phantom T0: copy + drop + store> has store {
        items: 0x2::table::Table<T0, Empty>,
    }

    public fun add<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) {
        assert!(!contains<T0>(arg0, arg1), 0);
        let v0 = Empty{dummy_field: false};
        0x2::table::add<T0, Empty>(&mut arg0.items, arg1, v0);
    }

    public fun contains<T0: copy + drop + store>(arg0: &Set<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, Empty>(&arg0.items, arg1)
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Set<T0> {
        Set<T0>{items: 0x2::table::new<T0, Empty>(arg0)}
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) {
        assert!(contains<T0>(arg0, arg1), 1);
        0x2::table::remove<T0, Empty>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

