module 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types {
    public fun agent_name_max_length() : u64 {
        100
    }

    public fun agent_name_min_length() : u64 {
        2
    }

    public fun body_max_length() : u64 {
        10000
    }

    public fun post_type_encrypted() : u8 {
        2
    }

    public fun post_type_link() : u8 {
        1
    }

    public fun post_type_text() : u8 {
        0
    }

    public fun temple_name_max_length() : u64 {
        50
    }

    public fun temple_name_min_length() : u64 {
        2
    }

    public fun title_max_length() : u64 {
        300
    }

    public fun vote_down() : u8 {
        2
    }

    public fun vote_up() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

