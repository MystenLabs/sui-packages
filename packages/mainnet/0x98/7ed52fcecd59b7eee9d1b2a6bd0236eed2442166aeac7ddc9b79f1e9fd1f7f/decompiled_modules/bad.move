module 0x987ed52fcecd59b7eee9d1b2a6bd0236eed2442166aeac7ddc9b79f1e9fd1f7f::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bi4FkWDdWMm1CCfuQnXtpALC6nRscRZTxVXLbeJspump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAD         ")))), trim_right(b"BaddiesCoin                     "), trim_right(x"204261646469657320436f696e20282442414429202054686520556c74696d6174652043727970746f20666f72204261646469657321200a0a20536f6c616e612d706f776572656420746f6b656e20626c656e64696e6720736f6369616c206d6564696120262063727970746f0a204e657720626164646965206665617475726564206576657279203135206d696e200a2043726561746f72732073656e64202442414420746f20676574207468652073706f746c69676874200a0a4e6f207072652d73616c6573202d204a6f696e2074686520626164646965207265766f6c7574696f6e206e6f77212023537461794241442020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAD>>(v4);
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

