module 0x3c6471f7939dad157f67c8b4d206d0a0fb82b9418f8a236df706422dc7e2ef82::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

