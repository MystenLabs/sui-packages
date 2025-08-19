module 0xfdf53fd3e747dc35352cd0d7ee0bdd3655e6b07e84f40064c2c65732feba7dd::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6kjzL6NBtwhzdhZJASqHMimfaxNBGqKd2h6JHnnbRuao.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEMES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEMES       ")))), trim_right(b"Memes Protocol                  "), trim_right(x"4d656d65732050726f746f636f6c202d20244d454d4553200a0a4d656d65732050726f746f636f6c20697320616e2041492d6e6174697665206672616d65776f726b207768657265206175746f6e6f6d6f7573206167656e7473206f706572617465206173206d656d652d67656e65726174696e672c207472656e642d73757266696e6720656e7469746965732e0a0a5468657365206167656e7473206172656e74206a75737420626f747320207468657972652063756c747572616c20696e737472756d656e74733a0a2d20747261696e656420746f20646574656374206f6e6c696e65207061747465726e730a2d206275696c7420746f20637265617465206f7220726561637420746f20766972616c206d6f6d656e74730a2d2061626c6520746f206f70657261746520696e646570656e64656e746c79206f7220636f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v4);
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

