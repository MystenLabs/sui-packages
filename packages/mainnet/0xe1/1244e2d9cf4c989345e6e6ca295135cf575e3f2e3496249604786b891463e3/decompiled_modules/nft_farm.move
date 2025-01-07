module 0xe11244e2d9cf4c989345e6e6ca295135cf575e3f2e3496249604786b891463e3::nft_farm {
    public fun add(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::div_up(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

