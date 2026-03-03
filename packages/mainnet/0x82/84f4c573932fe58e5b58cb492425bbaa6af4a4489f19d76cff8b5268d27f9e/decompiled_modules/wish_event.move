module 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::wish_event {
    struct NewWishCreated<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishFulfilled<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishCancelled<T0: copy + drop> has copy, drop {
        payload: T0,
    }

    struct ObjectMigrated has copy, drop {
        what: u8,
        new_version: u64,
        who: address,
    }

    public(friend) fun emit_cancel_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = WishCancelled<T0>{payload: arg0};
        0x2::event::emit<WishCancelled<T0>>(v0);
    }

    public(friend) fun emit_fulfill_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = WishFulfilled<T0>{inner: arg0};
        0x2::event::emit<WishFulfilled<T0>>(v0);
    }

    public(friend) fun emit_new_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = NewWishCreated<T0>{inner: arg0};
        0x2::event::emit<NewWishCreated<T0>>(v0);
    }

    public(friend) fun emit_object_migrated(arg0: u8, arg1: u64, arg2: address) {
        let v0 = ObjectMigrated{
            what        : arg0,
            new_version : arg1,
            who         : arg2,
        };
        0x2::event::emit<ObjectMigrated>(v0);
    }

    // decompiled from Move bytecode v6
}

