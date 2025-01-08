module 0xbe66e3956632c8b8cb90211ecb329b9bb03afef9ba5d72472a7c240d3afe19fd::example {
    public fun ex1(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xbe66e3956632c8b8cb90211ecb329b9bb03afef9ba5d72472a7c240d3afe19fd::fund::create_fund(arg0);
    }

    // decompiled from Move bytecode v6
}

