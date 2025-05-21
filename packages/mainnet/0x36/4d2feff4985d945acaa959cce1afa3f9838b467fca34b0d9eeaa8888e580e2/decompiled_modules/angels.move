module 0x364d2feff4985d945acaa959cce1afa3f9838b467fca34b0d9eeaa8888e580e2::angels {
    struct ANGELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGELS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HRdyCK3HQNWca8XY5Y4pGtfpH1Xgn9pW2RAaBbBApump.png?claimId=IiHtvRBnK15v1zgi                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANGELS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANGELS      ")))), trim_right(b"Sonny Angels                    "), trim_right(x"24414e47454c5320697320612066616e206d656d6520746f6b656e20746861742063656c6562726174657320536f6e6e7920416e67656c73202d2054686520576f726c642773204d6f737420566972616c20546f7921200a0a536f6e6e7920416e67656c73206172652074696e7920636f6c6c65637469626c6520646f6c6c732066726f6d204a6170616e2e204f726967696e616c6c79206d65616e7420617320676f6f64206c75636b20636861726d2c20746865797665206e6f7720676f6e6520766972616c206f6e2054696b546f6b2e20546865792063616e206265207365656e20636c696e67696e6720746f2070686f6e652063617365732c206465736b732c20616e64207368656c76657320616c6c206f7665722074686520776f726c642e2020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGELS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGELS>>(v4);
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

