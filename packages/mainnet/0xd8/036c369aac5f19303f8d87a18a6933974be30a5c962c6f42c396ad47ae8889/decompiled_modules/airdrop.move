module 0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop {
    struct Airdrop has store, key {
        id: 0x2::object::UID,
        addresses: 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::DynamicVec<address>,
    }

    struct AirdropCap has store, key {
        id: 0x2::object::UID,
        airdrop_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Airdrop, AirdropCap) {
        let v0 = Airdrop{
            id        : 0x2::object::new(arg0),
            addresses : 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::empty<address>(7900, arg0),
        };
        let v1 = AirdropCap{
            id         : 0x2::object::new(arg0),
            airdrop_id : 0x2::object::id<Airdrop>(&v0),
        };
        (v0, v1)
    }

    public entry fun clear(arg0: &mut Airdrop, arg1: &AirdropCap) {
        assert_cap(arg0, arg1);
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::clear<address>(&mut arg0.addresses);
    }

    public(friend) fun airdrop(arg0: &mut Airdrop, arg1: &AirdropCap) : address {
        assert_cap(arg0, arg1);
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::pop<address>(&mut arg0.addresses)
    }

    public entry fun add(arg0: &mut Airdrop, arg1: &AirdropCap, arg2: address) {
        assert_cap(arg0, arg1);
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::push<address>(&mut arg0.addresses, arg2);
    }

    fun assert_cap(arg0: &Airdrop, arg1: &AirdropCap) {
        assert!(0x2::object::id<Airdrop>(arg0) == arg1.airdrop_id, 0);
    }

    // decompiled from Move bytecode v6
}

