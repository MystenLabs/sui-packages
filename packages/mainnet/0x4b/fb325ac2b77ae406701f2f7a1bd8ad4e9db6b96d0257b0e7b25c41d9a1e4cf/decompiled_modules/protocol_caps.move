module 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::protocol_caps {
    public fun borrow_alphafi_position_cap<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut<T0, T1: store + key>(arg0: &mut 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &mut T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_mut_v2<T0, T1: store + key>(arg0: &mut 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &mut T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap_mut<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"alphafi_position_cap")
    }

    public fun borrow_alphafi_position_cap_v2<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"alphafi_position_cap")
    }

    public fun borrow_bucket_account<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"bucket_account")
    }

    public fun borrow_bucket_account_v2<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"bucket_account")
    }

    public fun borrow_navi_account_cap<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut<T0, T1: store + key>(arg0: &mut 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &mut T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap_mut<T0, T1>(arg0, arg1, b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_mut_v2<T0, T1: store + key>(arg0: &mut 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &mut T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap_mut<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"navi_account_cap")
    }

    public fun borrow_navi_account_cap_v2<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"navi_account_cap")
    }

    public fun borrow_suilend_obligation_cap<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, arg1, b"suilend_obligation_cap")
    }

    public fun borrow_suilend_obligation_cap_v2<T0, T1: store + key>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::StrategyRegistry) : &T1 {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::borrow_protocol_cap<T0, T1>(arg0, 0x4bfb325ac2b77ae406701f2f7a1bd8ad4e9db6b96d0257b0e7b25c41d9a1e4cf::strategy::borrow_protocol_access_cap(arg1), b"suilend_obligation_cap")
    }

    // decompiled from Move bytecode v6
}

