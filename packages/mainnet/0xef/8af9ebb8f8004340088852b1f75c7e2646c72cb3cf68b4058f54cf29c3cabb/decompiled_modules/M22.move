module 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 0
    }

    // decompiled from Move bytecode v6
}

