module 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts {
    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        assert!(arg1 != 0 && arg1 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&arg2), 1);
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(borrow_table_mut(arg0), arg1, arg2);
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>>(arg0, b"foreign_contracts", 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg1));
    }

    fun borrow_table(arg0: &0x2::object::UID) : &0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress> {
        0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>>(arg0, b"foreign_contracts")
    }

    fun borrow_table_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>>(arg0, b"foreign_contracts")
    }

    public fun contract_address(arg0: &0x2::object::UID, arg1: u16) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        assert!(has(arg0, arg1), 2);
        0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(borrow_table(arg0), arg1)
    }

    public fun has(arg0: &0x2::object::UID, arg1: u16) : bool {
        0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(borrow_table(arg0), arg1)
    }

    public(friend) fun update(arg0: &mut 0x2::object::UID, arg1: u16, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&arg2), 1);
        *0x2::table::borrow_mut<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(borrow_table_mut(arg0), arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

