module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items {
    public fun get_item_category_by_name(arg0: &0x1::string::String) : u8 {
        let v0 = b"Wheelbarrow";
        if (0x1::string::as_bytes(arg0) == &v0) {
            4
        } else {
            5
        }
    }

    public fun get_item_category_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Woodworking")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Masonry")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Blacksmithing")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Production")
        } else {
            assert!(arg0 == 5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x1::string::utf8(b"Miscellaneous")
        }
    }

    public fun get_item_limit(arg0: u8) : u64 {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        1
    }

    public fun get_item_type_description(arg0: u8) : 0x1::string::String {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A storage container that expands your resource capacity. Higher tiers provide greater storage multipliers.")
    }

    public fun get_item_type_name(arg0: u8) : 0x1::string::String {
        assert!(arg0 == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Wheelbarrow")
    }

    public fun item_category_blacksmithing() : u8 {
        3
    }

    public fun item_category_masonry() : u8 {
        2
    }

    public fun item_category_miscellaneous() : u8 {
        5
    }

    public fun item_category_production() : u8 {
        4
    }

    public fun item_category_woodworking() : u8 {
        1
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

