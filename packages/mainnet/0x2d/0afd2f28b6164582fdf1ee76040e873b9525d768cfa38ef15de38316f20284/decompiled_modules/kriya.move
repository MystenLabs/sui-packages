module 0x2d0afd2f28b6164582fdf1ee76040e873b9525d768cfa38ef15de38316f20284::kriya {
    struct TickInfo has copy, drop, store {
        index: u32,
        liquidity_net: u128,
    }

    public fun get_ticks(arg0: &0x2::table::Table<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::TickInfo>, arg1: vector<u32>) : vector<TickInfo> {
        if (0x1::vector::is_empty<u32>(&arg1)) {
            abort 0
        };
        let v0 = 0x1::vector::empty<TickInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg1)) {
            let v2 = *0x1::vector::borrow<u32>(&arg1, v1);
            let v3 = TickInfo{
                index         : v2,
                liquidity_net : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i128::as_u128(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick::get_liquidity_net(arg0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from_u32(v2))),
            };
            0x1::vector::push_back<TickInfo>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

