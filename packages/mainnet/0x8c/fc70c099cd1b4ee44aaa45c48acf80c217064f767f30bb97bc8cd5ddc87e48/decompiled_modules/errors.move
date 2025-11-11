module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors {
    public fun handle_taken() : u64 {
        5
    }

    public fun invalid_handle() : u64 {
        6
    }

    public fun invalid_index() : u64 {
        4
    }

    public fun invalid_value() : u64 {
        1
    }

    public fun profile_already_exists() : u64 {
        7
    }

    public fun profile_not_exists() : u64 {
        0
    }

    public fun profile_not_owned() : u64 {
        3
    }

    public fun same_user() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

