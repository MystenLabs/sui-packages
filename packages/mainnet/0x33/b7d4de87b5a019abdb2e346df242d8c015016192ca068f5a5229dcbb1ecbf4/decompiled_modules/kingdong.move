module 0x33b7d4de87b5a019abdb2e346df242d8c015016192ca068f5a5229dcbb1ecbf4::kingdong {
    struct KINGDONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDONG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Et4C1pmiYiaf6ryoj3aTsbC4MDSESCUXTPVPNSuApump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KINGDONG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KINGDONG    ")))), trim_right(b"$KINGDONG                       "), trim_right(x"537472656e6774682e205765616c74682e20446f6d696e6174696f6e2e20244b494e47444f4e47206973206e6f74206a7573742061206d656d6520636f696e3b206974732061206d6f76656d656e742e20496e73706972656420627920746865206d6967687469657374206c6567656e6473206f6620696e7465726e65742063756c747572652c204b696e67446f6e6720656d626f6469657320756e72656c656e74696e6720706f7765722c2066696e616e6369616c2073757072656d6163792c20616e64206162736f6c75746520646f6d696e616e636520696e20746865206d656d6520636f696e206a756e676c652e0a0a46726f6d2074686520646570746873206f66207468652063727970746f206a756e676c652c204b696e67446f6e672068617320726973656e20746f206265636f6d652074686520417065782050"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDONG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGDONG>>(v4);
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

