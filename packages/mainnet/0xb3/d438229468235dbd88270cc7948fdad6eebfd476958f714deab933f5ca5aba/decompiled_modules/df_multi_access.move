module 0xb3d438229468235dbd88270cc7948fdad6eebfd476958f714deab933f5ca5aba::df_multi_access {
    struct Parent has key {
        id: 0x2::object::UID,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    public fun access_once(arg0: &Parent) {
        let _ = Key{dummy_field: false};
    }

    public fun access_twice(arg0: &Parent) {
        let _ = Key{dummy_field: false};
        let _ = Key{dummy_field: false};
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
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

