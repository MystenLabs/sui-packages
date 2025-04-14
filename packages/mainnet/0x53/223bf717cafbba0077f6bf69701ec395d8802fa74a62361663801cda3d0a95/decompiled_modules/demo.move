module 0x53223bf717cafbba0077f6bf69701ec395d8802fa74a62361663801cda3d0a95::demo {
    public entry fun add<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::bag::Bag, arg1: T0, arg2: T1) {
        0x2::bag::add<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::bag::Bag>(0x2::bag::new(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

