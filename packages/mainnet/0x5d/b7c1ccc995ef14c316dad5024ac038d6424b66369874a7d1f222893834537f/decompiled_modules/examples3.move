module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::examples3 {
    fun example(arg0: &0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Rectangle) : u64 {
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_base(arg0) * 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Rectangle) : u64 {
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_base(arg0) * 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

