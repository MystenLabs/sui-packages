module 0xffe060bf366cc2f26ef403bea0961091cebac66395181a2ff9c38005fe33ed23::hedge_audit {
    public fun HedgeActivated(arg0: &mut 0x8f233a5c005238c776ebcb37692f2f541f62eb42796a546fc56cc56cdbb03ec9::hedge_audit::Registry, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x8f233a5c005238c776ebcb37692f2f541f62eb42796a546fc56cc56cdbb03ec9::hedge_audit::record(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

