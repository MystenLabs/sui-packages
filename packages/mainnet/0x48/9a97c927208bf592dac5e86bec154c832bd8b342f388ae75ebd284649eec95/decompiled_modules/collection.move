module 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection {
    public fun assert_is_authorized(arg0: &0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManagerAdminCap, arg1: &0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManager, arg2: &0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::CollectionMetadata) {
        assert!(0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::collection_manager_admin_cap_collection_manager_id(arg0) == 0x2::object::id<0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManager>(arg1), 10001);
        assert!(0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::collection_metadata_id(arg1) == 0x2::object::id<0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::CollectionMetadata>(arg2), 10002);
    }

    public fun new<T0: key>(arg0: &0x2::package::Publisher, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::CollectionMetadata, 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManager, 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManagerAdminCap) {
        assert!(0x2::package::from_module<T0>(arg0), 10000);
        let v0 = 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::new<T0>(arg1, arg2, arg3, arg4, arg5, arg7);
        let (v1, v2) = 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::new<T0>(arg5, arg6, arg7);
        let v3 = v1;
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::uid_mut(&mut v0), b"COLLECTION_MANAGER_ID", 0x2::object::id<0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::CollectionManager>(&v3));
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_manager::uid_mut(&mut v3), b"COLLECTION_METADATA_ID", 0x2::object::id<0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata::CollectionMetadata>(&v0));
        (v0, v3, v2)
    }

    // decompiled from Move bytecode v6
}

