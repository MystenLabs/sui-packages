module 0xabbcaa43e8070db88c5e0bffaff5fbe1b186d7ea229a0483a8cf5cea1ccf2483::nft_farm {
    public fun add(arg0: u64, arg1: u64) : u64 {
        0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::math64::div_up(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

