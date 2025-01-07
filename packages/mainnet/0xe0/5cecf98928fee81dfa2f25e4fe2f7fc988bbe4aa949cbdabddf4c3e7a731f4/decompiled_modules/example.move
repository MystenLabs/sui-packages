module 0xe05cecf98928fee81dfa2f25e4fe2f7fc988bbe4aa949cbdabddf4c3e7a731f4::example {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Inc has copy, drop {
        sender: address,
        value: u64,
    }

    public entry fun increment(arg0: &OwnerCap, arg1: &mut Counter) {
        arg1.value = arg1.value + 1;
    }

    public entry fun increment_v2(arg0: &OwnerCap, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) {
        increment(arg0, arg1);
        let v0 = Inc{
            sender : 0x2::tx_context::sender(arg2),
            value  : arg1.value,
        };
        0x2::event::emit<Inc>(v0);
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

