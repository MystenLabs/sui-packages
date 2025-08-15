module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::items {
    public fun get_item_category_by_name(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Wheelbarrow";
        if (v0 == &v1) {
            4
        } else {
            let v3 = b"Handsaw";
            if (v0 == &v3) {
                1
            } else {
                let v4 = b"Hammer & Chisel";
                if (v0 == &v4) {
                    2
                } else {
                    let v5 = b"Kiln";
                    if (v0 == &v5) {
                        3
                    } else {
                        let v6 = b"Axe";
                        if (v0 == &v6) {
                            4
                        } else {
                            let v7 = b"Bucket";
                            if (v0 == &v7) {
                                4
                            } else {
                                let v8 = b"Pickaxe";
                                if (v0 == &v8) {
                                    4
                                } else {
                                    let v9 = b"Idol of Axomamma";
                                    if (v0 == &v9) {
                                        5
                                    } else {
                                        let v10 = b"Signal Horn";
                                        if (v0 == &v10) {
                                            5
                                        } else {
                                            let v11 = b"Abacus";
                                            if (v0 == &v11) {
                                                5
                                            } else {
                                                let v12 = b"Crystal Ball";
                                                if (v0 == &v12) {
                                                    5
                                                } else {
                                                    let v13 = b"Magic Siphon";
                                                    if (v0 == &v13) {
                                                        4
                                                    } else {
                                                        let v14 = b"Shovel";
                                                        if (v0 == &v14) {
                                                            5
                                                        } else {
                                                            let v15 = b"Basket";
                                                            assert!(v0 == &v15, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
                                                            5
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
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
        } else {
            assert!(arg0 == 14, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
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
        get_item_stake_limit(arg0)
    }

    public fun get_item_stake_limit(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            1
        } else if (arg0 == 3) {
            1
        } else if (arg0 == 4) {
            1
        } else if (arg0 == 5) {
            1
        } else if (arg0 == 6) {
            1
        } else if (arg0 == 7) {
            1
        } else if (arg0 == 8) {
            1
        } else if (arg0 == 9) {
            1
        } else if (arg0 == 10) {
            1
        } else if (arg0 == 11) {
            1
        } else if (arg0 == 12) {
            1
        } else if (arg0 == 13) {
            1
        } else {
            assert!(arg0 == 14, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            1
        }
    }

    public fun get_item_type_description(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A storage container that expands your resource capacity. Higher tiers provide greater storage multipliers.")
        } else if (arg0 == 2) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A precision tool for woodworking tasks.")
        } else if (arg0 == 3) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Hammer and chisel set for stone working.")
        } else if (arg0 == 4) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"High-temperature oven for melting and baking.")
        } else if (arg0 == 5) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Sharp-edged tool for chopping wood or timber.")
        } else if (arg0 == 6) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Container used for carrying water or other liquids.")
        } else if (arg0 == 7) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Heavy-duty tool for breaking rock or hard minerals.")
        } else if (arg0 == 8) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Sacred figure symbolizing the Incan goddess of potatoes.")
        } else if (arg0 == 9) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Audible device for sending alerts or announcements.")
        } else if (arg0 == 10) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Counting frame used for arithmetic calculations.")
        } else if (arg0 == 11) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A tool said to view the future.")
        } else if (arg0 == 12) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"An extractor of magic particles for concentrated use.")
        } else if (arg0 == 13) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"A tool to dig up hidden treasures.")
        } else {
            assert!(arg0 == 14, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::utf8(b"Container used to carry multiple resources and items.")
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
        } else {
            assert!(arg0 == 14, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x1::string::utf8(b"Basket")
        }
    }

    public(friend) fun is_production_tool(arg0: u8) : bool {
        get_item_category_by_type(arg0) == 4
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

    public fun item_type_kiln() : u8 {
        4
    }

    public fun item_type_magic_siphon() : u8 {
        12
    }

    public fun item_type_pickaxe() : u8 {
        7
    }

    public fun item_type_shovel() : u8 {
        13
    }

    public fun item_type_signal_horn() : u8 {
        9
    }

    public fun item_type_storage() : u8 {
        item_type_wheelbarrow()
    }

    public fun item_type_wheelbarrow() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

