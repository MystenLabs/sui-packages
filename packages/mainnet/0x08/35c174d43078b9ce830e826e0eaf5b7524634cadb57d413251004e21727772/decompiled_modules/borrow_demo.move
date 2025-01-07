module 0x835c174d43078b9ce830e826e0eaf5b7524634cadb57d413251004e21727772::borrow_demo {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public entry fun another(arg0: &MyObject) {
        let v0 = arg0.owner;
        0x1::debug::print<address>(&v0);
    }

    public entry fun another2(arg0: &MyObject) {
        0x1::debug::print<address>(&arg0.owner);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyObject{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<MyObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

