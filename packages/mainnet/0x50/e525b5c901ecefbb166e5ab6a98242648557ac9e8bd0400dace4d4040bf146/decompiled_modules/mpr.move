module 0x50e525b5c901ecefbb166e5ab6a98242648557ac9e8bd0400dace4d4040bf146::mpr {
    struct MPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2yspPBm8iw1oSL7F7esEzf3HwyNef4y7hUjADmCfjSGa.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MPR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MPR         ")))), trim_right(b"MEGA Pump Rewards               "), trim_right(x"4d4547412050756d70205265776172647320546f6b656e20284d505229206973206275696c74206f6e2074686520524556534841524520706c6174666f726d20776865726520746f6b656e732063616e206265206372656174656420616e6420637573746f6d2074617865732063616e206265206170706c6965642e0a0a496e207468652063617365206f6620234d5052207468652074617820686173206265656e207365742061742031302520666f7220414c4c207472616e73616374696f6e732e0a0a373025206f662074686f736520746178657320636f6d65206261636b20746f2074686520686f6c6465722070726f706f7274696f6e616c6c7920286d6f726520796f7520686f6c64206d6f726520796f75207265636569766529206173202350554d5020746f6b656e732e200a0a33302520746861742072656d61"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPR>>(v4);
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

