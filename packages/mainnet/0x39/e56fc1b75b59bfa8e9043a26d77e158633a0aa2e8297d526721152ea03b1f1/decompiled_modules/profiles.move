module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::profiles {
    struct ViewerProfile has key {
        id: 0x2::object::UID,
        owner: address,
        created_ms: u64,
        watch_history: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct CreatorProfile has key {
        id: 0x2::object::UID,
        owner: address,
        handle: vector<u8>,
        bio: vector<u8>,
        avatar_url: vector<u8>,
        created_ms: u64,
        verified: bool,
    }

    entry fun create_creator(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorProfile{
            id         : 0x2::object::new(arg4),
            owner      : 0x2::tx_context::sender(arg4),
            handle     : arg0,
            bio        : arg1,
            avatar_url : arg2,
            created_ms : 0x2::clock::timestamp_ms(arg3),
            verified   : false,
        };
        0x2::transfer::transfer<CreatorProfile>(v0, 0x2::tx_context::sender(arg4));
    }

    entry fun create_viewer(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ViewerProfile{
            id            : 0x2::object::new(arg1),
            owner         : 0x2::tx_context::sender(arg1),
            created_ms    : 0x2::clock::timestamp_ms(arg0),
            watch_history : 0x2::table::new<0x2::object::ID, u64>(arg1),
        };
        0x2::transfer::transfer<ViewerProfile>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_handle(arg0: &CreatorProfile) : vector<u8> {
        arg0.handle
    }

    public fun is_verified(arg0: &CreatorProfile) : bool {
        arg0.verified
    }

    entry fun record_watch(arg0: &mut ViewerProfile, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.watch_history, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.watch_history, arg1);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.watch_history, arg1, arg2);
    }

    entry fun update_creator_avatar(arg0: &mut CreatorProfile, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.avatar_url = arg1;
    }

    entry fun update_creator_bio(arg0: &mut CreatorProfile, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.bio = arg1;
    }

    // decompiled from Move bytecode v6
}

