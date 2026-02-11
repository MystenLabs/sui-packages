module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::profiles {
    struct ViewerProfile has key {
        id: 0x2::object::UID,
        owner: address,
        watch_history: 0x2::table::Table<0x2::object::ID, u64>,
        created_ms: u64,
    }

    struct CreatorProfile has key {
        id: 0x2::object::UID,
        owner: address,
        handle: vector<u8>,
        bio: vector<u8>,
        avatar_blob_id: vector<u8>,
        created_ms: u64,
    }

    struct ViewerCreated has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
    }

    struct CreatorCreated has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
        handle: vector<u8>,
    }

    entry fun create_creator(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = CreatorProfile{
            id             : 0x2::object::new(arg4),
            owner          : v0,
            handle         : arg0,
            bio            : arg1,
            avatar_blob_id : arg2,
            created_ms     : arg3,
        };
        0x2::transfer::transfer<CreatorProfile>(v1, v0);
        let v2 = CreatorCreated{
            owner      : v0,
            profile_id : 0x2::object::id<CreatorProfile>(&v1),
            handle     : v1.handle,
        };
        0x2::event::emit<CreatorCreated>(v2);
    }

    entry fun create_viewer(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ViewerProfile{
            id            : 0x2::object::new(arg1),
            owner         : v0,
            watch_history : 0x2::table::new<0x2::object::ID, u64>(arg1),
            created_ms    : arg0,
        };
        0x2::transfer::transfer<ViewerProfile>(v1, v0);
        let v2 = ViewerCreated{
            owner      : v0,
            profile_id : 0x2::object::id<ViewerProfile>(&v1),
        };
        0x2::event::emit<ViewerCreated>(v2);
    }

    entry fun update_watch(arg0: &mut ViewerProfile, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.watch_history, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.watch_history, arg1) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.watch_history, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

