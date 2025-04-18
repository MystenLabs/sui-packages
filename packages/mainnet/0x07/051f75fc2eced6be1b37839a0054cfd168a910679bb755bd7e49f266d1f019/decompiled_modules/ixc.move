module 0x7051f75fc2eced6be1b37839a0054cfd168a910679bb755bd7e49f266d1f019::ixc {
    struct IXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IXC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AYw4iTLwSkf6wPJ7Ye3F8de1drPwSWgWDn5XuDfXpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IXC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IXC         ")))), trim_right(b"BTC's Clone                     "), trim_right(x"4254432773207477696e2062726f74686572202d2058636f696e207761732072656c656173656420696e20417072696c206f66203230313120696e2061206d616e6e65722073696d696c617220746f20426974636f696e2e205468652063726561746f722075736564207468652070736575646f6e796d206f662054686f6d6173204e6173616b696f746f20616e6420686173206b65707420612076657279206c6f772070726f66696c6520657665722073696e63652e20497420697320657373656e7469616c6c79206120636c6f6e65206f6620426974636f696e2c2077697468207468652073616d65203130206d696e75746520626c6f636b2074696d657320616e64203231206d696c6c696f6e20636f696e206d6178696d756d2e0a0a4f6e65206b657920646966666572656e63652066726f6d20426974636f696e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IXC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IXC>>(v4);
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

