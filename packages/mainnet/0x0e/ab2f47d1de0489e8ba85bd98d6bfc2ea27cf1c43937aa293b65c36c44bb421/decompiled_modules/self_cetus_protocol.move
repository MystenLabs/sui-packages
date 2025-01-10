module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::self_cetus_protocol {
    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg3: 0x1::ascii::String, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::swap<T0, T1>(arg0, arg1, arg2, 0x2::tx_context::sender(arg10), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg8), arg4, arg5, arg6, arg7);
    }

    public fun add_liquidity_by_max_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::add_liquidity_by_max_amount<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg9), arg4, arg5, arg6, arg7, arg8);
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg9), arg4, arg5, arg6, arg7, arg8);
    }

    public fun close_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::close_position<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg11), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun collect_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::collect_fee<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg7), arg4, arg5, arg6, arg7);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg3: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg9), arg5, arg6, arg7, arg8, arg9);
    }

    public fun open_position_by_max_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: u32, arg6: u32, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::open_position_by_max_amount<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun open_position_fix_coin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::open_position_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun open_position_with_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: u32, arg6: u32, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::open_position_with_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg9), arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1::ascii::String, arg5: 0x2::object::ID, arg6: u128, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg12), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

