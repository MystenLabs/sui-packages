module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store {
    struct MetadataKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
    }

    struct MetadataState has drop, store {
        cid: 0x1::string::String,
        updated_epoch: u64,
    }

    public(friend) fun force_remove_metadata(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = MetadataKey{polygon_id: arg1};
        if (0x2::dynamic_field::exists_<MetadataKey>(arg0, v0)) {
            0x2::dynamic_field::remove<MetadataKey, MetadataState>(arg0, v0);
        };
    }

    public(friend) fun get_metadata(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : (0x1::string::String, u64) {
        let v0 = MetadataKey{polygon_id: arg1};
        let v1 = 0x2::dynamic_field::borrow<MetadataKey, MetadataState>(arg0, v0);
        (v1.cid, v1.updated_epoch)
    }

    public(friend) fun has_metadata(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        let v0 = MetadataKey{polygon_id: arg1};
        0x2::dynamic_field::exists_<MetadataKey>(arg0, v0)
    }

    public(friend) fun upsert_metadata(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        let v0 = MetadataKey{polygon_id: arg1};
        if (0x2::dynamic_field::exists_<MetadataKey>(arg0, v0)) {
            0x2::dynamic_field::remove<MetadataKey, MetadataState>(arg0, v0);
        };
        let v1 = MetadataState{
            cid           : arg2,
            updated_epoch : arg3,
        };
        0x2::dynamic_field::add<MetadataKey, MetadataState>(arg0, v0, v1);
    }

    // decompiled from Move bytecode v7
}

