module 0xeb294b9401a7b6df0000b9f4cb67322d0fcdd12dd05ef9bd28529d41dbf07d22::config {
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

