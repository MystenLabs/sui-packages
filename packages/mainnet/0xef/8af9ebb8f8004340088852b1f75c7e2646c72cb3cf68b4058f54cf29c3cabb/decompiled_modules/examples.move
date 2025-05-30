module 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::examples {
    fun examples<T0>(arg0: 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::Cup<T0>) : T0 {
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::borrow<T0>(&arg0);
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::borrow_mut<T0>(&mut arg0);
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::Cup<T0>) : T0 {
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::borrow<T0>(&arg0);
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::borrow_mut<T0>(&mut arg0);
        0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

