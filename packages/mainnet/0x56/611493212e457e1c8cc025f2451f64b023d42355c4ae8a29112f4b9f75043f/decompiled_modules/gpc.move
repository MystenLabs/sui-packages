module 0x56611493212e457e1c8cc025f2451f64b023d42355c4ae8a29112f4b9f75043f::gpc {
    struct GPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/34BsqqFydK4SscDo7vb2RctEmkg1gH1sr2iEnGC6bonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GPC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GPC         ")))), trim_right(b"giant penis coin                "), trim_right(x"476967616e7469632050656e697320436f696e2028244750432920204465736372697074696f6e0a2447504320697320746865206d6f7374206162737572646c79206f766572636f6e666964656e74206d656d6520636f696e206f6e20536f6c616e612e204275696c7420746f206265206269676765722c206c6f756465722c20616e64206c6f6e6765722d6c617374696e67207468616e2074686520726573742c20244750432063656c6562726174657320746865207269646963756c6f75732073696465206f662063727970746f207768696c65207061636b696e67207265616c20646567656e20656e657267792e0a5769746820636f6d6d756e6974792d64726976656e206368616f732c206d656d652d6675656c6564206d61726b6574696e672c20616e642074686520756e73746f707061626c6520666f72636520"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPC>>(v4);
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

