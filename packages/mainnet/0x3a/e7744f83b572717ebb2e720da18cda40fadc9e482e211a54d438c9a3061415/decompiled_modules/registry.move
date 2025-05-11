module 0x3ae7744f83b572717ebb2e720da18cda40fadc9e482e211a54d438c9a3061415::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow_publisher(arg0: &Registry) : &0x2::package::Publisher {
        &arg0.publisher
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<REGISTRY>(arg0, arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

