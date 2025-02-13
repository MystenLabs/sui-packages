module 0xfc71756562f9bd311059b672d76d8dedbd87c1b687e01aa766434b2581b5af13::royale {
    struct ROYALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CM2wyfYGFmaFfzxQDvWfvG7ViHpx19GAVcUi72ppump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROYALE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ROYALE      ")))), trim_right(b"Buy Royale                      "), trim_right(x"42757920526f79616c65206973206120636f6d70657469746976652067616d6520666f72206d656d65636f696e2054656c656772616d2063686174732e2057696e20534f4c20627920616363756d756c6174696e6720746865206d6f737420737570706c79206265666f72652074696d652072756e73206f7574210a0a486f6c642024524f59414c4520746f206561726e206469766964656e64732067656e6572617465642062792040427579526f79616c65426f74202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYALE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROYALE>>(v4);
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

