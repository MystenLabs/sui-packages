module 0xc9259a764774079b56742c311722e39390bd50850a632270f03ea040de6bf205::user {
    struct User has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        profile_image_id: 0x1::string::String,
        bio: 0x1::string::String,
        created_at: u64,
    }

    struct UserList has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, address>,
    }

    public fun create_user(arg0: &mut UserList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, address>(&arg0.users, v0), 0);
        let v1 = User{
            id               : 0x2::object::new(arg5),
            name             : arg1,
            profile_image_id : arg2,
            bio              : arg3,
            created_at       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<address, address>(&mut arg0.users, v0, 0x2::object::uid_to_address(&v1.id));
        0x2::transfer::public_transfer<User>(v1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserList{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<UserList>(v0);
    }

    public(friend) fun users(arg0: &UserList) : &0x2::table::Table<address, address> {
        &arg0.users
    }

    // decompiled from Move bytecode v6
}

