module 0x220eec992cedd8beaa7c03ed743f04eb360f68be8a24c7c3c9af92f20bd7f4af::cetus_clmm_interaction {
    struct DisplayEntity has key {
        id: 0x2::object::UID,
    }

    public entry fun create_display_entity(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayEntity{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DisplayEntity>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pre_swap<T0, T1>(arg0: &mut DisplayEntity, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<vector<u8>, vector<u8>>(&mut arg0.id, b"result", x"e69292e59388e68b89e68c96e4ba95e4baba");
    }

    // decompiled from Move bytecode v6
}

