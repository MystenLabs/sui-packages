module 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value {
    struct Entry<T0: store> has copy, drop, store {
        value: T0,
    }

    struct StorageValue<T0: store> has store {
        contents: vector<Entry<T0>>,
    }

    public fun borrow<T0: store>(arg0: &StorageValue<T0>) : &T0 {
        assert!(contains<T0>(arg0), 0);
        &0x1::vector::borrow<Entry<T0>>(&arg0.contents, 0).value
    }

    public fun borrow_mut<T0: store>(arg0: &mut StorageValue<T0>) : &mut T0 {
        assert!(contains<T0>(arg0), 0);
        &mut 0x1::vector::borrow_mut<Entry<T0>>(&mut arg0.contents, 0).value
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut StorageValue<T0>) {
        if (contains<T0>(arg0)) {
            0x1::vector::remove<Entry<T0>>(&mut arg0.contents, 0);
        };
    }

    public fun contains<T0: store>(arg0: &StorageValue<T0>) : bool {
        0x1::vector::length<Entry<T0>>(&arg0.contents) == 1
    }

    public fun get<T0: copy + drop + store>(arg0: &StorageValue<T0>) : T0 {
        assert!(contains<T0>(arg0), 0);
        0x1::vector::borrow<Entry<T0>>(&arg0.contents, 0).value
    }

    public fun new<T0: store>() : StorageValue<T0> {
        StorageValue<T0>{contents: 0x1::vector::empty<Entry<T0>>()}
    }

    public fun put<T0: store>(arg0: &mut StorageValue<T0>, arg1: T0) {
        assert!(!contains<T0>(arg0), 1);
        let v0 = Entry<T0>{value: arg1};
        0x1::vector::push_back<Entry<T0>>(&mut arg0.contents, v0);
    }

    public fun set<T0: copy + drop + store>(arg0: &mut StorageValue<T0>, arg1: T0) {
        if (contains<T0>(arg0)) {
            *borrow_mut<T0>(arg0) = arg1;
        } else {
            let v0 = Entry<T0>{value: arg1};
            0x1::vector::push_back<Entry<T0>>(&mut arg0.contents, v0);
        };
    }

    public fun take<T0: store>(arg0: &mut StorageValue<T0>) : T0 {
        assert!(contains<T0>(arg0), 0);
        let Entry { value: v0 } = 0x1::vector::remove<Entry<T0>>(&mut arg0.contents, 0);
        v0
    }

    public fun try_get<T0: copy + drop + store>(arg0: &StorageValue<T0>) : 0x1::option::Option<T0> {
        if (contains<T0>(arg0)) {
            0x1::option::some<T0>(0x1::vector::borrow<Entry<T0>>(&arg0.contents, 0).value)
        } else {
            0x1::option::none<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

