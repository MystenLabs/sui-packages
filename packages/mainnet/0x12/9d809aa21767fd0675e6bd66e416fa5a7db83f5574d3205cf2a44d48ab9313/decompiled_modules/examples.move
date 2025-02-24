module 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::examples {
    fun examples<T0>(arg0: 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::Cup<T0>) : T0 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::borrow<T0>(&arg0);
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::borrow_mut<T0>(&mut arg0);
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::Cup<T0>) : T0 {
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::borrow<T0>(&arg0);
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::borrow_mut<T0>(&mut arg0);
        0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

