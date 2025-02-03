module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils {
    public fun add_prefix_hex_char(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    public fun cancel_collateral_fun() : vector<u8> {
        b"cancel_collateral"
    }

    public fun convert_vaa_buffer_to_string(arg0: vector<u8>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::ascii::string(b"");
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            if (v3 == 44) {
                0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(v1));
                v1 = 0x1::ascii::string(b"");
            } else {
                0x1::ascii::push_char(&mut v1, 0x1::ascii::char(v3));
            };
            v2 = v2 + 1;
        };
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(v1));
        v0
    }

    public fun create_loan_offer_cross_chain_fun() : vector<u8> {
        b"create_loan_offer_cross_chain"
    }

    public fun decimal_to_hex_char(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6", b"7", b"8", b"9", b"a", b"b", b"c", b"d", b"e", b"f"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    public fun default_rate_factor() : u64 {
        10000
    }

    public fun generate_message_vaa_payload(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
            0x1::vector::append<u8>(&mut v0, b",");
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    public fun power(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 <= arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
        };
        v0
    }

    public fun refund_collateral_to_repaid_borrower_fun() : vector<u8> {
        b"refund_collateral_to_repaid_borrower"
    }

    public fun seconds_in_year() : u64 {
        31536000
    }

    public fun start_liquidate_loan_cross_chain_fun() : vector<u8> {
        b"start_liquidate_collateral"
    }

    public fun string_to_u64(arg0: 0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0x1::string::bytes(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (!is_digit(v3)) {
                return 0x1::option::none<u64>()
            };
            let v4 = v1 * 10;
            v1 = v4 + to_digit(v3);
            v2 = v2 + 1;
        };
        0x1::option::some<u64>(v1)
    }

    fun to_digit(arg0: u8) : u64 {
        ((arg0 - 48) as u64)
    }

    public fun u64_to_string(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
            return v0
        };
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 48 + ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun update_deposit_collateral_cross_chain_fun() : vector<u8> {
        b"update_deposit_collateral_cross_chain"
    }

    public fun update_withdraw_collateral_cross_chain_fun() : vector<u8> {
        b"update_withdraw_collateral_cross_chain"
    }

    public fun vector_to_hex_char(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"0x");
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0x1::vector::borrow<u8>(&arg0, v0);
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 / 16));
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 % 16));
            v0 = v0 + 1;
        };
        v1
    }

    public fun vector_to_hex_char_without_prefix(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"");
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0x1::vector::borrow<u8>(&arg0, v0);
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 / 16));
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 % 16));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

