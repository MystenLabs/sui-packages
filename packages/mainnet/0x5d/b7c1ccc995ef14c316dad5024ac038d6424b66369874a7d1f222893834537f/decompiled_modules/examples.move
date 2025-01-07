module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::examples {
    fun examples<T0>(arg0: 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::Cup<T0>) : T0 {
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::borrow<T0>(&arg0);
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::borrow_mut<T0>(&mut arg0);
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::Cup<T0>) : T0 {
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::borrow<T0>(&arg0);
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::borrow_mut<T0>(&mut arg0);
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

