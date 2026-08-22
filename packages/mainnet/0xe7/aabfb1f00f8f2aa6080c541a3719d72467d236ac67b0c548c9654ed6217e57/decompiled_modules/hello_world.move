module 0xe7aabfb1f00f8f2aa6080c541a3719d72467d236ac67b0c548c9654ed6217e57::hello_world {
    struct HelloEvent has copy, drop {
        message: 0x1::string::String,
    }

    public fun hello() {
        let v0 = HelloEvent{message: 0x1::string::utf8(b"Hello World")};
        0x2::event::emit<HelloEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

