module 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness {
    struct CetusWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : CetusWitness {
        CetusWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

