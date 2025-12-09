module 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::bid_ask {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::liquidity_strategy::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::liquidity_strategy::bid_ask(), arg10, arg11, arg12, arg13);
    }

    fun calculate_active_weights(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        abort 1
    }

    public fun open_position<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position {
        0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::liquidity_strategy::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::liquidity_strategy::bid_ask(), arg9, arg10, arg11, arg12)
    }

    // decompiled from Move bytecode v6
}

