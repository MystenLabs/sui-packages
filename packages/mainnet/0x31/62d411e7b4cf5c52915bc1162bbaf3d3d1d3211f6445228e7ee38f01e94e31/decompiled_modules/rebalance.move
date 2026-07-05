module 0x3162d411e7b4cf5c52915bc1162bbaf3d3d1d3211f6445228e7ee38f01e94e31::rebalance {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_liquidity(arg0: &AdminCap, arg1: address, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun close_position(arg0: &AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_to_usdsui<T0, T1>(arg0: &AdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

