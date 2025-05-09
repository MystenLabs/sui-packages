module 0x73a1471dd622009d9173a658c9c9554da6cacd829d2eab46be23a85e88c7e4f7::test {
    struct AddEvent has copy, drop {
        val: u64,
    }

    public entry fun add(arg0: u64) {
        let v0 = AddEvent{val: arg0};
        0x2::event::emit<AddEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

