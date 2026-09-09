module 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::collection {
    struct Collection has store {
        name: 0x1::string::String,
        storage_mode: u8,
        next_entry_id: u64,
        entries: 0x2::table::Table<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>,
    }

    public(friend) fun add_entry(arg0: &mut Collection, arg1: 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry) : u64 {
        let v0 = arg0.next_entry_id;
        0x2::table::add<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&mut arg0.entries, v0, arg1);
        arg0.next_entry_id = v0 + 1;
        v0
    }

    public(friend) fun delete_collection(arg0: Collection) {
        let Collection {
            name          : _,
            storage_mode  : _,
            next_entry_id : _,
            entries       : v3,
        } = arg0;
        0x2::table::destroy_empty<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(v3);
    }

    public(friend) fun delete_entry(arg0: &mut Collection, arg1: u64) {
        assert!(0x2::table::contains<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&arg0.entries, arg1), 0);
        0x2::table::remove<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&mut arg0.entries, arg1);
    }

    public fun entries_length(arg0: &Collection) : u64 {
        0x2::table::length<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&arg0.entries)
    }

    public(friend) fun entry_mut(arg0: &mut Collection, arg1: u64) : &mut 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry {
        assert!(0x2::table::contains<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&arg0.entries, arg1), 0);
        0x2::table::borrow_mut<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(&mut arg0.entries, arg1)
    }

    public fun name(arg0: &Collection) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new_collection(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Collection {
        assert!(arg1 == 0 || arg1 == 1, 1);
        Collection{
            name          : arg0,
            storage_mode  : arg1,
            next_entry_id : 0,
            entries       : 0x2::table::new<u64, 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::entry::Entry>(arg2),
        }
    }

    public fun storage_mode(arg0: &Collection) : u8 {
        arg0.storage_mode
    }

    // decompiled from Move bytecode v7
}

