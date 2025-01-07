module 0x112eae85880e71d90fe476407454d903faa996fca512041e773d858f81dbc852::custodian {
    struct Custodian<phantom T0> has store, key {
        id: 0x2::object::UID,
        num_items: u64,
    }

    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Custodian<T0> {
        Custodian<T0>{
            id        : 0x2::object::new(arg0),
            num_items : 0,
        }
    }

    public fun has_item_with_type<T0: store + key>(arg0: &Custodian<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = Item{id: arg1};
        0x2::dynamic_object_field::exists_with_type<Item, T0>(&arg0.id, v0)
    }

    public(friend) fun hold<T0: store + key>(arg0: &mut Custodian<T0>, arg1: T0) {
        arg0.num_items = arg0.num_items + 1;
        let v0 = Item{id: 0x2::object::id<T0>(&arg1)};
        0x2::dynamic_object_field::add<Item, T0>(&mut arg0.id, v0, arg1);
    }

    public fun num_items<T0>(arg0: &Custodian<T0>) : u64 {
        arg0.num_items
    }

    public(friend) fun take<T0: store + key>(arg0: &mut Custodian<T0>, arg1: 0x2::object::ID) : T0 {
        assert!(has_item_with_type<T0>(arg0, arg1), 0);
        arg0.num_items = arg0.num_items - 1;
        let v0 = Item{id: arg1};
        0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

