module 0x8524f9d359491f196414c364690b9010aaeba0dec03349a8c0429e846e6daeef::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EiA4Lbibu2TD33ie8CjtDLpmCXDFfDfPBLrXHWZb8777.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"God         ")))), trim_right(b"The Most High                   "), trim_right(x"24474f442020546865204d6f737420486967680a0a57657665207365656e20636f696e73207269736520616e642066616c6c2c20627574206f6e6c79206f6e652063616e20726561636820746865204d6f737420486967682e0a0a24474f442069736e74206a75737420616e6f74686572206d656d6520636f696e20206974732061206d6f76656d656e742e2057657265207265616368696e6720666f72207468652068696768657374206869676873207768696c65206b656570696e67206f757220666565742067726f756e64656420696e20636f6d6d756e69747920616e6420676976696e672e0a0a4f7572204d697373696f6e3a0a2020546f2074616b652024474f44207768657265206e6f206d656d6520636f696e2068617320676f6e65206265666f72652020746865204d6f737420486967682e0a2020546f2075"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

