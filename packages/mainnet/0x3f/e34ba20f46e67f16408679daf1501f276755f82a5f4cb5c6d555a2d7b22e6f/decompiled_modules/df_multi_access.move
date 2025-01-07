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

    struct AccessOnceEvent has copy, drop {
        value1: u64,
    }

    struct AccessTwiceEvent has copy, drop {
        value1: u64,
        value2: u64,
    }

    struct AccessNTimesEvent has copy, drop {
        n: u64,
        total: u128,
    }

    public fun access_n_different_dynamic_fields(arg0: &Parent, arg1: u64, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 <= arg2) {
            v1 = v1 + (0x2::dynamic_field::borrow<u64, Child>(&arg0.id, v0 + arg1).value as u128);
            v0 = v0 + 1;
        };
        let v2 = AccessNTimesEvent{
            n     : arg2,
            total : v1,
        };
        0x2::event::emit<AccessNTimesEvent>(v2);
    }

    public fun access_n_times(arg0: &Parent, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 <= arg1) {
            let v2 = Key{dummy_field: false};
            v1 = v1 + (0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v2).value as u128);
            v0 = v0 + 1;
        };
        let v3 = AccessNTimesEvent{
            n     : arg1,
            total : v1,
        };
        0x2::event::emit<AccessNTimesEvent>(v3);
    }

    public fun access_n_times_v2(arg0: &Parent, arg1: u64, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 <= arg1) {
            v1 = v1 + (0x2::dynamic_field::borrow<u64, Child>(&arg0.id, arg2).value as u128);
            v0 = v0 + 1;
        };
        let v2 = AccessNTimesEvent{
            n     : arg1,
            total : v1,
        };
        0x2::event::emit<AccessNTimesEvent>(v2);
    }

    public fun access_once(arg0: &Parent) {
        let v0 = Key{dummy_field: false};
        let v1 = AccessOnceEvent{value1: 0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v0).value};
        0x2::event::emit<AccessOnceEvent>(v1);
    }

    public fun access_once_and_add_n_times(arg0: &Parent, arg1: u64) {
        let v0 = Key{dummy_field: false};
        let v1 = 0;
        let v2 = 0;
        while (v1 <= arg1) {
            v2 = v2 + (0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v0).value as u128);
            v1 = v1 + 1;
        };
        let v3 = AccessNTimesEvent{
            n     : arg1,
            total : v2,
        };
        0x2::event::emit<AccessNTimesEvent>(v3);
    }

    public fun access_twice(arg0: &Parent) {
        let v0 = Key{dummy_field: false};
        let v1 = Key{dummy_field: false};
        let v2 = AccessTwiceEvent{
            value1 : 0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v0).value,
            value2 : 0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v1).value,
        };
        0x2::event::emit<AccessTwiceEvent>(v2);
    }

    public fun add_n_dynamic_fields(arg0: &mut Parent, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 <= arg2) {
            let v1 = Child{
                id    : 0x2::object::new(arg3),
                value : 42,
            };
            0x2::dynamic_field::add<u64, Child>(&mut arg0.id, v0 + arg1, v1);
            v0 = v0 + 1;
        };
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

