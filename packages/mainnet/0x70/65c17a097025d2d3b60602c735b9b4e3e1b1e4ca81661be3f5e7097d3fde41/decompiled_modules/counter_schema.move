module 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_schema {
    struct Counter has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_mut_value(arg0: &mut Counter) : &mut 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_mut_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&mut arg0.id, b"value")
    }

    public fun borrow_value(arg0: &Counter) : &0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32> {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::borrow_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&arg0.id, b"value")
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        let v0 = 0x2::object::new(arg0);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration::add_field<0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::StorageValue<u32>>(&mut v0, b"value", 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::new<u32>());
        Counter{id: v0}
    }

    public fun get_value(arg0: &Counter) : &u32 {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow<u32>(borrow_value(arg0))
    }

    public fun migrate(arg0: &mut Counter, arg1: &0x2::package::UpgradeCap) {
    }

    // decompiled from Move bytecode v6
}

