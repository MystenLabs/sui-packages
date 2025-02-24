module 0x186303b5394b015dff7733da3e5f1059bb77aafa36122173b6310ec22cd8d262::lqx {
    struct LQX has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LQX>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LQX>>(0x2::coin::mint<LQX>(arg0, arg2, arg3), arg1);
    }

    public fun get_value(arg0: &LQX) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

