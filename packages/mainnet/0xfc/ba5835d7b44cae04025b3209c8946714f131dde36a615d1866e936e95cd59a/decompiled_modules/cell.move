module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::cell {
    struct DoNothingArgument has copy, drop, store {
        dummy_field: bool,
    }

    struct Cell has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun drop_cell(arg0: Cell) {
        let Cell {
            id   : v0,
            name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun initialize_do_nothing_params(arg0: &mut 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::ActionRequest<DoNothingArgument>, arg1: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::Game) {
        assert!(0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::cell_contains_with_type<Cell>(arg1, 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::action_request_pos_index<DoNothingArgument>(arg0)), 101);
        0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::settle_action_request<DoNothingArgument>(arg0);
    }

    public fun new_cell(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Cell {
        Cell{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

