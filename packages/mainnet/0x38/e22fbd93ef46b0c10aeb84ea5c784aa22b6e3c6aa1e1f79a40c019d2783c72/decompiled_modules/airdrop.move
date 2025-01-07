module 0x38e22fbd93ef46b0c10aeb84ea5c784aa22b6e3c6aa1e1f79a40c019d2783c72::airdrop {
    struct Airdrop has store, key {
        id: 0x2::object::UID,
        addresses: 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::DynamicVec<address>,
    }

    struct AirdropCap has store, key {
        id: 0x2::object::UID,
        airdrop_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Airdrop, AirdropCap) {
        let v0 = Airdrop{
            id        : 0x2::object::new(arg0),
            addresses : 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::empty<address>(7900, arg0),
        };
        let v1 = AirdropCap{
            id         : 0x2::object::new(arg0),
            airdrop_id : 0x2::object::id<Airdrop>(&v0),
        };
        (v0, v1)
    }

    public(friend) fun airdrop(arg0: &mut Airdrop, arg1: &AirdropCap) : address {
        assert_cap(arg0, arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::pop<address>(&mut arg0.addresses)
    }

    public entry fun add(arg0: &mut Airdrop, arg1: &AirdropCap, arg2: address) {
        assert_cap(arg0, arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::push<address>(&mut arg0.addresses, arg2);
    }

    fun assert_cap(arg0: &Airdrop, arg1: &AirdropCap) {
        assert!(0x2::object::id<Airdrop>(arg0) == arg1.airdrop_id, 0);
    }

    public entry fun clear(arg0: &mut Airdrop, arg1: &AirdropCap) {
        assert_cap(arg0, arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::clear<address>(&mut arg0.addresses);
    }

    // decompiled from Move bytecode v6
}

