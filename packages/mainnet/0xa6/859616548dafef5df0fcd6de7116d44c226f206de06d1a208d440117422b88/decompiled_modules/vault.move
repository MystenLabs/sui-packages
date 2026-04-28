module 0xa6859616548dafef5df0fcd6de7116d44c226f206de06d1a208d440117422b88::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        card_type: 0x1::type_name::TypeName,
        cards: 0x2::bag::Bag,
        indexes: 0x2::table::Table<0x2::object::ID, u64>,
    }

    public(friend) fun length(arg0: &Vault) : u64 {
        0x2::bag::length(&arg0.cards)
    }

    public(friend) fun add<T0: store + key>(arg0: &mut Vault, arg1: T0) {
        assert!(arg0.card_type == 0x1::type_name::with_defining_ids<T0>(), 1);
        let v0 = 0x2::bag::length(&arg0.cards);
        0x2::bag::add<u64, T0>(&mut arg0.cards, v0, arg1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.indexes, 0x2::object::id<T0>(&arg1), v0);
    }

    public(friend) fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id        : 0x2::object::new(arg0),
            card_type : 0x1::type_name::with_defining_ids<T0>(),
            cards     : 0x2::bag::new(arg0),
            indexes   : 0x2::table::new<0x2::object::ID, u64>(arg0),
        }
    }

    public(friend) fun card_type(arg0: &Vault) : 0x1::type_name::TypeName {
        arg0.card_type
    }

    public(friend) fun remove_by_id<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID) : T0 {
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1);
        remove_by_index<T0>(arg0, v0)
    }

    public(friend) fun remove_by_index<T0: store + key>(arg0: &mut Vault, arg1: u64) : T0 {
        let v0 = 0x2::bag::remove<u64, T0>(&mut arg0.cards, arg1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.indexes, 0x2::object::id<T0>(&v0));
        let v1 = 0x2::bag::length(&arg0.cards);
        if (arg1 < v1) {
            let v2 = 0x2::bag::remove<u64, T0>(&mut arg0.cards, v1);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.indexes, 0x2::object::id<T0>(&v2)) = arg1;
            0x2::bag::add<u64, T0>(&mut arg0.cards, arg1, v2);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

