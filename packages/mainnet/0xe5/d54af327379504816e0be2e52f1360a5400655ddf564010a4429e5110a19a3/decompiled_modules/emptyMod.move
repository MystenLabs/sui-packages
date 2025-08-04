module 0xe5d54af327379504816e0be2e52f1360a5400655ddf564010a4429e5110a19a3::emptyMod {
    public fun bar() : vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo> {
        0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>()
    }

    public fun foo() {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(400);
    }

    // decompiled from Move bytecode v6
}

