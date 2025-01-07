module 0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::utils {
    public fun address_to_str(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg0));
        v0
    }

    public fun str(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun to_json(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"{");
        let v1 = 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(arg0);
        let v2 = 0;
        while (v2 < v1) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(arg0, v2);
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, *v3);
            if (*v4 == 0x1::string::utf8(b"BOOL_TRUE")) {
                0x1::string::append_utf8(&mut v0, b"\": true");
            } else if (*v4 == 0x1::string::utf8(b"BOOL_FALSE")) {
                0x1::string::append_utf8(&mut v0, b"\": false");
            } else {
                0x1::string::append_utf8(&mut v0, b"\": \"");
                0x1::string::append(&mut v0, *v4);
                0x1::string::append_utf8(&mut v0, b"\"");
            };
            if (v2 != v1 - 1) {
                0x1::string::append_utf8(&mut v0, b", ");
            };
            v2 = v2 + 1;
        };
        0x1::string::append_utf8(&mut v0, b"}");
        v0
    }

    public fun transfer_or_destory_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

