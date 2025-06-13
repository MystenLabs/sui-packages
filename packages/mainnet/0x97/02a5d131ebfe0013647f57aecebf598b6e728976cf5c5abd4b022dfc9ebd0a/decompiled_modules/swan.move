module 0x9702a5d131ebfe0013647f57aecebf598b6e728976cf5c5abd4b022dfc9ebd0a::swan {
    struct SWAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6zDhXCiVkNg5iKURAbmqY2Hn7tEphtQCFihsYSmHpump.png?claimId=U-bT1_BALA2Q2R5Y                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SWAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SWAN        ")))), trim_right(b"Black Swan                      "), trim_right(x"54686520426c61636b205377616e2073796d626f6c697a6573206e6f74206a7573742074686520656e64206f66207468696e67732c20616e2065787472656d656c7920756e6c696b656c79206576656e7420746861742074616b657320706c61636520696e20746865206d61726b657473202d2049742065787072657373657320616e206f70706f7274756e69747920746f2070757420616e20656e6420746f20616c6c20746865206c6965732c2074686566742c206661726d73206f6e2074686520736f6c616e6120626c6f636b636861696e2e200a426c61636b205377616e204576656e7420323032352e2054686520656e64206f662045564552595448494e472e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAN>>(v4);
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

