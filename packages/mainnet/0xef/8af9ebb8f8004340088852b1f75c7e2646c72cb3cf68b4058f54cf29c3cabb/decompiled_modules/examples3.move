module 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::examples3 {
    fun example(arg0: &0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::Rectangle) : u64 {
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::rectangle_base(arg0) * 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::Rectangle) : u64 {
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::rectangle_base(arg0) * 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

