module 0x3d9d930cd1107f89d1f6416dd3be7db999519203ab9ae8957636aca9ce9311b2::blob_index {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct BlobMetadata has store, key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        created_at: u64,
    }

    struct BlobIndexed has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        blob_id: 0x1::string::String,
    }

    struct BlobUpdated has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BlobDeleted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        blob_id: 0x1::string::String,
    }

    struct ResponseMetadata has store, key {
        id: 0x2::object::UID,
        owner: address,
        form_blob_id: 0x1::string::String,
        response_blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct ResponseIndexed has copy, drop {
        object_id: 0x2::object::ID,
        form_blob_id: 0x1::string::String,
        response_blob_id: 0x1::string::String,
    }

    entry fun add_admin(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::contains<address>(&arg1.admins, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        };
    }

    entry fun delete_blob(arg0: BlobMetadata, arg1: &mut 0x2::tx_context::TxContext) {
        let BlobMetadata {
            id          : v0,
            owner       : v1,
            blob_id     : v2,
            name        : _,
            description : _,
            created_at  : _,
        } = arg0;
        let v6 = v0;
        let v7 = BlobDeleted{
            object_id : 0x2::object::uid_to_inner(&v6),
            owner     : v1,
            blob_id   : v2,
        };
        0x2::event::emit<BlobDeleted>(v7);
        0x2::object::delete(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = AdminRegistry{
            id     : 0x2::object::new(arg0),
            admins : v2,
        };
        0x2::transfer::share_object<AdminRegistry>(v3);
    }

    entry fun register_blob(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = BlobMetadata{
            id          : v0,
            owner       : v1,
            blob_id     : arg0,
            name        : arg1,
            description : arg2,
            created_at  : arg3,
        };
        let v3 = BlobIndexed{
            object_id : 0x2::object::uid_to_inner(&v0),
            owner     : v1,
            blob_id   : arg0,
        };
        0x2::event::emit<BlobIndexed>(v3);
        0x2::transfer::transfer<BlobMetadata>(v2, v1);
    }

    entry fun register_response(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = ResponseMetadata{
            id               : v0,
            owner            : arg0,
            form_blob_id     : arg1,
            response_blob_id : arg2,
            created_at       : arg3,
        };
        let v2 = ResponseIndexed{
            object_id        : 0x2::object::uid_to_inner(&v0),
            form_blob_id     : arg1,
            response_blob_id : arg2,
        };
        0x2::event::emit<ResponseIndexed>(v2);
        0x2::transfer::transfer<ResponseMetadata>(v1, arg0);
    }

    entry fun remove_admin(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.admins, v1);
        };
    }

    entry fun update_blob(arg0: &mut BlobMetadata, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        let v0 = BlobUpdated{
            object_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner       : 0x2::tx_context::sender(arg3),
            blob_id     : arg0.blob_id,
            name        : arg1,
            description : arg2,
        };
        0x2::event::emit<BlobUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

