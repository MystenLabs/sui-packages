module 0x1139e423b2ecefaf1fe80629f74a23f21e59f03d1618acfc4899adf0fac5ff1f::dynamic_field {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Parent has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow(arg0: &Parent) : &Child {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v0)
    }

    public fun borrow_mut(arg0: &mut Parent) : &mut Child {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, Child>(&mut arg0.id, v0)
    }

    public(friend) fun create_parent_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{id: 0x2::object::new(arg0)};
        let v1 = Child{
            id    : 0x2::object::new(arg0),
            value : 42,
        };
        let v2 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, Child>(&mut v0.id, v2, v1);
        0x2::transfer::share_object<Parent>(v0);
    }

    // decompiled from Move bytecode v6
}

