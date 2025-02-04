module 0xc41d333fcd7238da515139e18cc73808930c66d0c97b966666157dfd91058600::targate {
    struct TARGATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARGATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9eGkWN76LYC4NnHjJsNfoGzCsBCYXibtGfvyhoewpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TARGATE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TARGATE     ")))), trim_right(b"Targate AI                      "), trim_right(x"4163686965766520596f757220476f616c7320776974682041492d506f776572656420416e616c79746963732e0a0a5461726761746520414920697320612063757474696e672d65646765206461746120616e616c797469637320706c6174666f726d2074686174207573657320414920746f2068656c7020627573696e6573736573207461726765742c20616e616c797a652c20616e64206163686965766520746865697220676f616c73207769746820707265636973696f6e20616e6420656666696369656e63792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARGATE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARGATE>>(v4);
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

