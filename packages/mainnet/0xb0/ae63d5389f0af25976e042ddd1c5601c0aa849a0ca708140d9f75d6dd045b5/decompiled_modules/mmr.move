module 0xb0ae63d5389f0af25976e042ddd1c5601c0aa849a0ca708140d9f75d6dd045b5::mmr {
    struct MMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ddc20d3eafa5a9dd8f1981afa27ed82fea20611ee2d2d8a5860d385e22204359                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MMR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MMR         ")))), trim_right(b"McDonald's Monopoly Rewards     "), trim_right(x"204d63446f6e616c642773204d6f6e6f706f6c79200a0a4561726e207853746f636b732020436f6c6c6563742c2074726164652c20616e6420706c617921204120636f6d6d756e6974792d64726976656e20746f6b656e20696e737069726564206279207468652066756e206f66204d6f6e6f706f6c7920616e642074686520676f6c64656e206172636865732e204561726e20726577617264732c20737761702067616d65207069656365732c20616e64206469766520696e746f206d696e692d67616d6573202b204e4654207574696c69746965732e204a6f696e207468652067616d652c206f776e20796f75722073686172652c20616e64206c6576656c2075702077697468204d634d6f6e6f706f6c792120202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMR>>(v4);
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

