module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event {
    struct NewWishCreated<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishFulfilled<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    struct WishCancelled<T0: copy + drop> has copy, drop {
        payload: T0,
    }

    struct UpgradeApprovalChanged has copy, drop {
        who: address,
        is_approved: bool,
        package: u8,
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

    public(friend) fun emit_upgrade_approval_changed(arg0: u8, arg1: bool, arg2: address) {
        let v0 = UpgradeApprovalChanged{
            who         : arg2,
            is_approved : arg1,
            package     : arg0,
        };
        0x2::event::emit<UpgradeApprovalChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

