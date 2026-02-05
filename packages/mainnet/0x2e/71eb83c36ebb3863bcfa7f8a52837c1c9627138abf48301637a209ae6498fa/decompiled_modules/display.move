module 0x2e71eb83c36ebb3863bcfa7f8a52837c1c9627138abf48301637a209ae6498fa::display {
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

