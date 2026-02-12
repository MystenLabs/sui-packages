module 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::wish_event {
    struct NewWishCreated<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishFulfilled<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishCancelled<T0: copy + drop> has copy, drop {
        payload: T0,
    }

    public fun emit_cancel_wish_event<T0: copy + drop>(arg0: T0) {
        let v0 = WishCancelled<T0>{payload: arg0};
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

