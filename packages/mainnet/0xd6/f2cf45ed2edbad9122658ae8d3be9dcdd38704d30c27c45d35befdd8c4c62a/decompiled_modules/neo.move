module 0xd6f2cf45ed2edbad9122658ae8d3be9dcdd38704d30c27c45d35befdd8c4c62a::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ery4UfK4WNPvaf1BiXFTieHxGekLEq66kYrazVAtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEO         ")))), trim_right(b"neotrader.run                   "), trim_right(b"Neo is an innovative AI-powered autonomous trading bot designed to redefine decentralized trading on Pumpfun. Unlike traditional bots, Neo transparently displays its decision-making process and trade execution in real time, offering unparalleled insights into its strategy. By leveraging advanced learning algorithms, Ne"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEO>>(v4);
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

