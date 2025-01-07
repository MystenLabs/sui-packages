module 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::treasury {
    struct Treasury has store {
        treasurer: address,
    }

    public fun appoint(arg0: &mut Treasury, arg1: address) {
        arg0.treasurer = arg1;
    }

    public(friend) fun new(arg0: address) : Treasury {
        Treasury{treasurer: arg0}
    }

    public fun treasurer(arg0: &Treasury) : address {
        arg0.treasurer
    }

    // decompiled from Move bytecode v6
}

