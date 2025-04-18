module 0xaf9236db08955f612e62bd0a1f694729b671dc0086eeaff953c8278f81fb90e1::apeman {
    struct APEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FXfZMDJidcse1ux6w7q24ai9k9th7vbbtKkwXJPpoyvG.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<APEMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Apeman      ")))), trim_right(b"Apeman                          "), trim_right(x"244150454d414e20697320612074727565204f47206f662074686520626c6f636b636861696e206a756e676c65202061206368696c6c2c20626174746c652d74657374656420646567656e2077686f73207375727669766564206576657279206379636c652e20486520646f65736e742063686173652070756d7073206f722070616e696320696e20646970732e2042756c6c2072756e732c2062656172206d61726b6574732c2072756773202d20686573207365656e20697420616c6c2e0a0a4e6f7720686573206865726520746f2067617468657220616c6c2074686520534f4c206170657320616e64206c656164207468656d2e204170654d616e20646f65736e7420666f6c6c6f77207472656e6473202d20686520697320746865207472656e64202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEMAN>>(v4);
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

