module 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::treasury {
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

