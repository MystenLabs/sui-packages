module 0x94c1a4d5afb5af523cafea5d7bdfa338b11f4be237a91812c09d9ce62e667000::blob_metadata {
    struct BlobMetadata has store, key {
        id: 0x2::object::UID,
        blob_object_id: address,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
        uploaded_at: u64,
        size: u64,
    }

    struct BLOB_METADATA has drop {
        dummy_field: bool,
    }

    public entry fun create(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BlobMetadata{
            id             : 0x2::object::new(arg6),
            blob_object_id : arg0,
            blob_id        : arg1,
            name           : arg2,
            content_type   : arg3,
            uploaded_at    : arg5,
            size           : arg4,
        };
        0x2::transfer::public_transfer<BlobMetadata>(v0, 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: BLOB_METADATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BLOB_METADATA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Metadata for Walrus Blob {blob_id}"));
        let v5 = 0x2::display::new_with_fields<BlobMetadata>(&v0, v1, v3, arg1);
        0x2::display::update_version<BlobMetadata>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlobMetadata>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

