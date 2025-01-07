module 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::examples3 {
    fun example(arg0: &0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::Rectangle) : u64 {
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::rectangle_base(arg0) * 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::Rectangle) : u64 {
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::rectangle_base(arg0) * 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

