module 0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::validation {
    public fun convert_dummy_nft_name_to_handle(arg0: &vector<u8>) : vector<u8> {
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
                    0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(convert_dummy_nft_name_to_handle(&v2)));
                    v2 = 0x1::vector::empty<u8>();
                };
            } else {
                0x1::vector::push_back<u8>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::length<u8>(&v2) > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(convert_dummy_nft_name_to_handle(&v2)));
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
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = *0x1::vector::borrow<u8>(v0, 0);
        let v2 = *0x1::vector::borrow<u8>(v0, 0x1::vector::length<u8>(v0) - 1);
        if (v1 >= 65 && v1 <= 90 || v1 >= 97 && v1 <= 122 || v1 >= 48 && v1 <= 57) {
            if (v2 >= 65 && v2 <= 90 || v2 >= 97 && v2 <= 122 || v2 >= 48 && v2 <= 57) {
                return true
            };
        };
        false
    }

    public fun query_black_list_dummy_nft(arg0: &0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::BlackList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::get_reference_from_black_list(arg0), 0x1::string::utf8(convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    public fun query_block_dummy_nft(arg0: &0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::BlockList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::get_reference_from_block_list(arg0), arg1)
    }

    public fun query_gold_dummy_nft(arg0: &0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::GoldList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::get_reference_from_gold_list(arg0), 0x1::string::utf8(convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    public fun query_resereve_dummy_nft(arg0: &0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::ReservedDummyNFTList, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::admin::get_reference_from_resereved_list(arg0), 0x1::string::utf8(convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg1))))
    }

    // decompiled from Move bytecode v6
}

