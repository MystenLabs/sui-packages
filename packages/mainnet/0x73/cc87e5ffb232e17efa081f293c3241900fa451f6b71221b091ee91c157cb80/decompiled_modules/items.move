module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items {
    public fun get_item_category_by_name(arg0: &0x1::string::String) : u8 {
        abort 0
    }

    public fun get_item_category_by_type(arg0: u8) : u8 {
        if (arg0 == 1) {
            4
        } else if (arg0 == 2) {
            1
        } else if (arg0 == 3) {
            2
        } else if (arg0 == 4) {
            3
        } else if (arg0 == 5) {
            4
        } else if (arg0 == 6) {
            4
        } else if (arg0 == 7) {
            4
        } else if (arg0 == 8) {
            5
        } else if (arg0 == 9) {
            5
        } else if (arg0 == 10) {
            5
        } else if (arg0 == 11) {
            5
        } else if (arg0 == 12) {
            4
        } else if (arg0 == 13) {
            5
        } else if (arg0 == 14) {
            5
        } else if (arg0 == 15) {
            6
        } else if (arg0 == 16) {
            7
        } else if (arg0 == 17) {
            8
        } else if (arg0 == 18) {
            5
        } else {
            assert!(arg0 == 19, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
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
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Miscellaneous")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Advanced Woodworking")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Advanced Masonry")
        } else {
            assert!(arg0 == 8, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x1::string::utf8(b"Advanced Blacksmithing")
        }
    }

    public fun get_item_limit(arg0: u8) : u64 {
        get_item_stake_limit(arg0)
    }

    public fun get_item_stake_limit(arg0: u8) : u64 {
        1
    }

    public fun get_item_type_description(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A storage container that expands your resource capacity. Higher tiers provide greater storage multipliers.")
        } else if (arg0 == 2) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A precision tool for woodworking tasks.")
        } else if (arg0 == 3) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Hammer and chisel set for stone working.")
        } else if (arg0 == 4) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"High-temperature oven for melting and baking.")
        } else if (arg0 == 5) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Sharp-edged tool for chopping wood or timber.")
        } else if (arg0 == 6) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Container used for carrying water or other liquids.")
        } else if (arg0 == 7) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Heavy-duty tool for breaking rock or hard minerals.")
        } else if (arg0 == 8) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Sacred figure symbolizing the Incan goddess of potatoes.")
        } else if (arg0 == 9) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Audible device for sending alerts or announcements.")
        } else if (arg0 == 10) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Counting frame used for arithmetic calculations.")
        } else if (arg0 == 11) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A tool said to view the future.")
        } else if (arg0 == 12) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"An extractor of magic particles for concentrated use.")
        } else if (arg0 == 13) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A tool to dig up hidden treasures.")
        } else if (arg0 == 14) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Container used to carry multiple resources and items.")
        } else if (arg0 == 15) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A woodworking tool for advanced craftsman.")
        } else if (arg0 == 16) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A masonry tool for advanced craftsman.")
        } else if (arg0 == 17) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A blacksmithing tool for advanced craftsman.")
        } else if (arg0 == 18) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A Banner representing an Estate or Province")
        } else {
            assert!(arg0 == 19, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"A device enabling Heroes to find fragments of ancient relics.")
        }
    }

    public fun get_item_type_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Wheelbarrow")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Handsaw")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Hammer & Chisel")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Kiln")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Axe")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Bucket")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Pickaxe")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Idol of Axomamma")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Signal Horn")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Abacus")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Crystal Ball")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Magic Siphon")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Shovel")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Basket")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Wooden Runepen")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Stone Runepen")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Iron Runepen")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Banner Flag")
        } else {
            assert!(arg0 == 19, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x1::string::utf8(b"Runic Resonator")
        }
    }

    public(friend) fun is_production_tool(arg0: u8) : bool {
        get_item_category_by_type(arg0) == 4
    }

    public fun item_category_advanced_blacksmithing() : u8 {
        8
    }

    public fun item_category_advanced_masonry() : u8 {
        7
    }

    public fun item_category_advanced_woodworking() : u8 {
        6
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

    public fun item_limit_abacus() : u64 {
        1
    }

    public fun item_limit_axe() : u64 {
        1
    }

    public fun item_limit_basket() : u64 {
        1
    }

    public fun item_limit_bucket() : u64 {
        1
    }

    public fun item_limit_crystal_ball() : u64 {
        1
    }

    public fun item_limit_hammer_chisel() : u64 {
        1
    }

    public fun item_limit_handsaw() : u64 {
        1
    }

    public fun item_limit_idol_of_axomamma() : u64 {
        1
    }

    public fun item_limit_kiln() : u64 {
        1
    }

    public fun item_limit_magic_siphon() : u64 {
        1
    }

    public fun item_limit_pickaxe() : u64 {
        1
    }

    public fun item_limit_shovel() : u64 {
        1
    }

    public fun item_limit_signal_horn() : u64 {
        1
    }

    public fun item_limit_storage() : u64 {
        item_limit_wheelbarrow()
    }

    public fun item_limit_unlimited() : u64 {
        0
    }

    public fun item_limit_wheelbarrow() : u64 {
        1
    }

    public fun item_type_abacus() : u8 {
        10
    }

    public fun item_type_axe() : u8 {
        5
    }

    public fun item_type_banner_flag() : u8 {
        18
    }

    public fun item_type_basket() : u8 {
        14
    }

    public fun item_type_bucket() : u8 {
        6
    }

    public fun item_type_crystal_ball() : u8 {
        11
    }

    public fun item_type_hammer_chisel() : u8 {
        3
    }

    public fun item_type_handsaw() : u8 {
        2
    }

    public fun item_type_idol_of_axomamma() : u8 {
        8
    }

    public fun item_type_iron_runepen() : u8 {
        17
    }

    public fun item_type_kiln() : u8 {
        4
    }

    public fun item_type_magic_siphon() : u8 {
        12
    }

    public fun item_type_pickaxe() : u8 {
        7
    }

    public fun item_type_runic_resonator() : u8 {
        19
    }

    public fun item_type_shovel() : u8 {
        13
    }

    public fun item_type_signal_horn() : u8 {
        9
    }

    public fun item_type_stone_runepen() : u8 {
        16
    }

    public fun item_type_storage() : u8 {
        item_type_wheelbarrow()
    }

    public fun item_type_wheelbarrow() : u8 {
        1
    }

    public fun item_type_wooden_runepen() : u8 {
        15
    }

    // decompiled from Move bytecode v6
}

