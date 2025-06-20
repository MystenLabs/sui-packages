module 0x13d23f34374abbeca39ec479e886be512fc2880058be3d4ba440a997ddbd5433::pvrse {
    struct PVRSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVRSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/qKxNiXm85xhS2QBQBg3u43sf7E4mUDY73LL8N83pump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PVRSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PVRSE       ")))), trim_right(b"PVRSE                           "), trim_right(x"50657065566572736520697320756e6974696e6720616c6c205065706520636f6d6d756e6974696573207468726f75676820637265617469766974792c20636f6c6c61626f726174696f6e2c20616e642067616d6520646576656c6f706d656e742e20200a0a4a6f696e20746865206d6f76656d656e7420746f206275696c6420612066756e2c20696e636c75736976652066757475726520666f7220506570652066616e7321202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVRSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVRSE>>(v4);
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

