module 0x9f2b9e4cf046ef3621857a947dc82935daa65c9f8d7054de80483c403e1be5dd::btc200 {
    struct BTC200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC200, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2TZ8fhGv6M3vVYL9WeRYWF9YCkZi2tJUbhquXWSMpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTC200>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTC200      ")))), trim_right(b"Bitcoin200K                     "), trim_right(b"BTC200 is a Solana-based community token built to celebrate Bitcoins journey to new milestones. Every time Bitcoin hits another $10K mark  $110K, $120K, $130K, and beyond  we distribute 2 million BTC200 tokens to holders whove connected their wallets on our site and meet the eligibility threshold. This isn't just a mem"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC200>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC200>>(v4);
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

