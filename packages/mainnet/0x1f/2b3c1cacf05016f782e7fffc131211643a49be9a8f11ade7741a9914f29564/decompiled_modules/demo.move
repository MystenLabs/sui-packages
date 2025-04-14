module 0x27de75723cb923e2ed88c6bf9d90518dd1a430b559b526091e0f520e56b3626f::demo {
    public entry fun add(arg0: &mut 0x2::bag::Bag, arg1: u32, arg2: u32) {
        0x2::bag::add<u32, u32>(arg0, arg1, arg2);
    }

    public entry fun remove(arg0: &mut 0x2::bag::Bag, arg1: u32) {
        0x2::bag::remove<u32, u32>(arg0, arg1);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::bag::Bag>(0x2::bag::new(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

