module 0xda527c53fb99337488772d3402110684752341bf53ee8f858f6a23573fbc57e3::friedrich {
    struct FRIEDRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEDRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HSd8XaFMnpQQhhDNe4Rq8bvQnbCKDvXbAZTnHgKupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRIEDRICH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRIEDRICH   ")))), trim_right(b"Friedrich Merz                  "), trim_right(x"24465249454452494348204d65727a206973204368616e63656c6c6f722043616e646964617465206f6620746865204344552c20746865206d6f737420706f6c6c656420706172747920696e206765726d616e20706f6c69746963732e0a4163636f7264696e6720746f20506f6c796d61726b65742c204d65727a2077696c6c206265636f6d6520746865206e6577204368616e63656c6c6f722077697468206120393125206368616e6365206f6e20746865203233746820466562727561727920323032352e20456c6f6e204d75736b2069732070726f20416c6963652057656964656c2c20736f2024465249454452494348204d65727a2077696c6c206e6f7420676f20756e636f6d6d656e7465642e20546865206661766f72697465206f6620746865206d61696e73747265616d206d656469612e2020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEDRICH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIEDRICH>>(v4);
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

