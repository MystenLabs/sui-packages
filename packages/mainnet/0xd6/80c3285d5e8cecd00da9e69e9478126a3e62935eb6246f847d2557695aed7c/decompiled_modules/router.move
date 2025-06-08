module 0xd680c3285d5e8cecd00da9e69e9478126a3e62935eb6246f847d2557695aed7c::router {
    public entry fun update_effective_tick_range<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u128, arg8: vector<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::governance_update_effective_tick_range<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6), arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

