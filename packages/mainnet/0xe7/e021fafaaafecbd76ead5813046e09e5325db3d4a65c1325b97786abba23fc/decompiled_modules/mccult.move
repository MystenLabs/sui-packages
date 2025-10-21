module 0xe7e021fafaaafecbd76ead5813046e09e5325db3d4a65c1325b97786abba23fc::mccult {
    struct MCCULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCCULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4acdefd1de63bd78815e3c4f02c26f804c8830b538cf19bcb86a90710d7fd6dc                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MCCULT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MCCULT      ")))), trim_right(b"McDonalds cult                  "), trim_right(x"736f6c7320756e646572203230302c206d61782062756e646c652c206d6178204b4f4c206661726d696e672c206d6178206c61727020736561736f6e2e205472756d70206973206265696e6720626561726973682c206368696e612069732064756d70696e6720616e6420776520646f6e2774206b6e6f77206368696e6573652e200a0a497427732074696d6520746f207061636b206f7572206261677320616e64206765742061206a6f6220776974682074686520244d4343554c542020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCCULT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCCULT>>(v4);
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

