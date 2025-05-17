module 0x236ccf42f96231e6952305953ffbc5cd674322feb60d4a97164c1e86a26342dd::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HuAncxDEsakCDgZS2Yfo9xJbHmtHXMnxxkT9jqdXnHhm.png?claimId=ODHGLZu1tZCmsiXd                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KM          ")))), trim_right(b"Kekius Maximus                  "), trim_right(x"4372656174656420627920414c5820706172746e6572696e6720776974682047726f6b20746f2063726561746520506570657320706172746e657220696e206d616b696e67206d656d657320677265617420616761696e200a0a0a0a5065706520746865206b696e67206973206669676874696e67206f6e20657468657265756d200a0a0a0a4b656b6975732074686520656d7065726f72206973206669676874696e67206f6e20736f6c616e61200a0a0a0a6c696b6564206f6e207820627920456c6f6e206d75736b2068696d73656c66200a0a0a0a4769766520757320746865207468756d627320757020616e64206a6f696e206f757220636f6d6d756e69747920202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KM>>(v4);
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

