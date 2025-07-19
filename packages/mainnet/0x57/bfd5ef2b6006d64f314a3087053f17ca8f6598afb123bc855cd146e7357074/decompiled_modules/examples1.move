module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::examples1 {
    fun example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle, arg1: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Box) : u64 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_base(arg0) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_height(arg0) + 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_base(arg1) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_height(arg1) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_depth(arg1)
    }

    fun expanded_example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle, arg1: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Box) : u64 {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_base(arg0) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_height(arg0) + 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_base(arg1) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_height(arg1) * 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box_depth(arg1)
    }

    // decompiled from Move bytecode v6
}

