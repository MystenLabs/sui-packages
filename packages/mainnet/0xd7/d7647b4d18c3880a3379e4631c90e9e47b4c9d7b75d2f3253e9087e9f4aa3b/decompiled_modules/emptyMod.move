module 0xd7d7647b4d18c3880a3379e4631c90e9e47b4c9d7b75d2f3253e9087e9f4aa3b::emptyMod {
    public fun bar() : vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo> {
        0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>()
    }

    public fun foo() {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(400);
    }

    // decompiled from Move bytecode v6
}

