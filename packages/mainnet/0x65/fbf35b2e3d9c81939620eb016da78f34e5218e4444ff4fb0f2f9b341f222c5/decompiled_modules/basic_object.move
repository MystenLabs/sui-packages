module 0x65fbf35b2e3d9c81939620eb016da78f34e5218e4444ff4fb0f2f9b341f222c5::basic_object {
    struct BasicObject has key {
        id: 0x2::object::UID,
    }

    struct BASIC_OBJECT has drop {
        dummy_field: bool,
    }

    public entry fun airdrop(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = BasicObject{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<BasicObject>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn(arg0: BasicObject) {
        let BasicObject { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BasicObject{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BasicObject>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: BASIC_OBJECT, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BasicObject{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BasicObject>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

