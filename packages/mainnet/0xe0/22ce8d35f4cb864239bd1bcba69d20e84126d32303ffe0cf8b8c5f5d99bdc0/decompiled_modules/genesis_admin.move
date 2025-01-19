module 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis_admin {
    public fun add<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: vector<address>, arg3: vector<u64>) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::add<T0>(arg0, arg1, arg2, arg3);
    }

    public fun initialize<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::initialize<T0>(arg0, arg1, arg2, arg3);
    }

    public fun refill<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: 0x2::coin::Coin<T0>) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::refill<T0>(arg0, arg1, arg2);
    }

    public fun remove<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: vector<address>) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::remove<T0>(arg0, arg1, arg2);
    }

    public fun set_claiming_enabled<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: bool) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::set_claiming_enabled<T0>(arg0, arg1, arg2);
    }

    public fun set_min_claim_amount<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: u64) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::set_min_claim_amount<T0>(arg0, arg1, arg2);
    }

    public fun set_staking_pool_id<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: 0x2::object::ID) {
        0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::set_staking_pool_id<T0>(arg0, arg1, arg2);
    }

    public fun withdraw_collected_staking_bonus<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::Genesis<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::genesis::withdraw_collected_staking_bonus<T0>(arg0, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

