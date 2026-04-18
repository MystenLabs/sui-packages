module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata {
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
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::force_remove_metadata(arg0, arg1);
    }

    public fun get_metadata(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID) : (0x1::string::String, u64) {
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::has_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid(arg0), arg1), 6001);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::get_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid(arg0), arg1)
    }

    public fun has_metadata(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID) : bool {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::has_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid(arg0), arg1)
    }

    public fun remove_metadata(arg0: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg0, arg1));
        assert!(v0 == 0x2::tx_context::sender(arg2), 6000);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::has_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid(arg0), arg1), 6001);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::force_remove_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid_mut(arg0), arg1);
        let v1 = MetadataRemoved{
            polygon_id : arg1,
            owner      : v0,
        };
        0x2::event::emit<MetadataRemoved>(v1);
    }

    public fun set_metadata(arg0: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) <= 128, 6002);
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg0, arg1));
        assert!(v0 == 0x2::tx_context::sender(arg3), 6000);
        let v1 = 0x2::tx_context::epoch(arg3);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata_store::upsert_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid_mut(arg0), arg1, arg2, v1);
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

