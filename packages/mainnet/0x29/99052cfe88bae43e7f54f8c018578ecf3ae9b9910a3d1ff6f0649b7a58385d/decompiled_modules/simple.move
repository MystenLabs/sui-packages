module 0x2999052cfe88bae43e7f54f8c018578ecf3ae9b9910a3d1ff6f0649b7a58385d::simple {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Example has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct ExampleEvent has copy, drop {
        sender: address,
        value: u64,
    }

    public entry fun add(arg0: &mut Example, arg1: &mut 0x2::tx_context::TxContext) {
        add1(0x2::tx_context::sender(arg1), arg0);
    }

    fun add1(arg0: address, arg1: &mut Example) {
        arg1.value = arg1.value + 1;
        let v0 = ExampleEvent{
            sender : arg0,
            value  : arg1.value,
        };
        0x2::event::emit<ExampleEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Example{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Example>(v1);
    }

    // decompiled from Move bytecode v6
}

