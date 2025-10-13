module 0x9542b4869f9cd9184fb97709974972e2ce7c82a375494041ca7555e3c0f8cddf::cleaner {
    public fun claim_and_delete<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::delete_metadata_cap<T0>(arg0, 0x2::coin_registry::claim_metadata_cap<T0>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

