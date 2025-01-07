module 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::AdminCap, arg1: &mut 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::Vault<T0, T1, T2, 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::set_slippage<T0, T1, T2, 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::AdminCap, arg1: &mut 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::Vault<T0, T1, T2, 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 9);
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::config::set_trigger_price_scalling(0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::borrow_mut_config<T0, T1, T2, 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

