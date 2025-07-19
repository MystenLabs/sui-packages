module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::examples2 {
    fun example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle) : 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle) : 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Rectangle, arg1: u64) : 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::Box {
        0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::box(0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_base(arg0), 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

