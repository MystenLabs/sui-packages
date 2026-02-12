module 0xe9da1c76bbe155c3fd0cc2720f05eb06775ae0e0ec352438ec4c78b293816c32::user_registry {
    struct UserRegistry has key {
        id: 0x2::object::UID,
    }

    struct UserProfile has copy, drop, store {
        public_key: vector<u8>,
        registered_at: u64,
    }

    struct UserRegistered has copy, drop {
        user: address,
        timestamp: u64,
    }

    public fun get_profile(arg0: &UserRegistry, arg1: address) : UserProfile {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, arg1), 1);
        *0x2::dynamic_field::borrow<address, UserProfile>(&arg0.id, arg1)
    }

    public fun get_public_key(arg0: &UserRegistry, arg1: address) : vector<u8> {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, arg1), 1);
        0x2::dynamic_field::borrow<address, UserProfile>(&arg0.id, arg1).public_key
    }

    public fun has_registered(arg0: &UserRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<UserRegistry>(v0);
    }

    public fun register_user(arg0: &mut UserRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = UserProfile{
            public_key    : arg1,
            registered_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::dynamic_field::add<address, UserProfile>(&mut arg0.id, v0, v1);
        let v2 = UserRegistered{
            user      : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UserRegistered>(v2);
    }

    // decompiled from Move bytecode v6
}

