module 0xd4fd627bc1f575fa5c4a846c2a608f905997a19a08f53d5cca6b636e076e9dfa::npc6900 {
    struct NPC6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC6900, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GzF3P6RSdaDfiU7m6UnzkAJgD3UYoHc4UqXeHodYsoeE.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NPC6900>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NPC6900     ")))), trim_right(b"NPC6900                         "), trim_right(x"4e5043363930302069736e74206a757374206120746f6b656e2e204974732061207265666c656374696f6e206f66206f757220776f726c642e0a0a496e2074686520616765206f66206175746f6d6174696f6e2c20736f6369616c206d6564696120736372697074732c20616e6420616c676f726974686d6963207468696e6b696e6720206d6f7374206f66207573206c697665206c696b65204e50437320284e6f6e2d506c617961626c652043686172616374657273292e0a0a244e50433639303020697320746865206d6f6d656e74206f6e65204e504320676c6974636865732c207175657374696f6e732065766572797468696e672c20616e642073746172747320746f206669676874206261636b2e0a0a5468697320746f6b656e2069733a0a41206d6972726f7220666f722074686520656d6f74696f6e616c6c79"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC6900>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPC6900>>(v4);
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

