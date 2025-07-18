module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items {
    public fun get_item_limit(arg0: u8) : u64 {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        1
    }

    public fun get_item_type_description(arg0: u8) : 0x1::string::String {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A magical storage container that expands your resource capacity. Higher tiers provide greater storage multipliers.")
    }

    public fun get_item_type_name(arg0: u8) : 0x1::string::String {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Wheelbarrow")
    }

    public fun item_limit_storage() : u64 {
        1
    }

    public fun item_limit_unlimited() : u64 {
        0
    }

    public fun item_type_storage() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

