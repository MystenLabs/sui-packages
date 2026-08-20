module 0x8e7c2978511ad3bc22de8d893b8493c693782512e61a3685283a27e589fca96::copyright {
    struct CopyrightRecord has key {
        id: 0x2::object::UID,
        owner_hash: 0x1::string::String,
        file_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
    }

    public fun register_copyright(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CopyrightRecord{
            id             : 0x2::object::new(arg3),
            owner_hash     : arg0,
            file_hash      : arg1,
            walrus_blob_id : arg2,
        };
        0x2::transfer::freeze_object<CopyrightRecord>(v0);
    }

    // decompiled from Move bytecode v7
}

