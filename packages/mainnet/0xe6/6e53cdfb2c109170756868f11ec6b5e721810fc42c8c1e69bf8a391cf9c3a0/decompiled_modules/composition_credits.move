module 0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_credits {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>,
    }

    fun borrow(arg0: &0x2::object::UID) : &CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, CompositionCredits>(arg0, v1)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID) : &mut CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, CompositionCredits>(arg0, v1)
    }

    public fun add_credit<T0>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T0>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T0>, arg2: &0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::Party, arg3: 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>) {
        assert!(0x1::vector::length<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>(0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::roles<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>(&arg3)) >= 1, 20);
        assert!(0x1::vector::length<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>(0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::roles<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>(&arg3)) <= 5, 30);
        let v0 = 0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::id(arg2);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T0>(arg0, arg1);
        let v2 = borrow_mut_or_init(v1);
        assert!(0x2::vec_map::length<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>(&v2.credits) < 50, 32);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>(&v2.credits, &v0), 40);
        0x2::vec_map::insert<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>(&mut v2.credits, v0, arg3);
    }

    fun borrow_mut_or_init(arg0: &mut 0x2::object::UID) : &mut CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(arg0, v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = CompositionCredits{credits: 0x2::vec_map::empty<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>()};
            0x2::dynamic_field::add<ExtensionKey, CompositionCredits>(arg0, v1, v2);
        };
        let v3 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, CompositionCredits>(arg0, v3)
    }

    public fun credits<T0>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>> {
        &borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid<T0>(arg0)).credits
    }

    public fun has_credits<T0>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T0>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid<T0>(arg0), v0)
    }

    public fun remove_credit<T0>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::Composition<T0>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::CompositionAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::composition::uid_mut<T0>(arg0, arg1);
        let v1 = borrow_mut(v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>(&v1.credits, &arg2), 52);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xe66e53cdfb2c109170756868f11ec6b5e721810fc42c8c1e69bf8a391cf9c3a0::composition_party_role::CompositionPartyRole>>(&mut v1.credits, &arg2);
    }

    // decompiled from Move bytecode v7
}

