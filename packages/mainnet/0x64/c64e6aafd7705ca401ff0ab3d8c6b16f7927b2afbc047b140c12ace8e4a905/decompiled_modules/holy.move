module 0x64c64e6aafd7705ca401ff0ab3d8c6b16f7927b2afbc047b140c12ace8e4a905::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOLY>>(0x2::coin::mint<HOLY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/58y23mKohBMkt1AuMSz9TYaUZEgdfQaNkp8CtaY5pump.png?size=lg&key=73a049                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HOLY    ")))), trim_right(b"Holy Cat                        "), trim_right(x"57656c636f6d6520486f6c792043617420696e746f20796f757220706f7274666f6c696f7320616e6420696e746f20796f7572206865617274732e20546869732068656176656e6c79206b697474656e2077696c6c20626520796f75722073796d626f6c206f66206c75636b20616e6420612067756964696e672073746172206f6e20746865207061746820746f2061206e6577204154482e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOLY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOLY>>(0x2::coin::mint<HOLY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

