module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::nullifier_registry {
    struct NullifierRegistry has key {
        id: 0x2::object::UID,
        nullifiers: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct NullifierSpent has copy, drop {
        nullifier: vector<u8>,
    }

    public fun contains(arg0: &NullifierRegistry, arg1: &vector<u8>) : bool {
        0x2::vec_set::contains<vector<u8>>(&arg0.nullifiers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NullifierRegistry{
            id         : 0x2::object::new(arg0),
            nullifiers : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<NullifierRegistry>(v0);
    }

    public fun len(arg0: &NullifierRegistry) : u64 {
        0x2::vec_set::length<vector<u8>>(&arg0.nullifiers)
    }

    public(friend) entry fun spend(arg0: &mut NullifierRegistry, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.nullifiers, &arg1), 1);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.nullifiers, arg1);
        let v0 = NullifierSpent{nullifier: arg1};
        0x2::event::emit<NullifierSpent>(v0);
    }

    // decompiled from Move bytecode v7
}

