module 0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_error {
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

