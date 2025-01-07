module 0xe49a62295fdf5d6d4979590e04566361ac50f3c50bf94538e4d9d0b75504e5c::example {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun increment(arg0: &OwnerCap, arg1: &mut Counter) {
        arg1.value = arg1.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v1);
    }

    // decompiled from Move bytecode v6
}

