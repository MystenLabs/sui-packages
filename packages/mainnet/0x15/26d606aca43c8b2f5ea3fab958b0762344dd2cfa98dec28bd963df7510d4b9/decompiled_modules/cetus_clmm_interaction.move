module 0x1526d606aca43c8b2f5ea3fab958b0762344dd2cfa98dec28bd963df7510d4b9::cetus_clmm_interaction {
    struct DisplayEntity has key {
        id: 0x2::object::UID,
    }

    public entry fun create_display_entity(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun pre_swap<T0, T1>(arg0: &mut DisplayEntity, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<vector<u8>, vector<u8>>(&mut arg0.id, b"result", x"e69292e59388e68b89e68c96e4ba95e4baba");
    }

    // decompiled from Move bytecode v6
}

