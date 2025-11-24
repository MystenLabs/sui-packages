module 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event {
    struct NewWishCreated<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishFulfilled<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishCancelled<phantom T0: copy + drop> has copy, drop {
        dummy_field: bool,
    }

    public fun emit_cancel_wish_event<T0: copy + drop>() {
        let v0 = WishCancelled<T0>{dummy_field: false};
        0x2::event::emit<WishCancelled<T0>>(v0);
    }

    public fun emit_fulfill_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = WishFulfilled<T0>{inner: arg0};
        0x2::event::emit<WishFulfilled<T0>>(v0);
    }

    public fun emit_new_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = NewWishCreated<T0>{inner: arg0};
        0x2::event::emit<NewWishCreated<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

