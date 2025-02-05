module 0x76db8a6e8659dcd7ca6082c933d069ce329e11b1131a8c21a50d1675f2864d2::larrya {
    struct LARRYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6MGYZStqUzqdTkf8zjPeKnoeoPAnTWLK9zPYeKLcpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LARRYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LARRY       ")))), trim_right(b"Larry Coin                      "), trim_right(x"244c4152525920436f696e2c20696e73706972656420627920746865206c6567656e6461727920446f776e696e6720537472656574206361742c20666f7374657273206120636f6d6d756e697479206f6620226368696c6c2220696e766573746f72732077697468206120666f637573206f6e20676f6f6420676f7665726e616e636520616e6420706c617966756c206d697363686965662c206a757374206c696b65206974732066656c696e65206e616d6573616b652e0a0a2043413a20364d47595a537471557a7164546b66387a6a50654b6e6f656f50416e54574c4b397a5059654b4c6370756d7020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRYA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRYA>>(v4);
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

