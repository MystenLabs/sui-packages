module 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::relayer_fees {
    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: u16, arg2: u64) {
        assert!(arg1 != 0 && arg1 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::foreign_contracts::has(arg0, arg1), 2);
        0x2::table::add<u16, u64>(borrow_table_mut(arg0), arg1, arg2);
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<u16, u64>>(arg0, b"relayer_fees", 0x2::table::new<u16, u64>(arg1));
    }

    public fun has(arg0: &0x2::object::UID, arg1: u16) : bool {
        0x2::table::contains<u16, u64>(borrow_table(arg0), arg1)
    }

    fun borrow_table(arg0: &0x2::object::UID) : &0x2::table::Table<u16, u64> {
        0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<u16, u64>>(arg0, b"relayer_fees")
    }

    fun borrow_table_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::table::Table<u16, u64> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<u16, u64>>(arg0, b"relayer_fees")
    }

    public fun token_fee(arg0: &0x2::object::UID, arg1: u16, arg2: u8, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = (0x2::math::pow(10, arg2) as u256) * (usd_fee(arg0, arg1) as u256) * (arg4 as u256) / (arg3 as u256) * (arg5 as u256);
        assert!(v0 <= 18446744073709551614, 3);
        (v0 as u64)
    }

    public(friend) fun update(arg0: &mut 0x2::object::UID, arg1: u16, arg2: u64) {
        *0x2::table::borrow_mut<u16, u64>(borrow_table_mut(arg0), arg1) = arg2;
    }

    public fun usd_fee(arg0: &0x2::object::UID, arg1: u16) : u64 {
        assert!(has(arg0, arg1), 1);
        *0x2::table::borrow<u16, u64>(borrow_table(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

