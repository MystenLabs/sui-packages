module 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis_admin {
    public fun add<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: vector<address>, arg3: vector<u64>) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::add<T0>(arg0, arg1, arg2, arg3);
    }

    public fun initialize<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::initialize<T0>(arg0, arg1, arg2, arg3);
    }

    public fun refill<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::refill<T0>(arg0, arg1, arg2);
    }

    public fun remove<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: vector<address>) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::remove<T0>(arg0, arg1, arg2);
    }

    public fun set_claiming_enabled<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: bool) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::set_claiming_enabled<T0>(arg0, arg1, arg2);
    }

    public fun set_min_claim_amount<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: u64) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::set_min_claim_amount<T0>(arg0, arg1, arg2);
    }

    public fun set_staking_pool_id<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: 0x2::object::ID) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::set_staking_pool_id<T0>(arg0, arg1, arg2);
    }

    public fun withdraw_collected_staking_bonus<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::Genesis<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis::withdraw_collected_staking_bonus<T0>(arg0, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

