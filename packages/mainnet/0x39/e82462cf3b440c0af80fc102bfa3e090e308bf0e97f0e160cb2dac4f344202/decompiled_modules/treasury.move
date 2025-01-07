module 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::treasury {
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

