module 0xa497431e1827ef9bfd9bef25af9a563fcdef61f54a21b398cf45130f16922b07::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7PM5cSQH21GiQnP8MtyPCJ5Ckv2pJu3WHe8YkNx5Arbd.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GZ          ")))), trim_right(b"GoldenZebra                     "), trim_right(b"GoldenZebraCoin is an innovative project in the cryptocurrency sector that combines digital technologies with social commitment to animal welfare. Our ambition is to protect those animals that cannot defend themselves, while giving all supporters the opportunity to both contribute to the welfare of animals and reap the"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GZ>>(v4);
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

