module 0x8cb00ce6f48aa902f5ffb7afd886f853e665f841f129c6de7e9582c4997dc94b::lp_test {
    public fun fake_event<T0, T1>(arg0: &0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::events::emit_rebalanced<0x50ecc2500c9900a77225667c9a1f69c87f26108b0290e7e693bacdd60485d6d4::lp_bluefin::BluefinWitness>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    }

    // decompiled from Move bytecode v6
}

