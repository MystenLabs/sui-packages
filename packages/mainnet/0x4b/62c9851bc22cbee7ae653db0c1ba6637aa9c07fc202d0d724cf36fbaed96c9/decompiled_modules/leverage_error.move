module 0x4b62c9851bc22cbee7ae653db0c1ba6637aa9c07fc202d0d724cf36fbaed96c9::leverage_error {
    public fun market_not_supported() : u64 {
        1000001
    }

    public fun obligation_already_has_position() : u64 {
        1000002
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    // decompiled from Move bytecode v6
}

