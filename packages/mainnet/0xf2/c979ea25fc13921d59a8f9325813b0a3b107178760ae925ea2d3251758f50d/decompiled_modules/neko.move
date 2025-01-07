module 0xf2c979ea25fc13921d59a8f9325813b0a3b107178760ae925ea2d3251758f50d::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEKO>>(0x2::coin::mint<NEKO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6wdbFQAxDVwUdJrZEnnzgPzsZ1NruvLhf9qCvmSD5DLX.png?size=lg&key=af83db                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEKO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEKO    ")))), trim_right(b"NEKO                            "), trim_right(x"4e656b6f20697320746865206e657720636174206f6e2074686520626c6f636b20556e6c696b65206f7468657220636174206d656d65636f696e732c204e656b6f20697320756e697175652e20536865206861732061206669657263652064657465726d696e6174696f6e20746f206265636f6d6520746865206e756d626572206f6e65206d656d65636f696e20696e207468652063727970746f2073706163652e20536865207370656e7420686f757273207265736561726368696e6720626c6f636b636861696e20746563686e6f6c6f677920616e64206c6561726e696e672061626f757420746865206f7468657220636f696e732e002020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEKO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEKO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEKO>>(0x2::coin::mint<NEKO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

