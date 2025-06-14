module 0x3aff790d9cf346388445490e125d361d3073565727d64cbbc397f1919feae6f8::mmc {
    struct MMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/D2ZmWYv6acY5DLTBbMp59yiGttrWBETa9H7e8r6mpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MMC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MMC         ")))), trim_right(b"Mothman Coin                    "), trim_right(x"486573206265656e2073706f7474656420616761696e746869732074696d65206f6e20536f6c616e612e204e6f206e6f6973652c206e6f207761726e696e672c206a75737420636f6465642076696265732e20496620796f7572652072656164696e6720746869732c20796f75206469646e74207374756d626c6520696e2e0a596f75726520726967687420776865726520796f752077616e7420746f2062652e0a0a4d6f766965204e6967687473206f6e20582c204c6971756964697479206c6f636b207570732c20456e646c657373206d656d65730a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMC>>(v4);
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

