module 0x865cd9fd6fc791678ea54780b9cb0f8c91eafee155ed5a075bf448d3c8417533::program {
    struct Program has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    public fun get_program(arg0: &Program) : vector<u8> {
        arg0.path
    }

    public fun get_program_owner(arg0: &Program) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v6
}

