module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_craft_path {
    struct CraftPath has copy, drop, store {
        input_item_ids: vector<u256>,
        input_quantities: vector<u256>,
        output_quantities: u256,
    }

    public fun get(arg0: &CraftPath) : (vector<u256>, vector<u256>, u256) {
        (arg0.input_item_ids, arg0.input_quantities, arg0.output_quantities)
    }

    public fun get_input_item_ids(arg0: &CraftPath) : vector<u256> {
        arg0.input_item_ids
    }

    public fun get_input_quantities(arg0: &CraftPath) : vector<u256> {
        arg0.input_quantities
    }

    public fun get_output_quantities(arg0: &CraftPath) : u256 {
        arg0.output_quantities
    }

    public fun new(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : CraftPath {
        CraftPath{
            input_item_ids    : arg0,
            input_quantities  : arg1,
            output_quantities : arg2,
        }
    }

    public(friend) fun set(arg0: &mut CraftPath, arg1: vector<u256>, arg2: vector<u256>, arg3: u256) {
        arg0.input_item_ids = arg1;
        arg0.input_quantities = arg2;
        arg0.output_quantities = arg3;
    }

    public(friend) fun set_input_item_ids(arg0: &mut CraftPath, arg1: vector<u256>) {
        arg0.input_item_ids = arg1;
    }

    public(friend) fun set_input_quantities(arg0: &mut CraftPath, arg1: vector<u256>) {
        arg0.input_quantities = arg1;
    }

    public(friend) fun set_output_quantities(arg0: &mut CraftPath, arg1: u256) {
        arg0.output_quantities = arg1;
    }

    // decompiled from Move bytecode v6
}

