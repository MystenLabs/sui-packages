module 0xccb8cf3645157e4572ee8e2e5451a0431ca767ff3f18a539d11ffcc0f681b8f3::oracle_mock {
    public fun convert_sui_to_buck(arg0: u64) : u64 {
        arg0 * 1500 / 1000
    }

    public fun get_sui_price_buck() : u64 {
        1500
    }

    // decompiled from Move bytecode v6
}

