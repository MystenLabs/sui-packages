module 0x2f558fcd835a9c328309a66db292f0fe9e6f13bfe2d583398c4bcf7623b3ff0c::on_chain_image {
    struct Image has store, key {
        id: 0x2::object::UID,
        uploader: address,
        data: vector<u8>,
        mime_type: 0x1::string::String,
        description: 0x1::string::String,
        is_encrypted: bool,
        kdf_salt: vector<u8>,
        kdf_rounds: u64,
        nonce: vector<u8>,
        size_bytes: u64,
        chunk_count: u64,
        created_at_ms: u64,
    }

    struct UploadSession has store, key {
        id: 0x2::object::UID,
        uploader: address,
        data: vector<u8>,
        mime_type: 0x1::string::String,
        description: 0x1::string::String,
        is_encrypted: bool,
        kdf_salt: vector<u8>,
        kdf_rounds: u64,
        nonce: vector<u8>,
        size_bytes: u64,
        chunk_count: u64,
        created_at_ms: u64,
    }

    struct UploadStarted has copy, drop {
        session_id: address,
        uploader: address,
        encrypted: bool,
    }

    struct ChunkAppended has copy, drop {
        session_id: address,
        uploader: address,
        chunk_size: u64,
        total_size: u64,
        chunk_count: u64,
    }

    struct UploadCanceled has copy, drop {
        session_id: address,
        uploader: address,
        total_size: u64,
        chunk_count: u64,
    }

    struct ImageUploaded has copy, drop {
        id: address,
        uploader: address,
        encrypted: bool,
        size_bytes: u64,
        chunk_count: u64,
    }

    struct ImageDeleted has copy, drop {
        id: address,
        uploader: address,
    }

    public fun append_chunk(arg0: &mut UploadSession, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.uploader == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v0 <= 16000, 5);
        let v1 = arg0.size_bytes + v0;
        assert!(v1 <= 8000000, 3);
        0x1::vector::append<u8>(&mut arg0.data, arg1);
        arg0.size_bytes = v1;
        arg0.chunk_count = arg0.chunk_count + 1;
        let v2 = ChunkAppended{
            session_id  : 0x2::object::id_address<UploadSession>(arg0),
            uploader    : arg0.uploader,
            chunk_size  : v0,
            total_size  : v1,
            chunk_count : arg0.chunk_count,
        };
        0x2::event::emit<ChunkAppended>(v2);
    }

    public fun cancel_upload(arg0: UploadSession, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.uploader == 0x2::tx_context::sender(arg1), 1);
        let UploadSession {
            id            : v0,
            uploader      : v1,
            data          : _,
            mime_type     : _,
            description   : _,
            is_encrypted  : _,
            kdf_salt      : _,
            kdf_rounds    : _,
            nonce         : _,
            size_bytes    : v9,
            chunk_count   : v10,
            created_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v12 = UploadCanceled{
            session_id  : 0x2::object::id_address<UploadSession>(&arg0),
            uploader    : v1,
            total_size  : v9,
            chunk_count : v10,
        };
        0x2::event::emit<UploadCanceled>(v12);
    }

    public fun delete_image(arg0: Image, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.uploader == 0x2::tx_context::sender(arg1), 1);
        let Image {
            id            : v0,
            uploader      : v1,
            data          : _,
            mime_type     : _,
            description   : _,
            is_encrypted  : _,
            kdf_salt      : _,
            kdf_rounds    : _,
            nonce         : _,
            size_bytes    : _,
            chunk_count   : _,
            created_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v12 = ImageDeleted{
            id       : 0x2::object::id_address<Image>(&arg0),
            uploader : v1,
        };
        0x2::event::emit<ImageDeleted>(v12);
    }

    public fun finalize_upload(arg0: UploadSession, arg1: &mut 0x2::tx_context::TxContext) : Image {
        let UploadSession {
            id            : v0,
            uploader      : v1,
            data          : v2,
            mime_type     : v3,
            description   : v4,
            is_encrypted  : v5,
            kdf_salt      : v6,
            kdf_rounds    : v7,
            nonce         : v8,
            size_bytes    : v9,
            chunk_count   : v10,
            created_at_ms : v11,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 1);
        assert!(v9 > 0, 2);
        0x2::object::delete(v0);
        let v12 = Image{
            id            : 0x2::object::new(arg1),
            uploader      : v1,
            data          : v2,
            mime_type     : v3,
            description   : v4,
            is_encrypted  : v5,
            kdf_salt      : v6,
            kdf_rounds    : v7,
            nonce         : v8,
            size_bytes    : v9,
            chunk_count   : v10,
            created_at_ms : v11,
        };
        let v13 = ImageUploaded{
            id          : 0x2::object::id_address<Image>(&v12),
            uploader    : v1,
            encrypted   : v5,
            size_bytes  : v9,
            chunk_count : v10,
        };
        0x2::event::emit<ImageUploaded>(v13);
        v12
    }

    public fun set_description(arg0: &mut Image, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.uploader == 0x2::tx_context::sender(arg2), 1);
        arg0.description = arg1;
    }

    public fun start_upload(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: bool, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : UploadSession {
        if (arg2) {
            assert!(0x1::vector::length<u8>(&arg3) >= 16, 6);
            assert!(arg4 >= 200000, 7);
            assert!(0x1::vector::length<u8>(&arg5) == 12, 8);
        } else {
            assert!(0x1::vector::length<u8>(&arg3) == 0, 6);
            assert!(arg4 == 0, 6);
            assert!(0x1::vector::length<u8>(&arg5) == 0, 6);
        };
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = UploadSession{
            id            : 0x2::object::new(arg6),
            uploader      : v0,
            data          : 0x1::vector::empty<u8>(),
            mime_type     : arg0,
            description   : arg1,
            is_encrypted  : arg2,
            kdf_salt      : arg3,
            kdf_rounds    : arg4,
            nonce         : arg5,
            size_bytes    : 0,
            chunk_count   : 0,
            created_at_ms : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        let v2 = UploadStarted{
            session_id : 0x2::object::id_address<UploadSession>(&v1),
            uploader   : v0,
            encrypted  : arg2,
        };
        0x2::event::emit<UploadStarted>(v2);
        v1
    }

    public fun upload_image(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Image {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 0, 2);
        assert!(v0 <= 8000000, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Image{
            id            : 0x2::object::new(arg3),
            uploader      : v1,
            data          : arg0,
            mime_type     : arg1,
            description   : arg2,
            is_encrypted  : false,
            kdf_salt      : 0x1::vector::empty<u8>(),
            kdf_rounds    : 0,
            nonce         : 0x1::vector::empty<u8>(),
            size_bytes    : v0,
            chunk_count   : 1,
            created_at_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        let v3 = ImageUploaded{
            id          : 0x2::object::id_address<Image>(&v2),
            uploader    : v1,
            encrypted   : false,
            size_bytes  : v0,
            chunk_count : 1,
        };
        0x2::event::emit<ImageUploaded>(v3);
        v2
    }

    public fun upload_image_encrypted(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Image {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 0, 2);
        assert!(v0 <= 8000000, 3);
        assert!(0x1::vector::length<u8>(&arg3) >= 16, 6);
        assert!(arg4 >= 200000, 7);
        assert!(0x1::vector::length<u8>(&arg5) == 12, 8);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = Image{
            id            : 0x2::object::new(arg6),
            uploader      : v1,
            data          : arg0,
            mime_type     : arg1,
            description   : arg2,
            is_encrypted  : true,
            kdf_salt      : arg3,
            kdf_rounds    : arg4,
            nonce         : arg5,
            size_bytes    : v0,
            chunk_count   : 1,
            created_at_ms : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        let v3 = ImageUploaded{
            id          : 0x2::object::id_address<Image>(&v2),
            uploader    : v1,
            encrypted   : true,
            size_bytes  : v0,
            chunk_count : 1,
        };
        0x2::event::emit<ImageUploaded>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

