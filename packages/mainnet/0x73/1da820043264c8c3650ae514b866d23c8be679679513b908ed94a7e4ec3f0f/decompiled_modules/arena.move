module 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena {
    struct ArenaStore has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        users: vector<address>,
        user_amounts: 0x2::table::Table<address, u64>,
        created_treasury: vector<0x1::string::String>,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArenaStore{
            id               : 0x2::object::new(arg0),
            public_key       : 0x1::vector::empty<u8>(),
            users            : 0x1::vector::empty<address>(),
            user_amounts     : 0x2::table::new<address, u64>(arg0),
            created_treasury : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<ArenaStore>(v0);
    }

    public(friend) fun is_exists(arg0: &ArenaStore, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.users, &arg1)
    }

    public(friend) fun is_valid_signature(arg0: &ArenaStore, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &arg2)
    }

    public(friend) fun remove_user(arg0: &mut ArenaStore, arg1: address) : bool {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.users, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.users, v1);
            0x2::table::remove<address, u64>(&mut arg0.user_amounts, arg1);
        };
        v0
    }

    public(friend) fun set_signer(arg0: &mut ArenaStore, arg1: vector<u8>) {
        arg0.public_key = arg1;
    }

    public(friend) fun set_treasury_id(arg0: &mut ArenaStore, arg1: 0x1::string::String) : bool {
        if (!0x1::vector::contains<0x1::string::String>(&arg0.created_treasury, &arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.created_treasury, arg1);
            return true
        };
        false
    }

    public(friend) fun set_user(arg0: &mut ArenaStore, arg1: address, arg2: u64) : u64 {
        if (!0x1::vector::contains<address>(&arg0.users, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.users, arg1);
        } else {
            0x2::table::remove<address, u64>(&mut arg0.user_amounts, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.user_amounts, arg1, arg2);
        user_count(arg0)
    }

    public(friend) fun user_amount(arg0: &ArenaStore, arg1: address) : u64 {
        if (!is_exists(arg0, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.user_amounts, arg1)
    }

    public(friend) fun user_count(arg0: &ArenaStore) : u64 {
        0x1::vector::length<address>(&arg0.users)
    }

    // decompiled from Move bytecode v6
}

