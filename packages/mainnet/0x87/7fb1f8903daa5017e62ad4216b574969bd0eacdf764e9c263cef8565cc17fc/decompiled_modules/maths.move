module 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::maths {
    public fun convert_to_usdc_base(arg0: u128) : u64 {
        ((arg0 / 1000) as u64)
    }

    // decompiled from Move bytecode v6
}

