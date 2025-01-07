module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock {
    struct ItemOutOfGame has copy, drop, store {
        dummy_field: bool,
    }

    public fun item_lock(arg0: &0x2::package::Publisher) : ItemOutOfGame {
        assert!(0x2::package::from_package<ItemOutOfGame>(arg0), 0);
        ItemOutOfGame{dummy_field: false}
    }

    public fun is_locked(arg0: &0x2::object::UID) : bool {
        let v0 = ItemOutOfGame{dummy_field: false};
        0x2::dynamic_field::exists_<ItemOutOfGame>(arg0, v0)
    }

    public(friend) fun lock() : ItemOutOfGame {
        ItemOutOfGame{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

