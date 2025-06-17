module 0xabaef4de364f5bc2157d3f9ed302805aa9b36e221320e2921403912afcc174d9::deposit_example {
    public fun get_pool_liquidity(arg0: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg2: u64) {
        let (_, _, _, _, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_pool_liquidity(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

