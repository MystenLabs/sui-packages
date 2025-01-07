module 0x2046189944aa24fa7b0c6193c6fc3982e36018e3aae50581ecbe5236a68ba0f3::cetus_clmm_interaction {
    struct DisplayEntity has key {
        id: 0x2::object::UID,
    }

    public entry fun create_display_entity(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayEntity{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<DisplayEntity>(v0);
    }

    public entry fun pre_swap<T0, T1>(arg0: &mut DisplayEntity, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

