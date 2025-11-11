module 0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::user_profile {
    struct UserProfile has key {
        id: 0x2::object::UID,
        owner: address,
        username: 0x1::string::String,
        avatar_url: 0x1::string::String,
        updated_at: u64,
        created_at: u64,
        rooms_joined: vector<0x2::object::ID>,
    }

    struct UserProfileRegistry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct UserProfileCreatedEvent has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
    }

    struct UserProfileUpdatedEvent has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
    }

    struct UserProfileDeletedEvent has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
    }

    public(friend) fun add_user_profile_rooms_joined(arg0: &mut UserProfile, arg1: 0x2::object::ID) {
        if (!0x1::vector::contains<0x2::object::ID>(&arg0.rooms_joined, &arg1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.rooms_joined, arg1);
        };
    }

    public fun create_user_profile(arg0: &mut UserProfileRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.users, v0), 2);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = UserProfile{
            id           : v1,
            owner        : v0,
            username     : arg1,
            avatar_url   : arg2,
            updated_at   : v3,
            created_at   : v3,
            rooms_joined : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.users, v0, v2);
        0x2::transfer::transfer<UserProfile>(v4, v0);
        let v5 = UserProfileCreatedEvent{
            owner      : v0,
            profile_id : v2,
        };
        0x2::event::emit<UserProfileCreatedEvent>(v5);
    }

    public fun delete_user_profile(arg0: &mut UserProfileRegistry, arg1: UserProfile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 1);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.users, v0), 3);
        let UserProfile {
            id           : v1,
            owner        : _,
            username     : _,
            avatar_url   : _,
            updated_at   : _,
            created_at   : _,
            rooms_joined : _,
        } = arg1;
        let v8 = v1;
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.users, v0);
        0x2::object::delete(v8);
        let v9 = UserProfileDeletedEvent{
            owner      : v0,
            profile_id : 0x2::object::uid_to_inner(&v8),
        };
        0x2::event::emit<UserProfileDeletedEvent>(v9);
    }

    public fun get_user_profile_rooms_joined(arg0: &UserProfile) : vector<0x2::object::ID> {
        arg0.rooms_joined
    }

    public fun get_user_profile_username(arg0: &UserProfile) : 0x1::string::String {
        arg0.username
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserProfileRegistry{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<UserProfileRegistry>(v0);
    }

    public fun update_user_profile(arg0: &mut UserProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.owner == v0, 1);
        arg0.username = arg1;
        arg0.avatar_url = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v1 = UserProfileUpdatedEvent{
            owner      : v0,
            profile_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<UserProfileUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

