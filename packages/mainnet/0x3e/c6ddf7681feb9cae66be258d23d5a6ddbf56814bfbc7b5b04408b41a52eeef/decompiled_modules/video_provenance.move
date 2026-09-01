module 0xc4eccf348d780c496e994e14f6e34128fbc135d8a6c971e42db12e9aa2182b4e::video_provenance {
    struct VIDEO_PROVENANCE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        admin: address,
        anchored_videos: 0x2::table::Table<address, bool>,
        total_videos: u64,
    }

    struct VideoAnchor has store, key {
        id: 0x2::object::UID,
        video_id: vector<u8>,
        video_key: address,
        source_sha256: vector<u8>,
        attestation_digest: vector<u8>,
        walrus_blob_id: vector<u8>,
        walrus_blob_object_id: vector<u8>,
        captured_at_ms: u64,
        server_verified_at_ms: u64,
        app_id: vector<u8>,
    }

    struct VideoAnchored has copy, drop {
        registry_id: 0x2::object::ID,
        anchor_id: 0x2::object::ID,
        video_id: vector<u8>,
        source_sha256: vector<u8>,
        attestation_digest: vector<u8>,
        walrus_blob_id: vector<u8>,
        captured_at_ms: u64,
        server_verified_at_ms: u64,
        app_id: vector<u8>,
    }

    entry fun anchor_video(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, 0x2::tx_context::sender(arg11));
        assert_hash(&arg4);
        assert_hash(&arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.anchored_videos, arg3), 3);
        0x2::table::add<address, bool>(&mut arg0.anchored_videos, arg3, true);
        arg0.total_videos = arg0.total_videos + 1;
        let v0 = VideoAnchor{
            id                    : 0x2::object::new(arg11),
            video_id              : arg2,
            video_key             : arg3,
            source_sha256         : arg4,
            attestation_digest    : arg5,
            walrus_blob_id        : arg6,
            walrus_blob_object_id : arg7,
            captured_at_ms        : arg8,
            server_verified_at_ms : arg9,
            app_id                : arg10,
        };
        let v1 = VideoAnchored{
            registry_id           : 0x2::object::id<Registry>(arg0),
            anchor_id             : 0x2::object::id<VideoAnchor>(&v0),
            video_id              : clone_bytes(&v0.video_id),
            source_sha256         : clone_bytes(&v0.source_sha256),
            attestation_digest    : clone_bytes(&v0.attestation_digest),
            walrus_blob_id        : clone_bytes(&v0.walrus_blob_id),
            captured_at_ms        : arg8,
            server_verified_at_ms : arg9,
            app_id                : clone_bytes(&v0.app_id),
        };
        0x2::event::emit<VideoAnchored>(v1);
        0x2::transfer::share_object<VideoAnchor>(v0);
    }

    fun assert_admin(arg0: &AdminCap, arg1: address) {
        assert!(arg0.admin == arg1, 1);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: VIDEO_PROVENANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Registry{
            id              : 0x2::object::new(arg1),
            admin           : v0,
            anchored_videos : 0x2::table::new<address, bool>(arg1),
            total_videos    : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    public entry fun rotate_admin(arg0: &mut Registry, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert!(arg0.admin == v0, 1);
        arg1.admin = arg2;
        arg0.admin = arg2;
    }

    // decompiled from Move bytecode v7
}

