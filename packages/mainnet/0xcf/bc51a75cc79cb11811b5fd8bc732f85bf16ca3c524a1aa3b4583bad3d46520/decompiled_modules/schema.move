module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema {
    struct Schema has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow_counter(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&arg0.id, b"counter")
    }

    public(friend) fun counter(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&mut arg0.id, b"counter")
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Schema {
        let v0 = 0x2::object::new(arg0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u32>>(&mut v0, b"counter", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<u32>(b"counter", arg0));
        Schema{id: v0}
    }

    public fun get_counter(arg0: &Schema) : &u32 {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u32>(borrow_counter(arg0))
    }

    public fun migrate(arg0: &mut Schema, arg1: &0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

