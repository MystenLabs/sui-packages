module 0xe30ec5c0ca20d5ad9b7a555613f1ddd7a117770ca71c036660628f7e150dc648::video {
    struct Video has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        title: vector<u8>,
        description: vector<u8>,
        thumbnail_blob_id: vector<u8>,
        visibility: u8,
        forever_price_microusdc: u64,
        rental_price_microusdc: u64,
        rental_duration_ms: u64,
        expiry_epoch: u64,
    }

    public fun register_video(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Video{
            id                      : 0x2::object::new(arg10),
            version                 : 1,
            owner                   : v0,
            blob_id                 : arg0,
            blob_object_id          : arg1,
            title                   : arg2,
            description             : arg3,
            thumbnail_blob_id       : arg4,
            visibility              : arg5,
            forever_price_microusdc : arg6,
            rental_price_microusdc  : arg7,
            rental_duration_ms      : arg8,
            expiry_epoch            : arg9,
        };
        0x2::transfer::transfer<Video>(v1, v0);
    }

    public fun set_visibility(arg0: &mut Video, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.visibility = arg1;
    }

    public fun soft_remove(arg0: &mut Video, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.visibility = 3;
    }

    public fun update_expiry(arg0: &mut Video, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.expiry_epoch = arg1;
    }

    public fun update_metadata(arg0: &mut Video, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.title = arg1;
        arg0.description = arg2;
        arg0.thumbnail_blob_id = arg3;
    }

    // decompiled from Move bytecode v6
}

