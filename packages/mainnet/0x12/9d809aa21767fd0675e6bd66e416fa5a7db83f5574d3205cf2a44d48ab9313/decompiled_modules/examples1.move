module 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::examples1 {
    fun example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle, arg1: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Box) : u64 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_base(arg0) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_height(arg0) + 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_base(arg1) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_height(arg1) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_depth(arg1)
    }

    fun expanded_example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle, arg1: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Box) : u64 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_base(arg0) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_height(arg0) + 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_base(arg1) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_height(arg1) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box_depth(arg1)
    }

    // decompiled from Move bytecode v6
}

