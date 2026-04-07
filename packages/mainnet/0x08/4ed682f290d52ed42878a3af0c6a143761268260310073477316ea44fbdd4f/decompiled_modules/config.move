module 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config {
    public fun auction_duration_ms() : u64 {
        86400000
    }

    public fun max_text_len() : u64 {
        1024
    }

    public fun max_uri_len() : u64 {
        512
    }

    public fun min_bid_increment() : u64 {
        1000000
    }

    // decompiled from Move bytecode v7
}

