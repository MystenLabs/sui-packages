module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::examples3 {
    fun example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle) : u64 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_base(arg0) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle) : u64 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_base(arg0) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

