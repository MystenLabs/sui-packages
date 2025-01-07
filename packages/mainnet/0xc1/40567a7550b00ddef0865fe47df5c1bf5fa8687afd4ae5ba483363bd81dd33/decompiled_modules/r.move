module 0xc140567a7550b00ddef0865fe47df5c1bf5fa8687afd4ae5ba483363bd81dd33::r {
    struct K has copy, drop, store {
        v: 0x1::type_name::TypeName,
    }

    struct V has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public entry fun r<T0>(arg0: &mut 0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::super_account::Treasury, arg1: &mut V, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = K{v: v0};
        if (!0x2::dynamic_field::exists_<K>(&mut arg1.id, v1)) {
            let v2 = K{v: v0};
            0x2::dynamic_field::add<K, 0x2::balance::Balance<T0>>(&mut arg1.id, v2, 0x2::balance::zero<T0>());
        };
        let v3 = K{v: v0};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<K, 0x2::balance::Balance<T0>>(&mut arg1.id, v3), 0x2::coin::into_balance<T0>(0x4159d62befea3676e860c73c8926840d53431826a0b2a70d476809672b0ecd83::super_account::withdraw<T0>(arg0, arg2, arg3)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = V{
            id    : 0x2::object::new(arg0),
            owner : @0xcb2b38d6dbba9667f20aa6659d0af1ea6b2345b428c30f757862e01d2ed1c1b1,
        };
        0x2::transfer::share_object<V>(v0);
    }

    public entry fun t(arg0: &mut V, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
    }

    public entry fun w<T0>(arg0: &mut V, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = K{v: 0x1::type_name::get<T0>()};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<K, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

