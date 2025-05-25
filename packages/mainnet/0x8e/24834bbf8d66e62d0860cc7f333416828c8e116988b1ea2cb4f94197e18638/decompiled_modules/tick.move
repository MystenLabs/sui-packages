module 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick {
    struct Tick has copy, drop {
        tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
    }

    public(friend) fun liquidity_net(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        arg0.liquidity_net
    }

    public(friend) fun new(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128) : Tick {
        Tick{
            tick_index    : arg0,
            liquidity_net : arg1,
        }
    }

    public(friend) fun tick_index(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.tick_index
    }

    // decompiled from Move bytecode v6
}

