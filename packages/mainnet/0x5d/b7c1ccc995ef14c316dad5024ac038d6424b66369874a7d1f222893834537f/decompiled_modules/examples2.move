module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::examples2 {
    fun example(arg0: &0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Rectangle) : 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Rectangle) : 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Rectangle, arg1: u64) : 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::Box {
        0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::box(0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_base(arg0), 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

