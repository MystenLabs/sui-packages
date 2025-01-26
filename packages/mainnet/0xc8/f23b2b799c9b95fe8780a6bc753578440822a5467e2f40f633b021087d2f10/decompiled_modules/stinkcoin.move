module 0xc8f23b2b799c9b95fe8780a6bc753578440822a5467e2f40f633b021087d2f10::stinkcoin {
    struct STINKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9ZWmgaewdaH2Ljfi3iE8A7umcJcxJz83ZakkfEPApump.png?claimId=OZU90xBs-55vKpg1                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STINKCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STINKCOIN   ")))), trim_right(b"Stink Coin                      "), trim_right(x"42757474686f6c65202b2046617274203d205354494e4b2e200a0a576974686f757420746865207374696e6b2c207468652062757474686f6c6520616e64206661727420776f756c64206a75737420626520616e6f7468657220737068696e6374657220616e6420736f6d65206169722e200a0a2342757474686f6c65436f6c6f676e652020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STINKCOIN>>(v4);
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

