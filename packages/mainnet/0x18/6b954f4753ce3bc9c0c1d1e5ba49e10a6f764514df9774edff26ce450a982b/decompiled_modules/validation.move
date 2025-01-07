module 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation {
    public fun convert_channel_name_to_handle(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 >= 65 && v2 <= 90 || v2 >= 97 && v2 <= 122 || v2 >= 48 && v2 <= 57) {
                if (v2 >= 65 && v2 <= 90) {
                    0x1::vector::push_back<u8>(&mut v0, v2 + 32);
                } else {
                    0x1::vector::push_back<u8>(&mut v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_word_list(arg0: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v0)) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            if (v4 == 32) {
                if (0x1::vector::length<u8>(&v2) > 0) {
                    0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(convert_channel_name_to_handle(&v2)));
                    v2 = 0x1::vector::empty<u8>();
                };
            } else {
                0x1::vector::push_back<u8>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::length<u8>(&v2) > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(convert_channel_name_to_handle(&v2)));
        };
        v1
    }

    public fun hasMultipleSpacesBetweenChar(arg0: 0x1::string::String) : bool {
        let v0 = 0;
        let v1 = 0x1::string::as_bytes(&arg0);
        while (v0 < 0x1::vector::length<u8>(v1) - 1) {
            if (*0x1::vector::borrow<u8>(v1, v0) == 32 && *0x1::vector::borrow<u8>(v1, v0 + 1) == 32) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun isValidName(arg0: 0x1::string::String) : bool {
        assert!(!hasMultipleSpacesBetweenChar(arg0), 14);
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            if (v1 == 0 || v1 == 0x1::vector::length<u8>(v0) - 1) {
                let v3 = v2 >= 65 && v2 <= 90 || v2 >= 97 && v2 <= 122 || v2 >= 48 && v2 <= 57 || v2 == 32;
                if (v3 == false) {
                    return false
                };
            } else {
                let v4 = v2 >= 65 && v2 <= 90 || v2 >= 97 && v2 <= 122 || v2 >= 48 && v2 <= 57 || v2 == 45 || v2 == 39 || v2 == 32;
                if (v4 == false) {
                    return false
                };
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun query_black_list_channel(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlackList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_black_list(arg0), 0x1::string::utf8(convert_channel_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    public fun query_block_channel(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlockList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_block_list(arg0), arg1)
    }

    public fun query_gold_channel(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::GoldList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_gold_list(arg0), 0x1::string::utf8(convert_channel_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    public fun query_resereve_channel(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::ReservedChannelList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_resereved_list(arg0), 0x1::string::utf8(convert_channel_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    // decompiled from Move bytecode v6
}

