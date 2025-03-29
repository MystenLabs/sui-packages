module 0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::user {
    struct UserList has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, address>,
    }

    struct User has key {
        id: 0x2::object::UID,
        owner_address: address,
        username: 0x1::string::String,
        image: 0x1::string::String,
        bio: 0x1::string::String,
        created_at: u64,
        posts: 0x2::table_vec::TableVec<UserPost>,
    }

    struct UserPost has copy, store {
        post_address: address,
    }

    struct UserActivity {
        user: User,
    }

    public fun create_new_user(arg0: &mut UserList, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : UserActivity {
        let v0 = User{
            id            : 0x2::object::new(arg5),
            owner_address : 0x2::tx_context::sender(arg5),
            username      : 0x1::string::utf8(arg1),
            image         : 0x1::string::utf8(arg2),
            bio           : 0x1::string::utf8(arg3),
            created_at    : 0x2::clock::timestamp_ms(arg4),
            posts         : 0x2::table_vec::empty<UserPost>(arg5),
        };
        0x2::table::add<address, address>(&mut arg0.users, 0x2::tx_context::sender(arg5), 0x2::object::uid_to_address(&v0.id));
        UserActivity{user: v0}
    }

    public fun create_user_activity(arg0: User) : UserActivity {
        UserActivity{user: arg0}
    }

    public fun delete_user_activity(arg0: UserActivity, arg1: &0x2::tx_context::TxContext) {
        let UserActivity { user: v0 } = arg0;
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun existing_user_activity(arg0: User) : UserActivity {
        UserActivity{user: arg0}
    }

    public fun get_posts(arg0: &User, arg1: u64, arg2: u64, arg3: bool) : (vector<UserPost>, bool, u64) {
        0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::paginator::get_page<UserPost>(&arg0.posts, arg1, arg2, arg3)
    }

    public fun get_user_address(arg0: &UserList, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, address>(&arg0.users, arg1)
        } else {
            @0x0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserList{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<UserList>(v0);
    }

    public(friend) fun record_post_creation(arg0: &mut UserActivity, arg1: address) {
        let v0 = UserPost{post_address: arg1};
        0x2::table_vec::push_back<UserPost>(&mut arg0.user.posts, v0);
    }

    // decompiled from Move bytecode v6
}

