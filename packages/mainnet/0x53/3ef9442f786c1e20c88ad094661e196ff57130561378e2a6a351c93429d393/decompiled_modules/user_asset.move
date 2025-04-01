module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user_asset {
    struct UserAsset has store, key {
        id: 0x2::object::UID,
        owner: address,
        walrus_blob_id: 0x1::string::String,
        user_id: 0x1::string::String,
        file_path: 0x1::string::String,
        file_type: 0x1::string::String,
        file_size: u64,
        created_at: u64,
    }

    public(friend) fun delete_asset(arg0: UserAsset) {
        let UserAsset {
            id             : v0,
            owner          : _,
            walrus_blob_id : _,
            user_id        : _,
            file_path      : _,
            file_type      : _,
            file_size      : _,
            created_at     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_file_path(arg0: &UserAsset) : 0x1::string::String {
        arg0.file_path
    }

    public fun get_file_size(arg0: &UserAsset) : u64 {
        arg0.file_size
    }

    public fun get_file_type(arg0: &UserAsset) : 0x1::string::String {
        arg0.file_type
    }

    public fun get_id(arg0: &UserAsset) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_user_id(arg0: &UserAsset) : 0x1::string::String {
        arg0.user_id
    }

    public fun get_walrus_blob_id(arg0: &UserAsset) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public(friend) fun new_user_asset(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : UserAsset {
        UserAsset{
            id             : 0x2::object::new(arg6),
            owner          : arg0,
            walrus_blob_id : arg1,
            user_id        : arg2,
            file_path      : arg3,
            file_type      : arg4,
            file_size      : arg5,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg6),
        }
    }

    // decompiled from Move bytecode v6
}

