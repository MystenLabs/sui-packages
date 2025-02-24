module 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::examples3 {
    fun example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle) : u64 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_base(arg0) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::Rectangle) : u64 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_base(arg0) * 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

