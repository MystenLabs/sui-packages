module 0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::generic_store {
    struct GenericCoinTypeStorage<phantom T0: store> has store {
        table: 0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::WitTable<GenericTable, 0x1::type_name::TypeName, T0>,
    }

    struct GenericTable has drop {
        dummy_field: bool,
    }

    public fun is_empty<T0: store>(arg0: &GenericCoinTypeStorage<T0>) : bool {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::is_empty<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table)
    }

    public fun keys<T0: store>(arg0: &GenericCoinTypeStorage<T0>) : vector<0x1::type_name::TypeName> {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::keys<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table)
    }

    public fun load<T0: store, T1>(arg0: &GenericCoinTypeStorage<T0>) : &T0 {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::borrow<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table, 0x1::type_name::get<T1>())
    }

    public fun load_by_type<T0: store>(arg0: &GenericCoinTypeStorage<T0>, arg1: 0x1::type_name::TypeName) : &T0 {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::borrow<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table, arg1)
    }

    public fun load_mut_by_type<T0: store>(arg0: &mut GenericCoinTypeStorage<T0>, arg1: 0x1::type_name::TypeName) : &mut T0 {
        let v0 = GenericTable{dummy_field: false};
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::borrow_mut<GenericTable, 0x1::type_name::TypeName, T0>(v0, &mut arg0.table, arg1)
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : GenericCoinTypeStorage<T0> {
        let v0 = GenericTable{dummy_field: false};
        GenericCoinTypeStorage<T0>{table: 0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::new<GenericTable, 0x1::type_name::TypeName, T0>(v0, true, arg0)}
    }

    public fun remove<T0: store, T1>(arg0: &mut GenericCoinTypeStorage<T0>) : T0 {
        let v0 = GenericTable{dummy_field: false};
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::remove<GenericTable, 0x1::type_name::TypeName, T0>(v0, &mut arg0.table, 0x1::type_name::get<T1>())
    }

    public fun store<T0: store, T1>(arg0: &mut GenericCoinTypeStorage<T0>, arg1: T0) {
        let v0 = GenericTable{dummy_field: false};
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::add<GenericTable, 0x1::type_name::TypeName, T0>(v0, &mut arg0.table, 0x1::type_name::get<T1>(), arg1);
    }

    public fun supports<T0: store, T1>(arg0: &GenericCoinTypeStorage<T0>) : bool {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::contains<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table, 0x1::type_name::get<T1>())
    }

    public fun supports_type<T0: store>(arg0: &GenericCoinTypeStorage<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x6f6205f246a55b1c1966fdd1fe82c6137db1f62bc8f227ce27d57a36061cef52::wit_table::contains<GenericTable, 0x1::type_name::TypeName, T0>(&arg0.table, arg1)
    }

    // decompiled from Move bytecode v6
}

