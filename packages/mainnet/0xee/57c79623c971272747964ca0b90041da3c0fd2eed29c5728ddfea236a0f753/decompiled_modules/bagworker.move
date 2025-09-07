module 0xee57c79623c971272747964ca0b90041da3c0fd2eed29c5728ddfea236a0f753::bagworker {
    struct BAGWORKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGWORKER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2b05acf5bf501bbf6c80bfae7cb153dfc32b8127632a2a8874ef7f5a686d5c8f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAGWORKER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAGWORKER   ")))), trim_right(b"The Meme Job                    "), trim_right(x"596f7527726520686972656420617320612062616720776f726b657221204a6f696e2074686520636f6d6d756e69747920616e6420776f726b20666f7220796f7572206261677320696e2074686520636f6d6d756e6974792e205368696c6c207468697320636f696e2065766572797768657265206f6e2043542e20446f2077686174206974206d7573742074616b652e0a0a4576656e2070756d7066756e2068696d73656c6620736169642062616720776f726b6572732077696c6c2077696e20696e2074686520656e642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGWORKER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGWORKER>>(v4);
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

