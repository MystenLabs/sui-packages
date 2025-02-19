module 0xba9cb63ebb1f4a10977d6fd7b1418b3ab36ac779b07fd7e99fcc5c6243b8c0e::pmf {
    struct PMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GskGy6oxAMP8goXP1oospGNeVZ6KTL62gmVXZCASpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PMF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PMF         ")))), trim_right(b"PMF or Dier                     "), trim_right(x"4c6976652d73747265616d696e672032342f37206c6f636b696e6720696e206275696c64696e67207468652063727970746f20746f7020313030202f2070756d702066756e206f66206d757369632e200a0a546172676574696e672024324d2041525220696e20746865206e65787420393020646179732e200a0a427579696e672035302520616e64206c6f636b696e6720697420666f7220612033206d6f6e746820766573742e0a0a54686520667574757265206f6620746865206d7573696320696e647573747279206973206279207468652070656f706c6520616e6420666f72207468652070656f706c652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMF>>(v4);
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

