module 0xda8dc1064a489f2f39a74ed963aca8580a9b1a27ce5ead87d1eb7f31b199dcb9::whitelist {
    struct Whitelist has store, key {
        id: 0x2::object::UID,
        addresses: 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::DynamicVec<address>,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
        whitelist_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Whitelist, WhitelistCap) {
        let v0 = Whitelist{
            id        : 0x2::object::new(arg0),
            addresses : 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::empty<address>(7900, arg0),
        };
        let v1 = WhitelistCap{
            id           : 0x2::object::new(arg0),
            whitelist_id : 0x2::object::id<Whitelist>(&v0),
        };
        (v0, v1)
    }

    public entry fun clear(arg0: &mut Whitelist, arg1: &WhitelistCap) {
        assert_cap(arg0, arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::clear<address>(&mut arg0.addresses);
    }

    public entry fun add(arg0: &mut Whitelist, arg1: &WhitelistCap, arg2: address) {
        assert_cap(arg0, arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::push<address>(&mut arg0.addresses, arg2);
    }

    fun assert_cap(arg0: &Whitelist, arg1: &WhitelistCap) {
        assert!(0x2::object::id<Whitelist>(arg0) == arg1.whitelist_id, 0);
    }

    public(friend) fun exercise(arg0: &mut Whitelist, arg1: &mut 0x2::tx_context::TxContext) : address {
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::remove_value<address>(&mut arg0.addresses, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

