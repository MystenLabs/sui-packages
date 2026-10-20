module 0xc71ea3284474158292e7b0539a7e476662a161d828a9d48c230fd9b7a629ecfb::h {
    public fun ab<T0, T1, T2>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg3);
        let (v0, v1) = 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::swap<T0, T1, T2>(arg2, arg0, arg1, 0, 0x2::balance::zero<T1>(), 1, true);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun ba<T0, T1, T2>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let (v0, v1) = 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::swap<T0, T1, T2>(arg2, arg0, 0x2::balance::zero<T0>(), 1, arg1, 0, true);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    public fun bs<T0>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<0x2::sui::SUI, T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ba<0x2::sui::SUI, T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>(arg0, arg1, arg2, arg3)
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sb<T0>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<0x2::sui::SUI, T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ab<0x2::sui::SUI, T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>(arg0, arg1, arg2, arg3)
    }

    public fun sx<T0>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<T0, 0x2::sui::SUI, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ba<T0, 0x2::sui::SUI, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>(arg0, arg1, arg2, arg3)
    }

    public fun xs<T0>(arg0: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<T0, 0x2::sui::SUI, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ab<T0, 0x2::sui::SUI, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::Stable>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

