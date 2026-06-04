module 0x62aea664bb9246385964f43ee0ebc87d1024e4ab6c59e47f70402f1550cd0927::vouch {
    struct VouchProject has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        tagline: 0x1::string::String,
        category: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_hash: 0x1::string::String,
        latest_version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
        active: bool,
    }

    struct VouchVersion has copy, drop, store {
        version_number: u64,
        manifest_blob_id: 0x1::string::String,
        manifest_hash: 0x1::string::String,
        note: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ProjectCreated has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        title: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_hash: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ProjectUpdated has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        version_number: u64,
        manifest_blob_id: 0x1::string::String,
        manifest_hash: 0x1::string::String,
        updated_at_ms: u64,
    }

    public entry fun create_project(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = VouchProject{
            id               : 0x2::object::new(arg6),
            owner            : v0,
            title            : arg0,
            tagline          : arg1,
            category         : arg2,
            manifest_blob_id : arg3,
            manifest_hash    : arg4,
            latest_version   : 1,
            created_at_ms    : v1,
            updated_at_ms    : v1,
            active           : true,
        };
        let v3 = ProjectCreated{
            project_id       : 0x2::object::id<VouchProject>(&v2),
            owner            : v0,
            title            : v2.title,
            manifest_blob_id : v2.manifest_blob_id,
            manifest_hash    : v2.manifest_hash,
            created_at_ms    : v1,
        };
        0x2::event::emit<ProjectCreated>(v3);
        0x2::transfer::public_transfer<VouchProject>(v2, v0);
    }

    public entry fun deactivate_project(arg0: &mut VouchProject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.active = false;
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(&arg0) >= v2, 2);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v3) == *0x1::vector::borrow<u8>(&v1, v3), 2);
            v3 = v3 + 1;
        };
    }

    public entry fun update_project(arg0: &mut VouchProject, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.owner == v0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        arg0.latest_version = arg0.latest_version + 1;
        arg0.manifest_blob_id = arg1;
        arg0.manifest_hash = arg2;
        arg0.updated_at_ms = v1;
        VouchVersion{version_number: arg0.latest_version, manifest_blob_id: arg0.manifest_blob_id, manifest_hash: arg0.manifest_hash, note: arg3, created_at_ms: v1};
        let v2 = ProjectUpdated{
            project_id       : 0x2::object::id<VouchProject>(arg0),
            owner            : v0,
            version_number   : arg0.latest_version,
            manifest_blob_id : arg0.manifest_blob_id,
            manifest_hash    : arg0.manifest_hash,
            updated_at_ms    : v1,
        };
        0x2::event::emit<ProjectUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

