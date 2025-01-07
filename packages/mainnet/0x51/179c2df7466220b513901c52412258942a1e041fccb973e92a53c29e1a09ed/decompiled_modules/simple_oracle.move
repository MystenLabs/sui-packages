module 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::simple_oracle {
    struct SimpleOracle has store, key {
        id: 0x2::object::UID,
        address: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct StoredData<T0: store> has copy, drop, store {
        value: T0,
        sequence_number: u64,
        timestamp: u64,
        identifier: 0x1::string::String,
    }

    public entry fun archive_data<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut SimpleOracle, arg1: 0x1::string::String, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.address == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1), 1);
        let v0 = 0x1::string::utf8(b"[historical] ");
        0x1::string::append(&mut v0, arg1);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<T0, StoredData<T1>>>(&mut arg0.id, arg1, 0x2::table::new<T0, StoredData<T1>>(arg3));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<T0, StoredData<T1>>>(&mut arg0.id, arg1);
        if (0x2::table::contains<T0, StoredData<T1>>(v1, arg2)) {
            0x2::table::remove<T0, StoredData<T1>>(v1, arg2);
        };
        0x2::table::add<T0, StoredData<T1>>(v1, arg2, *0x2::dynamic_field::borrow_mut<0x1::string::String, StoredData<T1>>(&mut arg0.id, arg1));
    }

    public entry fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleOracle{
            id          : 0x2::object::new(arg3),
            address     : 0x2::tx_context::sender(arg3),
            name        : arg0,
            description : arg2,
            url         : arg1,
        };
        0x2::transfer::share_object<SimpleOracle>(v0);
    }

    public fun get_historical_data<T0: copy + drop + store, T1: copy + store>(arg0: &SimpleOracle, arg1: 0x1::string::String, arg2: T0) : 0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T1>> {
        let v0 = 0x1::string::utf8(b"[historical] ");
        0x1::string::append(&mut v0, arg1);
        let StoredData {
            value           : v1,
            sequence_number : v2,
            timestamp       : v3,
            identifier      : v4,
        } = *0x2::table::borrow<T0, StoredData<T1>>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<T0, StoredData<T1>>>(&arg0.id, arg1), arg2);
        0x1::option::some<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T1>>(0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::new<T1>(v1, arg1, v2, v3, arg0.address, v4))
    }

    public fun get_latest_data<T0: copy + store>(arg0: &SimpleOracle, arg1: 0x1::string::String) : 0x1::option::Option<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>> {
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            return 0x1::option::none<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>()
        };
        let StoredData {
            value           : v0,
            sequence_number : v1,
            timestamp       : v2,
            identifier      : v3,
        } = *0x2::dynamic_field::borrow<0x1::string::String, StoredData<T0>>(&arg0.id, arg1);
        0x1::option::some<0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::Data<T0>>(0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data::new<T0>(v0, arg1, v1, v2, arg0.address, v3))
    }

    public entry fun submit_data<T0: copy + drop + store>(arg0: &mut SimpleOracle, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: T0, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.address == 0x2::tx_context::sender(arg5), 0);
        let v0 = 0x2::dynamic_field::remove_if_exists<0x1::string::String, StoredData<T0>>(&mut arg0.id, arg2);
        let v1 = if (0x1::option::is_some<StoredData<T0>>(&v0)) {
            0x1::option::destroy_some<StoredData<T0>>(v0);
            0x1::option::borrow<StoredData<T0>>(&v0).sequence_number + 1
        } else {
            0x1::option::destroy_none<StoredData<T0>>(v0);
            0
        };
        let v2 = StoredData<T0>{
            value           : arg3,
            sequence_number : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg1),
            identifier      : arg4,
        };
        0x2::dynamic_field::add<0x1::string::String, StoredData<T0>>(&mut arg0.id, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

