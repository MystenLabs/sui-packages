module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::examples {
    fun examples<T0>(arg0: 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::Cup<T0>) : T0 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::borrow<T0>(&arg0);
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::borrow_mut<T0>(&mut arg0);
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::Cup<T0>) : T0 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::borrow<T0>(&arg0);
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::borrow_mut<T0>(&mut arg0);
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

