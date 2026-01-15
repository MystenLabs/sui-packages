module 0xf3d059af47631bb94030946c07db2a0013eff68bdc580946b2d6a9d82da140af::display {
    struct DisplayManager has key {
        id: 0x2::object::UID,
        inner: 0x2::object_bag::ObjectBag,
        publisher: 0x2::package::Publisher,
    }

    public(friend) fun new_and_share(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayManager{
            id        : 0x2::object::new(arg1),
            inner     : 0x2::object_bag::new(arg1),
            publisher : arg0,
        };
        0x2::transfer::share_object<DisplayManager>(v0);
    }

    // decompiled from Move bytecode v6
}

