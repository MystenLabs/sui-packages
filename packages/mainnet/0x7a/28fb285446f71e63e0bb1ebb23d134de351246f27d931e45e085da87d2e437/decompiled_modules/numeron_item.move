module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_item {
    struct Item has copy, drop, store {
        id: u256,
        quantities: u256,
    }

    public fun get(arg0: &Item) : (u256, u256) {
        (arg0.id, arg0.quantities)
    }

    public fun get_id(arg0: &Item) : u256 {
        arg0.id
    }

    public fun get_quantities(arg0: &Item) : u256 {
        arg0.quantities
    }

    public fun new(arg0: u256, arg1: u256) : Item {
        Item{
            id         : arg0,
            quantities : arg1,
        }
    }

    public(friend) fun set(arg0: &mut Item, arg1: u256, arg2: u256) {
        arg0.id = arg1;
        arg0.quantities = arg2;
    }

    public(friend) fun set_id(arg0: &mut Item, arg1: u256) {
        arg0.id = arg1;
    }

    public(friend) fun set_quantities(arg0: &mut Item, arg1: u256) {
        arg0.quantities = arg1;
    }

    // decompiled from Move bytecode v6
}

