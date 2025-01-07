module 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config {
    public fun get_fee_collection_unregistered() : u64 {
        50
    }

    public fun get_fee_service() : u64 {
        15
    }

    public fun get_status_list() : u64 {
        1
    }

    public fun get_status_not_list() : u64 {
        0
    }

    public fun get_version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

