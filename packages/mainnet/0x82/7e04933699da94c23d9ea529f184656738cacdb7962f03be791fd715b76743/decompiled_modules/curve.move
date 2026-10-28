module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::curve {
    fun amount_out(arg0: u256, arg1: u256, arg2: u256) : u64 {
        ((arg2 * arg0 / (arg1 + arg0)) as u64)
    }

    public(friend) fun cap_buy_quote_input(arg0: u64, arg1: u64, arg2: u64, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : (u64, u64) {
        let v0 = arg1 - arg0;
        if (arg2 - 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg3, arg2) <= v0) {
            (arg2, 0)
        } else {
            let v3 = 0x1::u64::mul_div_ceil(v0, 10000, 10000 - 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3));
            (v3, arg2 - v3)
        }
    }

    public(friend) fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg5: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : (u64, u64, u64, u64) {
        let v0 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg4, arg3);
        let v1 = amount_out(((arg3 - v0) as u256), (arg2 as u256) + (arg1 as u256), (arg0 as u256));
        let v2 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg5, v1);
        (v0, v1, v2, v1 - v2)
    }

    public(friend) fun quote_sell(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg5: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg6: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : (u64, u64, u64, u64, u64) {
        let v0 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg5, arg3);
        let v1 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg6, arg3 - v0);
        let v2 = amount_out(((arg3 - v0 - v1) as u256), (arg0 as u256), (arg2 as u256) + (arg1 as u256));
        let v3 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::apply_up(arg4, v2);
        let v4 = v2 - v3;
        assert!(v4 > 0, 17);
        (v0, v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

