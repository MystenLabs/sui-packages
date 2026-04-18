module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata {
    struct MetadataSet has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        cid: 0x1::string::String,
        epoch: u64,
    }

    struct MetadataRemoved has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
    }

    public(friend) fun force_remove_metadata(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::force_remove_metadata(arg0, arg1);
    }

    public fun get_metadata(arg0: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg1: 0x2::object::ID) : (0x1::string::String, u64) {
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::has_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid(arg0), arg1), 6001);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::get_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid(arg0), arg1)
    }

    public fun has_metadata(arg0: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg1: 0x2::object::ID) : bool {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::has_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid(arg0), arg1)
    }

    public fun remove_metadata(arg0: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg0, arg1));
        assert!(v0 == 0x2::tx_context::sender(arg2), 6000);
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::has_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid(arg0), arg1), 6001);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::force_remove_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid_mut(arg0), arg1);
        let v1 = MetadataRemoved{
            polygon_id : arg1,
            owner      : v0,
        };
        0x2::event::emit<MetadataRemoved>(v1);
    }

    public fun set_metadata(arg0: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) <= 128, 6002);
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg0, arg1));
        assert!(v0 == 0x2::tx_context::sender(arg3), 6000);
        let v1 = 0x2::tx_context::epoch(arg3);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::metadata_store::upsert_metadata(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::uid_mut(arg0), arg1, arg2, v1);
        let v2 = MetadataSet{
            polygon_id : arg1,
            owner      : v0,
            cid        : arg2,
            epoch      : v1,
        };
        0x2::event::emit<MetadataSet>(v2);
    }

    // decompiled from Move bytecode v7
}

