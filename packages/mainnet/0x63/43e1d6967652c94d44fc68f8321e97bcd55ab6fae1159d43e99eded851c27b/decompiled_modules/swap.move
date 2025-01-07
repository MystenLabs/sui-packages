module 0x6343e1d6967652c94d44fc68f8321e97bcd55ab6fae1159d43e99eded851c27b::swap {
    public entry fun swap<T0, T1>(arg0: &mut 0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::FlashLender<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::loan<T0>(arg0, arg1, arg4);
        0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::repay<T0>(arg0, v0, v1);
    }

    public fun withdraw<T0>(arg0: &mut 0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::FlashLender<T0>, arg1: &0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1d718f69a2065c2cbc4e5fd2d54328b3f49da814d3d6e6dbf30bc05428e449b8::flash_lender::withdraw<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

