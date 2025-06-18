module 0xc72445df5f2b3945bbc7311294dceac5fec349827c0d9455477be46624b1014e::oilcoin {
    struct OILCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OILCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cwn9d1E636CPBTgtPXZAuqn6TgUh6mPpUMBr3w7kpump.png?claimId=o8QtpXANwQ0j4Lwu                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OILCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OILCOIN     ")))), trim_right(b"Oil Coin                        "), trim_right(x"244f494c43206973206e6f77206f776e65642062792050726f6a6563742043202061207265616c207465616d20746f6b656e697a696e67207265616c2d776f726c6420656e65726779206173736574732e204c6971756964697479206c6f636b65642e204e6f206465762073656c6c732e204261636b6564206279207265616c20666f756e646572732e204d656d6573206d656574206d697373696f6e2e0a5765206469646e74206c61756e636820244f494c432e20576520746f6f6b206974206f76657220616e642077657265206275696c64696e6720736f6d657468696e67206269676765722e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OILCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OILCOIN>>(v4);
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

