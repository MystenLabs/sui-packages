module 0x70f1178af8d69aa2607932a1bbc7d0ae07dedd4902649d575f4f5b323ff76f8e::template {
    struct NumberEvent has copy, drop {
        number: u64,
    }

    public entry fun get_number(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NumberEvent{number: 999999999999};
        0x2::event::emit<NumberEvent>(v0);
    }

    public fun get_number_test() : u64 {
        999999999999
    }

    // decompiled from Move bytecode v6
}

