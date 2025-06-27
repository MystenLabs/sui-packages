module 0xd4c8de301184f519a27d73ab4bb8ddbfb8a7b5c6a53ab515ef70a68e5b3583f2::swap {
    struct MyEvent has copy, drop, store {
        referrer: address,
    }

    public entry fun fees(arg0: address) {
        let v0 = MyEvent{referrer: arg0};
        0x2::event::emit<MyEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

