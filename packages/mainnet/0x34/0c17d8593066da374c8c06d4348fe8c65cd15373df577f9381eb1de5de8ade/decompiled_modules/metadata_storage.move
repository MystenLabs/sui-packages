module 0x340c17d8593066da374c8c06d4348fe8c65cd15373df577f9381eb1de5de8ade::metadata_storage {
    struct MetadataStorage has key {
        id: 0x2::object::UID,
        metadata: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        total_stored: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MetadataAdded has copy, drop {
        metadata_id: u64,
        trait_count: u64,
    }

    struct BatchMetadataAdded has copy, drop {
        start_id: u64,
        end_id: u64,
        count: u64,
    }

    public fun add_metadata(arg0: &mut MetadataStorage, arg1: &AdminCap, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 5555, 1);
        assert!(!0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg2), 1);
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.metadata, arg2, arg3);
        arg0.total_stored = arg0.total_stored + 1;
        let v0 = MetadataAdded{
            metadata_id : arg2,
            trait_count : 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&arg3),
        };
        0x2::event::emit<MetadataAdded>(v0);
    }

    public fun add_metadata_batch(arg0: &mut MetadataStorage, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg3), 3);
        assert!(v0 <= 100, 3);
        let v1 = if (v0 > 0) {
            *0x1::vector::borrow<u64>(&arg2, 0)
        } else {
            0
        };
        let v2 = if (v0 > 0) {
            *0x1::vector::borrow<u64>(&arg2, v0 - 1)
        } else {
            0
        };
        let v3 = 0;
        while (v3 < v0) {
            add_metadata(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v3), *0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg3, v3), arg4);
            v3 = v3 + 1;
        };
        let v4 = BatchMetadataAdded{
            start_id : v1,
            end_id   : v2,
            count    : v0,
        };
        0x2::event::emit<BatchMetadataAdded>(v4);
    }

    public fun get_all_ids(arg0: &MetadataStorage) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 1;
        while (v1 <= 5555) {
            if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, v1)) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_metadata(arg0: &MetadataStorage, arg1: u64) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg1), 2);
        0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg1)
    }

    public fun get_metadata_copy(arg0: &MetadataStorage, arg1: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg1), 2);
        *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg1)
    }

    public fun get_total_stored(arg0: &MetadataStorage) : u64 {
        arg0.total_stored
    }

    public fun get_trait(arg0: &MetadataStorage, arg1: u64, arg2: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(get_metadata(arg0, arg1), &arg2)
    }

    public fun get_trait_names(arg0: &MetadataStorage, arg1: u64) : vector<0x1::string::String> {
        let (v0, _) = 0x2::vec_map::into_keys_values<0x1::string::String, 0x1::string::String>(*get_metadata(arg0, arg1));
        v0
    }

    public fun has_trait(arg0: &MetadataStorage, arg1: u64, arg2: 0x1::string::String) : bool {
        if (!metadata_exists(arg0, arg1)) {
            return false
        };
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(get_metadata(arg0, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetadataStorage{
            id           : 0x2::object::new(arg0),
            metadata     : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0),
            total_stored : 0,
            admin        : 0x2::tx_context::sender(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetadataStorage>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun metadata_exists(arg0: &MetadataStorage, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg1)
    }

    public fun update_metadata(arg0: &mut MetadataStorage, arg1: &AdminCap, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.metadata, arg2), 2);
        0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.metadata, arg2);
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.metadata, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

