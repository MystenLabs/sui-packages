module 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::Global, arg1: &mut 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::Pools, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::is_emergency(arg0), 302);
        assert!(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::beneficiary(arg0) == 0x2::tx_context::sender(arg2), 301);
        let v0 = 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::get_mut_pool<T0, T1>(arg1, 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::withdraw<T0, T1>(v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg2));
        0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::event::withdrew_event(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::global_id<T0, T1>(v0), 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

