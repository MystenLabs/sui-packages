module 0x6b191f14ae6d8e7446c927ee9aef52a35d7b6fcc54a144b359d947dd575cc654::ipocket {
    struct IPOCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPOCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8415b387c2564cb3569ed10e073e417862deeb364da88598717bb749bfa500ed                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IPOCKET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"iPocket     ")))), trim_right(b"iPhone Pocket                   "), trim_right(x"4170706c65206861732072656c65617365642061206e65772070726f647563742063616c6c6564206950686f6e6520506f636b65742e0a0a497427732061206c696d697465642d65646974696f6e2066617368696f6e206163636573736f727920666561747572696e67202233442d6b6e697474656420636f6e737472756374696f6e22207468617420686f6c647320796f7572206950686f6e6520696e736964652e0a0a54686520506f636b657420636f73747320243134392e393520616e642077696c6c20626520617661696c61626c65204e6f76656d6265722031342e0a0a57696c6c20796f7520626520627579696e67206f6e653f2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPOCKET>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPOCKET>>(v4);
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

