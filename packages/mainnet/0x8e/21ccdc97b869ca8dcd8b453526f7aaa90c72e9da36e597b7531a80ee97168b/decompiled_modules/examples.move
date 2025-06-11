module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::examples {
    fun examples<T0>(arg0: 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::Cup<T0>) : T0 {
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::borrow<T0>(&arg0);
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::borrow_mut<T0>(&mut arg0);
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::Cup<T0>) : T0 {
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::borrow<T0>(&arg0);
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::borrow_mut<T0>(&mut arg0);
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

