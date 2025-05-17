module 0x8671dd5a96d2e2d4b247b06ff4828a4b5e113df14b9691c64b685c3ac9fc8643::nugget {
    struct NUGGET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUGGET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DLnB8DKnpq2J1pqMSeowquh6YUJgEEUcppPFFvm5pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NUGGET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NUGGET      ")))), trim_right(b"SOMEBODY NUGGET                 "), trim_right(x"496d2063726973707920696e7369646520616e64206f75742c2077617920746f6f2066756c6c206f66206d7973656c66616e6420796f75206c6f76652069742e0a46726f6d20667265657a657220746f2066616d652c204920636c696d6265642074686520666f6f6420636861696e20666173742e0a476f6c64656e20736b696e2c206c6f6e67206c6567732c2073617263617374696320736d696c652e0a496d206e6f742061207369646520646973682e20496d2061206c65676163792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUGGET>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUGGET>>(v4);
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

