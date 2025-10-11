module 0xd4a24497451f021f1944b50c5c6397491bb348e4360915dbf433eefdd2da76be::tck {
    struct TCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/1TNEM_vZkF8_Hm6Zsins125lyRqGkRKJtmuTIzDoC6A";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/1TNEM_vZkF8_Hm6Zsins125lyRqGkRKJtmuTIzDoC6A"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TCK>(arg0, 9, trim_right(b"TCK"), trim_right(b"TrackCoin"), trim_right(b"TrackCoin is a decentralized utility token focused on the global racing ecosystem. Built on a high-throughput blockchain protocol, it focuses on \"empowering fans and activating the value of the track\" and breaks through the barriers to integration between traditional racing, e-sports, and digital assets."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCK>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TCK>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCK>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

