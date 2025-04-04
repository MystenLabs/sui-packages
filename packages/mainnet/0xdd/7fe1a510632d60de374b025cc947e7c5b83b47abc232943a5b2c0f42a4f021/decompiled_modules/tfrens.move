module 0xdd7fe1a510632d60de374b025cc947e7c5b83b47abc232943a5b2c0f42a4f021::tfrens {
    struct TFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5zyRriD6jU9TtgTYPtPHjx54Mj8siMn85qcqjxaNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TFRENS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Tfrens      ")))), trim_right(b"Trench Frens                    "), trim_right(x"5468652028556e294f6666696369616c204d6173636f74206f6620746865205472656e63686573210a0a4576657279207465616d206e656564732061206d6173636f7420616e6420776861747320626574746572207468616e20616e204e4654210a0a5472656e6368204672656e732069732061204d656d65636f696e20616e6420616e204e4654207468617420617265206d757475616c6c792062656e6566696369616c2e20466f72676564206465657020696e20746865207472656e636865732c2077657665207375666665726564206d616e79206c6f737365732077697468206576656e20666577657220766963746f72696573206275742077652061726520616c6c20636f6e6e656374656420616e64206861766520736f6c69646966696564206f757220626f6e647320696e206d757475616c20747261756d612e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFRENS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFRENS>>(v4);
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

