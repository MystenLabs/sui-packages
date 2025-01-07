module 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::registration {
    struct Registration has drop {
        dummy_field: bool,
    }

    public fun register(arg0: &mut 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name_registry::NameRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::dot_move::DotMove {
        let v0 = Registration{dummy_field: false};
        0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name_registry::add_record<Registration>(arg0, v0, arg1, 0x2::clock::timestamp_ms(arg2) + 31536000000, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

