module 0x8946d7635009c61175f948e1d9e05dc95c6aa824afbb0fc049f5322e416f1e3c::cetus_clmm_interaction {
    struct DisplayEntity has key {
        id: 0x2::object::UID,
    }

    public entry fun create_display_entity(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayEntity{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DisplayEntity>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pre_swap<T0, T1>(arg0: &mut DisplayEntity, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

