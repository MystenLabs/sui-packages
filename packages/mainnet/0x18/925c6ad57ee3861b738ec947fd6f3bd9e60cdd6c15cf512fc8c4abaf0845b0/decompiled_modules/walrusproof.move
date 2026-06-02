module 0x18925c6ad57ee3861b738ec947fd6f3bd9e60cdd6c15cf512fc8c4abaf0845b0::walrusproof {
    struct ProjectProof has store, key {
        id: 0x2::object::UID,
        metadata_blob_id: 0x1::string::String,
        thumbnail_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        tags: vector<0x1::string::String>,
        author: address,
        created_at: u64,
    }

    struct DeveloperProfile has store, key {
        id: 0x2::object::UID,
        profile_blob_id: 0x1::string::String,
        display_name: 0x1::string::String,
        owner: address,
        updated_at: u64,
    }

    struct ProjectProofCreated has copy, drop {
        object_id: address,
        author: address,
        metadata_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        created_at: u64,
    }

    struct ProfileUpdated has copy, drop {
        author: address,
        profile_blob_id: 0x1::string::String,
        updated_at: u64,
    }

    public entry fun create_project(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::utf8(arg2);
        assert!(0x1::string::length(&v0) > 0, 1);
        assert!(0x1::string::length(&v1) > 0, 2);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v5)));
            v5 = v5 + 1;
        };
        let v6 = ProjectProof{
            id                : 0x2::object::new(arg5),
            metadata_blob_id  : v0,
            thumbnail_blob_id : 0x1::string::utf8(arg1),
            title             : v1,
            tags              : v4,
            author            : v2,
            created_at        : v3,
        };
        let v7 = ProjectProofCreated{
            object_id        : 0x2::object::uid_to_address(&v6.id),
            author           : v2,
            metadata_blob_id : v6.metadata_blob_id,
            title            : v6.title,
            created_at       : v3,
        };
        0x2::event::emit<ProjectProofCreated>(v7);
        0x2::transfer::transfer<ProjectProof>(v6, v2);
    }

    public fun get_author(arg0: &ProjectProof) : address {
        arg0.author
    }

    public fun get_created_at(arg0: &ProjectProof) : u64 {
        arg0.created_at
    }

    public fun get_metadata_blob_id(arg0: &ProjectProof) : &0x1::string::String {
        &arg0.metadata_blob_id
    }

    public fun get_title(arg0: &ProjectProof) : &0x1::string::String {
        &arg0.title
    }

    public entry fun upsert_profile(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::string::utf8(arg0);
        let v3 = ProfileUpdated{
            author          : v0,
            profile_blob_id : v2,
            updated_at      : v1,
        };
        0x2::event::emit<ProfileUpdated>(v3);
        let v4 = DeveloperProfile{
            id              : 0x2::object::new(arg3),
            profile_blob_id : v2,
            display_name    : 0x1::string::utf8(arg1),
            owner           : v0,
            updated_at      : v1,
        };
        0x2::transfer::transfer<DeveloperProfile>(v4, v0);
    }

    // decompiled from Move bytecode v7
}

