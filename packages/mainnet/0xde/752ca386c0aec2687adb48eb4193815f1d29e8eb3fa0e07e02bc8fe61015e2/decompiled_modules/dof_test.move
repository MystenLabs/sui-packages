module 0xde752ca386c0aec2687adb48eb4193815f1d29e8eb3fa0e07e02bc8fe61015e2::dof_test {
    struct TestNft has store, key {
        id: 0x2::object::UID,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        list: vector<TestNft>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::empty<TestNft>(),
        };
        0x2::transfer::public_transfer<Store>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_to_dof(arg0: &mut Store, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNft{id: 0x2::object::new(arg1)};
        0x1::debug::print<TestNft>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, TestNft>(&mut arg0.id, 0x2::object::id<TestNft>(&v0), v0);
    }

    public fun mint_to_vector(arg0: &mut Store, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNft{id: 0x2::object::new(arg1)};
        0x1::vector::push_back<TestNft>(&mut arg0.list, v0);
    }

    // decompiled from Move bytecode v6
}

