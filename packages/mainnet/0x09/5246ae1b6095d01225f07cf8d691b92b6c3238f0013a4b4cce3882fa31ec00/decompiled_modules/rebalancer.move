module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::rebalancer {
    public fun flash_threshold_usdc() : u64 {
        2500
    }

    public fun is_available(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : bool {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::flashloan_provider_id(arg0) != @0x0
    }

    public fun rebalance_flash(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : bool {
        is_available(arg0) && arg1 >= 2500
    }

    public fun rebalance_ptb(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : bool {
        arg1 > 0 && arg1 < 2500
    }

    // decompiled from Move bytecode v6
}

