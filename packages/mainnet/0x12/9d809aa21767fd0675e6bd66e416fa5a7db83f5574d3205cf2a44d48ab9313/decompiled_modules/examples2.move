module 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::examples2 {
    fun example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle) : 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle) : 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle, arg1: u64) : 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Box {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::box(0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_base(arg0), 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

