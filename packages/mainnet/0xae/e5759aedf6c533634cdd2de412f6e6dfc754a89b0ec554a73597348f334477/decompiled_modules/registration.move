module 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::registration {
    struct Registration has drop {
        dummy_field: bool,
    }

    public fun register(arg0: &mut 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name_registry::NameRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::dot_move::DotMove {
        let v0 = Registration{dummy_field: false};
        0xaee5759aedf6c533634cdd2de412f6e6dfc754a89b0ec554a73597348f334477::name_registry::add_record<Registration>(arg0, v0, arg1, 0x2::clock::timestamp_ms(arg2) + 31536000000, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

